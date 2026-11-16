from src.extract import extract_all
from src.transform import transform_all
from src.load import load_to_postgres


def run_pipeline():
    print("1. [EXTRACT] Membaca 14 file Excel SDM & Tridharma FIF...")
    raw_data = extract_all()
    print(f"   Berhasil memuat {len(raw_data)} sheet staging.")

    print("2. [TRANSFORM] Menjalankan Entity Resolution & pembentukan Star Schema...")
    star_data = transform_all(raw_data)
    for tbl in ["dim_staff", "dim_time", "dim_unit", "dim_education", "dim_position", "dim_employment_status", "fact_staff_performance"]:
        print(f"   - {tbl}: {len(star_data[tbl])} baris")

    unmatched = star_data["unmatched_log"]
    if not unmatched.empty:
        unmatched.to_csv("unmatched_entities_audit.csv", index=False)
        print(f"   - Audit log: {len(unmatched)} entitas eksternal/tidak cocok disimpan ke unmatched_entities_audit.csv")

    print("3. [LOAD] Memuat data ke PostgreSQL (BI_SDM)...")
    load_to_postgres(star_data)


if __name__ == "__main__":
    run_pipeline()