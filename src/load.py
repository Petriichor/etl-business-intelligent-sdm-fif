import os
import pandas as pd
import psycopg2
from psycopg2.extras import execute_values
from src.config import DB_CONFIG


def _insert_df(cur, table_name: str, df: pd.DataFrame):
    if df.empty:
        return
    cols = list(df.columns)
    col_str = ", ".join(cols)
    records = [
        tuple(None if pd.isna(v) else v for v in row)
        for row in df.itertuples(index=False, name=None)
    ]
    sql = f"INSERT INTO {table_name} ({col_str}) VALUES %s"
    execute_values(cur, sql, records, page_size=500)


def load_to_postgres(transformed: dict, ddl_path: str = "sql/ddl_bi_sdm.sql"):
    conn = psycopg2.connect(**DB_CONFIG)
    try:
        with conn.cursor() as cur:            
            if os.path.exists(ddl_path):
                with open(ddl_path, "r", encoding="utf-8") as f:
                    cur.execute(f.read())
            
            cur.execute("""
                TRUNCATE TABLE
                    fact_staff_performance,
                    dim_staff,
                    dim_time,
                    dim_education,
                    dim_position,
                    dim_employment_status,
                    dim_unit
                RESTART IDENTITY CASCADE;
            """)

            _insert_df(cur, "dim_time", transformed["dim_time"])
            _insert_df(cur, "dim_staff", transformed["dim_staff"])
            _insert_df(cur, "dim_education", transformed["dim_education"])
            _insert_df(cur, "dim_position", transformed["dim_position"])
            _insert_df(cur, "dim_employment_status", transformed["dim_employment_status"])
            _insert_df(cur, "dim_unit", transformed["dim_unit"])

            _insert_df(cur, "fact_staff_performance", transformed["fact_staff_performance"])

        conn.commit()
        print("[SUCCESS] Seluruh data berhasil dimuat ke PostgreSQL database 'BI_SDM'.")
    except Exception as e:
        conn.rollback()
        print(f"[ERROR] Transaksi di-rollback karena terjadi kesalahan: {e}")
        raise
    finally:
        conn.close()