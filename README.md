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
```

## Cara Menjalankan

1. Install dependensi:
   ```bash
   pip install -r requirements.txt
   ```
2. Salin `.env.example` menjadi `.env`, lalu sesuaikan kredensial PostgreSQL dan path folder dataset (`DATA_DIR`).
3. Buat database `BI_SDM` di PostgreSQL, lalu jalankan pipeline:
   ```bash
   python main.py
   ```


### Opsi Cepat: Restore Database dari File Dump (Untuk Tim Dashboard)

Jika tidak ingin menjalankan ulang pipeline Python ETL dari awal, anggota tim dapat langsung melakukan *restore* database yang sudah bersih menggunakan file `sql/bi_sdm_dump.sql`:

1. Buat database kosong bernama `BI_SDM` di PostgreSQL (melalui pgAdmin atau `psql`).
2. Jalankan perintah berikut di terminal:
   ```bash
   psql -U postgres -d BI_SDM -f sql/bi_sdm_dump.sql