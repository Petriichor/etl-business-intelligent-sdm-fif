import os
import pandas as pd
from src.config import DATA_DIR, FILES


def _path(key: str) -> str:
    return os.path.join(DATA_DIR, FILES[key])


def extract_all() -> dict:
    raw = {}

    # 1. Master SDM & Kepegawaian FIF
    raw["dosen_fif"] = pd.read_excel(_path("dosen_fif"), sheet_name="Data Dosen ")
    raw["pegawai_dosen"] = pd.read_excel(_path("pegawai_fif"), sheet_name="Dosen TUB")
    raw["pegawai_staff"] = pd.read_excel(_path("pegawai_fif"), sheet_name="DATA STAFF")
    raw["pegawai_tlh"] = pd.read_excel(_path("pegawai_fif"), sheet_name="Data TLH Aktif FIF", skiprows=2)
    raw["tugas_belajar"] = pd.read_excel(_path("tugas_belajar"), sheet_name="Sheet1")

    raw["dosen_ref_2601"] = pd.read_excel(_path("penelitian_26_tw1"), sheet_name="Data Dosen 260105")
    raw["dosen_ref_14jul"] = pd.read_excel(_path("penelitian_25_tw3"), sheet_name="Dosen (14Juli25)")

    # 2. EDOM 
    raw["edom"] = pd.read_excel(_path("plotting_edom"), sheet_name="EDOM", skiprows=1)

    # 3. Laporan Triwulan Penelitian
    raw["penelitian_25_tw3"] = pd.read_excel(_path("penelitian_25_tw3"), sheet_name="TW 3 2025", skiprows=1)
    raw["penelitian_25_tw4"] = pd.read_excel(_path("penelitian_25_tw4"), sheet_name="TW 4 2025", skiprows=1)
    raw["penelitian_26_tw1"] = pd.read_excel(_path("penelitian_26_tw1"), sheet_name="TW 1 2026")
    raw["penelitian_26_tw2"] = pd.read_excel(_path("penelitian_26_tw2"), sheet_name="TW 2 2026")

    # 4. Laporan Triwulan Abdimas
    raw["abdimas_25_tw3"] = pd.read_excel(_path("abdimas_25_tw3"), sheet_name="TW")
    raw["abdimas_25_tw4"] = pd.read_excel(_path("abdimas_25_tw4"), sheet_name="Rekap Data Abdimas")
    raw["abdimas_26_tw1"] = pd.read_excel(_path("abdimas_26_tw1"), sheet_name="TW")
    raw["abdimas_26_tw2"] = pd.read_excel(_path("abdimas_26_tw2"), sheet_name="TW")

    # 5. Laporan Triwulan Publikasi
    raw["publikasi_25_tw4"] = pd.read_excel(_path("publikasi_25_tw4"), sheet_name="Rincian Publikasi")
    raw["publikasi_26_tw2"] = pd.read_excel(_path("publikasi_26_tw2"), sheet_name="Rincian Publikasi")

    for name, df in raw.items():
        df.columns = [str(c).strip() for c in df.columns]

    return raw