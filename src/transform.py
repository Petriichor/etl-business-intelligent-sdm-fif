import re
import pandas as pd
import numpy as np
from src.config import UNIT_MAPPING, POSITION_MAPPING, STATUS_MAPPING


# ==========================================
# 1. FUNGSI PEMBERSIHAN & NORMALISASI STRING
# ==========================================

PREFIX_TITLES = r"^(prof|dr|ir|drs|dra|h|hj|kh|ust|ns|apt|Ns|Dr|Prof|Ir)\.?\s+"
SUFFIX_TITLES = (
    r",?\s*\b("
    r"s\.?t|m\.?t|s\.?kom|m\.?kom|s\.?si|m\.?si|s\.?pd|m\.?pd|s\.?e|m\.?m|m\.?b\.?a|"
    r"s\.?h|m\.?h|s\.?ip|m\.?i\.?kom|s\.?sos|m\.?sc|ph\.?d|m\.?eng|d\.?eng|s\.?ap|"
    r"s\.?kom\.?i|s\.?stat|m\.?stat|s\.?ds|m\.?ds|s\.?ti|m\.?ti|s\.?tr\.?kom|m\.?tr\.?kom|"
    r"ipm|ipu|asean\s*eng|ceh|cissp|aws"
    r")\.?\b"
)


def clean_human_name(raw_name) -> str:
    if pd.isna(raw_name):
        return ""
    text = str(raw_name).replace("\xa0", " ").replace("\n", " ").strip()
    text = re.sub(r"\(.*?\)", "", text)
    for _ in range(3):
        text = re.sub(PREFIX_TITLES, "", text, flags=re.IGNORECASE).strip()
    if "," in text:
        text = text.split(",")[0]
    text = re.sub(SUFFIX_TITLES, "", text, flags=re.IGNORECASE)
    text = re.sub(r"[^A-Za-z\s]", " ", text)
    text = re.sub(r"\s+", " ", text).strip()
    return text.title()


def make_name_key(raw_name) -> str:
    cleaned = clean_human_name(raw_name)
    return re.sub(r"\s+", "", cleaned).upper()


def clean_nip(val) -> str | None:
    if pd.isna(val):
        return None
    digits = re.sub(r"\D", "", str(val).split(".")[0])
    return digits if len(digits) >= 6 else None


def clean_kode(val) -> str | None:
    if pd.isna(val):
        return None
    code = re.sub(r"[^A-Za-z]", "", str(val)).upper()
    return code if len(code) == 3 else None


def normalize_unit(raw_unit) -> tuple[str, str]:
    if pd.isna(raw_unit) or not str(raw_unit).strip():
        return ("Unknown", "Unknown")
    key = re.sub(r"\s+", " ", str(raw_unit)).strip().upper()
    if key in UNIT_MAPPING:
        return UNIT_MAPPING[key]
    if "(FIF)" in key or "INFORMATIKA" in key or "SAINS DATA" in key or "REKAYASA PERANGKAT LUNAK" in key or "TEKNOLOGI INFORMASI" in key or "ILMU FORENSIK" in key:
        return (str(raw_unit).strip().title(), "Program Studi")
    return (str(raw_unit).strip().title(), "Eksternal/Non-FIF")


def normalize_education(raw_edu) -> tuple[str, str]:
    if pd.isna(raw_edu) or not str(raw_edu).strip() or str(raw_edu).strip() == "-":
        return ("Unknown", "Unknown")
    val = str(raw_edu).strip().upper()
    if "S3" in val or "DOKTOR" in val:
        return ("S3", "Pascasarjana")
    if "S2" in val or "MAGISTER" in val:
        return ("S2", "Pascasarjana")
    if "S1" in val or "D4" in val or "SARJANA" in val:
        return ("S1/D4", "Sarjana")
    if "D3" in val or "D2" in val or "D1" in val:
        return ("Diploma", "Non-Sarjana")
    if "SMA" in val or "SMK" in val:
        return ("SMA/SMK", "Non-Sarjana")
    return ("Unknown", "Unknown")


def normalize_position(raw_pos, staff_type="DOSEN") -> tuple[str, str]:
    if pd.isna(raw_pos) or not str(raw_pos).strip() or str(raw_pos).strip() == "-":
        return ("TPA", "Non-JFA TPA") if staff_type == "TPA" else ("Unknown", "Unknown")
    key = re.sub(r"\s+", " ", str(raw_pos)).strip().upper()
    if key in POSITION_MAPPING:
        return POSITION_MAPPING[key]
    return ("TPA" if staff_type == "TPA" else "Akademik", str(raw_pos).strip().title())


def normalize_status(raw_status) -> str:
    if pd.isna(raw_status) or not str(raw_status).strip():
        return "Unknown"
    key = re.sub(r"\s+", " ", str(raw_status)).strip().upper()
    return STATUS_MAPPING.get(key, str(raw_status).strip().title())


# ==========================================
# 2. GOLDEN RECORD & TIERED ENTITY RESOLUTION
# ==========================================

class StaffResolver:

    def __init__(self):
        self.records = []      
        self.by_nip = {}       
        self.by_kode = {}      
        self.by_name_key = {}  
        self.unmatched_log = []

    def upsert_staff(self, name, nip=None, kode=None, staff_type="DOSEN", is_active=True,
                     unit=("Unknown", "Unknown"), edu=("Unknown", "Unknown"),
                     pos=("Unknown", "Unknown"), status="Unknown", allow_create=True) -> int | None:
        nip_c = clean_nip(nip)
        kode_c = clean_kode(kode)
        name_clean = clean_human_name(name)
        name_k = make_name_key(name)

        if not name_k and not nip_c and not kode_c:
            return None

        idx = self.by_nip.get(nip_c) if nip_c else None
        if idx is None and kode_c:
            idx = self.by_kode.get(kode_c)
        if idx is None and name_k:
            idx = self.by_name_key.get(name_k)

        if idx is not None:
            rec = self.records[idx]
            if not rec["nip"] and nip_c:
                rec["nip"] = nip_c
                self.by_nip[nip_c] = idx
            if not rec["staff_id"] and kode_c:
                rec["staff_id"] = kode_c
                self.by_kode[kode_c] = idx
            if rec["unit"] == ("Unknown", "Unknown") and unit != ("Unknown", "Unknown"):
                rec["unit"] = unit
            if rec["edu"] == ("Unknown", "Unknown") and edu != ("Unknown", "Unknown"):
                rec["edu"] = edu
            if rec["pos"] == ("Unknown", "Unknown") and pos != ("Unknown", "Unknown"):
                rec["pos"] = pos
            if rec["status"] == "Unknown" and status != "Unknown":
                rec["status"] = status
            return idx

        if not allow_create:
            self.unmatched_log.append({"raw_name": name, "nip": nip_c, "kode": kode_c})
            return None

        idx = len(self.records)
        self.records.append({
            "staff_id": kode_c,
            "staff_name": name_clean or f"Staff-{nip_c or kode_c}",
            "nip": nip_c,
            "staff_type": staff_type,
            "is_active": bool(is_active),
            "unit": unit,
            "edu": edu,
            "pos": pos,
            "status": status,
        })
        if nip_c:
            self.by_nip[nip_c] = idx
        if kode_c:
            self.by_kode[kode_c] = idx
        if name_k:
            self.by_name_key[name_k] = idx
        return idx


def build_golden_staff(raw: dict) -> StaffResolver:
    resolver = StaffResolver()

    for _, r in raw["pegawai_dosen"].iterrows():
        if pd.isna(pd.to_numeric(r.get("No"), errors="coerce")):
            continue
        nama = r.get("NAMA PEGAWAI TANPA GELAR") or r.get("NAMA FULL GELAR DOSEN TUB")
        if pd.isna(nama):
            continue
        aktif = str(r.get("STATUS SAAT INI", "")).strip().upper() == "AKTIF"
        resolver.upsert_staff(
            name=nama,
            nip=r.get("NIP"),
            kode=r.get("KODE"),
            staff_type="DOSEN",
            is_active=aktif,
            unit=normalize_unit(r.get("PROGRAM STUDI")),
            edu=normalize_education(r.get("Pendidikan Terakhir")),
            pos=normalize_position(r.get("JFA"), "DOSEN"),
            status=normalize_status(r.get("STATUS KEPEGAWAIAN"))
        )

    for _, r in raw["dosen_fif"].iterrows():
        if pd.isna(pd.to_numeric(r.get("F"), errors="coerce")):
            continue
        if pd.isna(r.get("Nama")):
            continue
        resolver.upsert_staff(
            name=r.get("Nama"),
            kode=r.get("Kode Dosen"),
            staff_type="DOSEN",
            unit=normalize_unit(r.get("Program Studi"))
        )

    for _, r in raw["pegawai_staff"].iterrows():
        if pd.isna(pd.to_numeric(r.get("NO"), errors="coerce")):
            continue
        if pd.isna(r.get("NAMA LENGKAP")):
            continue
        resolver.upsert_staff(
            name=r.get("NAMA LENGKAP"),
            nip=r.get("NIP"),
            kode=None,
            staff_type="TPA",
            is_active=True,
            unit=normalize_unit(r.get("POSISI KERJA")),
            edu=normalize_education(r.get("PDD Terakhir")),
            pos=normalize_position(r.get("Jabfung TPA"), "TPA"),
            status=normalize_status(r.get("STATUS KEPEGAWAIAN"))
        )

    if "NAMA" in raw["pegawai_tlh"].columns:
        no_col = raw["pegawai_tlh"].columns[0]  
        for _, r in raw["pegawai_tlh"].iterrows():
            if pd.isna(pd.to_numeric(r.get(no_col), errors="coerce")):
                continue
            if pd.isna(r.get("NAMA")):
                continue
            aktif = "AKTIF" in str(r.get("Status", "")).upper()
            resolver.upsert_staff(
                name=r.get("NAMA"),
                nip=r.get("NIP"),
                staff_type="TPA",
                is_active=aktif,
                unit=normalize_unit(r.get("LOKASI KERJA")),
                edu=normalize_education(r.get("PDD")),
                pos=("TPA", "Tenaga Layanan Harian"),
                status="Tenaga Layanan Harian / Magang"
            )

    for _, r in raw["dosen_ref_14jul"].iterrows():
        fak = str(r.get("Fakultas Anggota", "")).upper()
        if "INFORMATIKA" in fak:
            resolver.upsert_staff(
                name=r.get("Nama") or r.get("Nama Lengkap Anggota"),
                nip=r.get("NIP Anggota"),
                kode=r.get("Kode Dosen"),
                staff_type="DOSEN",
                unit=normalize_unit(r.get("Prodi Anggota")),
                edu=normalize_education(r.get("Pendidikan Anggota")),
                pos=normalize_position(r.get("Jafung Anggota"), "DOSEN")
            )

    for _, r in raw["dosen_ref_2601"].iterrows():
        fak = str(r.get("Fakultas", "")).upper()
        if "INFORMATIKA" in fak:
            resolver.upsert_staff(
                name=r.get("Nama (Tanpa gelar)") or r.get("Nama Lengkap"),
                kode=r.get("Kode Dosen"),
                staff_type="DOSEN",
                unit=normalize_unit(r.get("Prodi")),
                edu=normalize_education(r.get("Pendidikan Akhir")),
                pos=normalize_position(r.get("Jafung"), "DOSEN"),
                status=normalize_status(r.get("Status Pegawai"))
            )

    return resolver


# ==========================================
# 3. EKSTRAKSI AKTIVITAS TRIDHARMA & EDOM
# ==========================================

def extract_penelitian_events(raw: dict, resolver: StaffResolver) -> pd.DataFrame:
    sources = [
        (raw["penelitian_25_tw3"], 2025, 3),
        (raw["penelitian_25_tw4"], 2025, 4),
        (raw["penelitian_26_tw1"], 2026, 1),
        (raw["penelitian_26_tw2"], 2026, 2),
    ]
    rows = []
    for df, year, quarter in sources:
        time_key = year * 10 + quarter
        for _, r in df.iterrows():
            judul = str(r.get("JUDUL PENELITIAN", "")).strip()
            if not judul or judul.lower() == "nan":
                continue
            judul_key = re.sub(r"\W+", "", judul).upper()

            members = [(r.get("NAMA KETUA TIM"), r.get("kODE DOSEN KETUA") or r.get("KODE DOSEN KETUA"))]
            for i in range(1, 12):
                members.append((r.get(f"NAMA ANGGOTA {i}"), r.get(f"KODE DOSEN ANGGOTA {i}")))

            for nama, kode in members:
                if pd.isna(nama) and pd.isna(kode):
                    continue
                idx = resolver.upsert_staff(name=nama, kode=kode, allow_create=False)
                if idx is not None:
                    rows.append({"staff_idx": idx, "time_key": time_key, "judul_key": judul_key})

    if not rows:
        return pd.DataFrame(columns=["staff_idx", "time_key", "research_project_count"])

    df_res = pd.DataFrame(rows).drop_duplicates(subset=["staff_idx", "time_key", "judul_key"])
    return df_res.groupby(["staff_idx", "time_key"]).size().reset_index(name="research_project_count")


def extract_abdimas_events(raw: dict, resolver: StaffResolver) -> pd.DataFrame:
    sources = [
        (raw["abdimas_25_tw3"], 2025, 3),
        (raw["abdimas_25_tw4"], 2025, 4),
        (raw["abdimas_26_tw1"], 2026, 1),
        (raw["abdimas_26_tw2"], 2026, 2),
    ]
    rows = []
    for df, year, quarter in sources:
        time_key = year * 10 + quarter
        for _, r in df.iterrows():
            judul = str(r.get("Judul PKM", "")).strip()
            if not judul or judul.lower() == "nan":
                continue
            judul_key = re.sub(r"\W+", "", judul).upper()

            tim_raw = f"{r.get('Tim Abdimas 1', '')}\n{r.get('Tim Abdimas 2', '')}"
            for line in tim_raw.splitlines():
                line = line.strip()
                if not line or line.lower() == "nan":
                    continue
                nip_match = re.search(r"NIP\s*:\s*(\d+)", line, flags=re.IGNORECASE)
                nip_val = nip_match.group(1) if nip_match else None
                idx = resolver.upsert_staff(name=line, nip=nip_val, allow_create=False)
                if idx is not None:
                    rows.append({"staff_idx": idx, "time_key": time_key, "judul_key": judul_key})

    if not rows:
        return pd.DataFrame(columns=["staff_idx", "time_key", "abdimas_count"])

    df_abd = pd.DataFrame(rows).drop_duplicates(subset=["staff_idx", "time_key", "judul_key"])
    return df_abd.groupby(["staff_idx", "time_key"]).size().reset_index(name="abdimas_count")


def extract_publikasi_events(raw: dict, resolver: StaffResolver) -> pd.DataFrame:
    sources = [
        (raw["publikasi_25_tw4"], 2025),
        (raw["publikasi_26_tw2"], 2026),
    ]
    rows = []
    for df, year in sources:
        for _, r in df.iterrows():
            judul = str(r.get("Judul Artikel", "")).strip()
            if not judul or judul.lower() == "nan":
                continue
            judul_key = re.sub(r"\W+", "", judul).upper()

            tw_str = str(r.get("TW", "")).upper()
            q_match = re.search(r"(\d)", tw_str)
            quarter = int(q_match.group(1)) if q_match else 4
            time_key = year * 10 + quarter

            penulis_raw = str(r.get("Tim Penulis Dosen", ""))
            for nama in penulis_raw.splitlines():
                nama = nama.strip()
                if not nama or nama.lower() == "nan":
                    continue
                idx = resolver.upsert_staff(name=nama, allow_create=False)
                if idx is not None:
                    rows.append({"staff_idx": idx, "time_key": time_key, "judul_key": judul_key})

    if not rows:
        return pd.DataFrame(columns=["staff_idx", "time_key", "publication_count"])

    df_pub = pd.DataFrame(rows).drop_duplicates(subset=["staff_idx", "time_key", "judul_key"])
    return df_pub.groupby(["staff_idx", "time_key"]).size().reset_index(name="publication_count")


def extract_edom_scores(raw: dict, resolver: StaffResolver) -> dict:
    edom_map = {}
    df = raw["edom"]
    for _, r in df.iterrows():
        kode = r.get("Kode")
        nama = r.get("Dosen")
        score = pd.to_numeric(r.get("Rata-Rata EDOM"), errors="coerce")
        if pd.isna(score) or score <= 0:
            continue
        idx = resolver.upsert_staff(name=nama, kode=kode, allow_create=False)
        if idx is not None:
            edom_map[idx] = round(float(score), 2)
    return edom_map


# ==========================================
# 4. ASSEMBLY STAR SCHEMA TABLES
# ==========================================

def transform_all(raw: dict) -> dict:
    resolver = build_golden_staff(raw)

    df_pen = extract_penelitian_events(raw, resolver)
    df_abd = extract_abdimas_events(raw, resolver)
    df_pub = extract_publikasi_events(raw, resolver)
    edom_map = extract_edom_scores(raw, resolver)

    # DIM_TIME 
    dim_time = pd.DataFrame([
        {"time_key": 20253, "year": 2025, "quarter": 3, "semester": "Ganjil", "period_label": "2025-Q3"},
        {"time_key": 20254, "year": 2025, "quarter": 4, "semester": "Ganjil", "period_label": "2025-Q4"},
        {"time_key": 20261, "year": 2026, "quarter": 1, "semester": "Genap",  "period_label": "2026-Q1"},
        {"time_key": 20262, "year": 2026, "quarter": 2, "semester": "Genap",  "period_label": "2026-Q2"},
    ])

    # DIM_STAFF
    dim_staff_rows = []
    for i, rec in enumerate(resolver.records, start=1):
        dim_staff_rows.append({
            "staff_key": i,
            "staff_id": rec["staff_id"],
            "staff_name": rec["staff_name"],
            "nip": rec["nip"],
            "staff_type": rec["staff_type"],
            "is_active": rec["is_active"],
        })
    dim_staff = pd.DataFrame(dim_staff_rows)

    edus = sorted({rec["edu"] for rec in resolver.records} | {("Unknown", "Unknown")})
    dim_education = pd.DataFrame([
        {"education_key": i, "education_level": e[0], "education_group": e[1]}
        for i, e in enumerate(edus, start=1)
    ])
    edu_lookup = {(r.education_level, r.education_group): r.education_key for r in dim_education.itertuples()}

    poss = sorted({rec["pos"] for rec in resolver.records} | {("Unknown", "Unknown")})
    dim_position = pd.DataFrame([
        {"position_key": i, "position_type": p[0], "position_name": p[1]}
        for i, p in enumerate(poss, start=1)
    ])
    pos_lookup = {(r.position_type, r.position_name): r.position_key for r in dim_position.itertuples()}

    statuses = sorted({rec["status"] for rec in resolver.records} | {"Unknown"})
    dim_employment_status = pd.DataFrame([
        {"employment_status_key": i, "employment_status_name": s}
        for i, s in enumerate(statuses, start=1)
    ])
    status_lookup = {r.employment_status_name: r.employment_status_key for r in dim_employment_status.itertuples()}

    units = sorted({rec["unit"] for rec in resolver.records} | {("Unknown", "Unknown")})
    dim_unit = pd.DataFrame([
        {"unit_key": i, "unit_name": u[0], "unit_category": u[1]}
        for i, u in enumerate(units, start=1)
    ])
    unit_lookup = {(r.unit_name, r.unit_category): r.unit_key for r in dim_unit.itertuples()}

    pen_map = {(int(r.staff_idx), int(r.time_key)): int(r.research_project_count) for r in df_pen.itertuples()}
    abd_map = {(int(r.staff_idx), int(r.time_key)): int(r.abdimas_count) for r in df_abd.itertuples()}
    pub_map = {(int(r.staff_idx), int(r.time_key)): int(r.publication_count) for r in df_pub.itertuples()}

    fact_rows = []
    for idx, rec in enumerate(resolver.records):
        staff_key = idx + 1
        is_dosen = 1 if rec["staff_type"] == "DOSEN" else 0
        is_tpa = 1 if rec["staff_type"] == "TPA" else 0

        for tk in dim_time["time_key"]:
            res_cnt = pen_map.get((idx, tk), 0)
            abd_cnt = abd_map.get((idx, tk), 0)
            pub_cnt = pub_map.get((idx, tk), 0)
            edom_val = edom_map.get(idx) if is_dosen else None

            fact_rows.append({
                "staff_key": staff_key,
                "time_key": int(tk),
                "education_key": edu_lookup[rec["edu"]],
                "position_key": pos_lookup[rec["pos"]],
                "employment_status_key": status_lookup[rec["status"]],
                "unit_key": unit_lookup[rec["unit"]],
                "staff_count": 1,
                "dosen_count": is_dosen,
                "tpa_count": is_tpa,
                "publication_count": pub_cnt,
                "avg_edom_score": edom_val,
                "research_project_count": res_cnt,
                "abdimas_count": abd_cnt,
                "abdimas_participation_flag": 1 if abd_cnt > 0 else 0,
            })

    fact_staff_performance = pd.DataFrame(fact_rows)

    return {
        "dim_time": dim_time,
        "dim_staff": dim_staff,
        "dim_education": dim_education,
        "dim_position": dim_position,
        "dim_employment_status": dim_employment_status,
        "dim_unit": dim_unit,
        "fact_staff_performance": fact_staff_performance,
        "unmatched_log": pd.DataFrame(resolver.unmatched_log).drop_duplicates()
    }