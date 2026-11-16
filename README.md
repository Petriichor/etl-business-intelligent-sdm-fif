# ETL Pipeline — Data Warehouse Kinerja SDM & Tridharma FIF

Pipeline ETL modular berbasis Python untuk mengintegrasikan 14 dataset SDM, pengajaran (EDOM), penelitian, pengabdian masyarakat (Abdimas), dan publikasi Fakultas Informatika (FIF) Telkom University ke dalam **Star Schema PostgreSQL (`BI_SDM`)**.

## Struktur Direktori
```text
├── sql/
│   └── ddl_bi_sdm.sql       # DDL Star Schema (Dimensi & Fakta)
├── src/
│   ├── config.py            # Konfigurasi koneksi DB & kamus normalisasi
│   ├── extract.py           # Ekstraksi sheet target dari 14 file Excel
│   ├── transform.py         # Pembersihan string, Tiered Entity Resolution & agregasi
│   └── load.py              # Pembentukan skema & bulk load ke PostgreSQL
├── main.py                  # Orkestrator utama pipeline ETL
├── .env.example             # Template konfigurasi environment
└── requirements.txt         # Daftar dependensi Python