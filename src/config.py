import os
from dotenv import load_dotenv

load_dotenv()

DB_CONFIG = {
    "host": os.getenv("DB_HOST", "localhost"),
    "port": int(os.getenv("DB_PORT", 5432)),
    "dbname": os.getenv("DB_NAME", "BI_SDM"),
    "user": os.getenv("DB_USER", "postgres"),
    "password": os.getenv("DB_PASS", "your_password")
}

DATA_DIR = os.getenv("DATA_DIR", "./data/raw")

FILES = {
    "dosen_fif": "Data Dosen FIF.xlsx",
    "pegawai_fif": "Data Pegawai FIF 2026.xlsx",
    "tugas_belajar": "Data Tugas Belajar.xlsx",
    "plotting_edom": "2627-1_Plotting Pengajaran FIF (1).xlsx",
    "penelitian_25_tw3": "Laptri Penelitian TW 3 2025.xlsx",
    "penelitian_25_tw4": "Laptri Penelitian TW 4 2025.xlsx",
    "penelitian_26_tw1": "Laptri Penelitian TW1 2026.xlsx",
    "penelitian_26_tw2": "Laptri Penelitian TW2 2026.xlsx",
    "abdimas_25_tw3": "LapTri-Abdimas-2025 TW-3.xlsx",
    "abdimas_25_tw4": "LapTri-Abdimas-2025 TW-4.xlsx",
    "abdimas_26_tw1": "Laptri Abdimas TW1 2026.xlsx",
    "abdimas_26_tw2": "Laptri Abdimas TW2 2026.xlsx",
    "publikasi_25_tw4": "LapTri-Publikasi TW4 2025.xlsx",
    "publikasi_26_tw2": "Laptri Publikasi TW2 2026.xlsx",
}

UNIT_MAPPING = {
    "S1 INFORMATIKA": ("S1 Informatika", "Program Studi"),
    "PROGRAM STUDI S1 INFORMATIKA (FIF)": ("S1 Informatika", "Program Studi"),
    "S1 PJJ INFORMATIKA": ("S1 PJJ Informatika", "Program Studi"),
    "PROGRAM STUDI S1 PJJ INFORMATIKA (FIF)": ("S1 PJJ Informatika", "Program Studi"),
    "S1 INFORMATIKA KAMPUS JAKARTA": ("S1 Informatika Kampus Jakarta", "Program Studi"),
    "PROGRAM STUDI S1 INFORMATIKA KAMPUS JAKARTA (FIF)": ("S1 Informatika Kampus Jakarta", "Program Studi"),
    "S1 TEKNOLOGI INFORMASI": ("S1 Teknologi Informasi", "Program Studi"),
    "PROGRAM STUDI S1 TEKNOLOGI INFORMASI (FIF)": ("S1 Teknologi Informasi", "Program Studi"),
    "S1 TEKNOLOGI INFORMASI KAMPUS JAKARTA": ("S1 Teknologi Informasi Kampus Jakarta", "Program Studi"),
    "PROGRAM STUDI S1 TEKNOLOGI INFORMASI KAMPUS JAKARTA (FIF)": ("S1 Teknologi Informasi Kampus Jakarta", "Program Studi"),
    "S1 RPL": ("S1 Rekayasa Perangkat Lunak", "Program Studi"),
    "S1 REKAYASA PERANGKAT LUNAK": ("S1 Rekayasa Perangkat Lunak", "Program Studi"),
    "PROGRAM STUDI S1 REKAYASA PERANGKAT LUNAK (FIF)": ("S1 Rekayasa Perangkat Lunak", "Program Studi"),
    "S1 SAINS DATA": ("S1 Sains Data", "Program Studi"),
    "PROGRAM STUDI S1 SAINS DATA (FIF)": ("S1 Sains Data", "Program Studi"),
    "S2 INFORMATIKA": ("S2 Informatika", "Program Studi"),
    "PROGRAM STUDI S2 INFORMATIKA (FIF)": ("S2 Informatika", "Program Studi"),
    "S2 ILMU FORENSIK": ("S2 Ilmu Forensik", "Program Studi"),
    "PROGRAM STUDI S2 ILMU FORENSIK (FIF)": ("S2 Ilmu Forensik", "Program Studi"),
    "S3 INFORMATIKA": ("S3 Informatika", "Program Studi"),
    "PROGRAM STUDI S3 INFORMATIKA (FIF)": ("S3 Informatika", "Program Studi"),
    "SEKRETARIAT FIF": ("Sekretariat FIF", "Unit Pendukung"),
    "URUSAN KEMAHASISWAAN (FIF)": ("Urusan Kemahasiswaan FIF", "Unit Pendukung"),
    "URUSAN SUMBER DAYA (FIF)": ("Urusan Sumber Daya FIF", "Unit Pendukung"),
    "URUSAN LAYANAN AKADEMIK (FIF)": ("Urusan Layanan Akademik FIF", "Unit Pendukung"),
    "URUSAN LABORATORIUM (FIF)": ("Urusan Laboratorium FIF", "Unit Pendukung"),
}

POSITION_MAPPING = {
    "GURU BESAR": ("Akademik", "Guru Besar"),
    "LEKTOR KEPALA": ("Akademik", "Lektor Kepala"),
    "LEKTOR": ("Akademik", "Lektor"),
    "ASISTEN AHLI": ("Akademik", "Asisten Ahli"),
    "NJAD": ("Akademik", "NJAD"),
    "NON JABATAN FUNGSIONAL AKADEMIK": ("Akademik", "NJAD"),
    "TENAGA PENGAJAR": ("Akademik", "NJAD"),
    "MADYA 1": ("TPA", "Madya 1"),
    "MADYA 2": ("TPA", "Madya 2"),
    "MUDA 1": ("TPA", "Muda 1"),
    "MUDA 2": ("TPA", "Muda 2"),
    "PRATAMA 1": ("TPA", "Pratama 1"),
}

STATUS_MAPPING = {
    "PEGAWAI TETAP": "Pegawai Tetap",
    "DOSEN PEGAWAI TETAP": "Pegawai Tetap",
    "DOSEN PROFESIONAL (FULL TIME)": "Dosen Profesional Full Time",
    "DOSEN PROFESIONAL FULL TIME": "Dosen Profesional Full Time",
    "DOSEN PROFESIONAL (PART TIME)": "Dosen Profesional Part Time",
    "DOSEN LUAR BIASA": "Dosen Luar Biasa",
    "CALON PEGAWAI TETAP": "Calon Pegawai Tetap",
    "PEGAWAI KONTRAK": "Pegawai Kontrak",
    "MAGANG": "Tenaga Layanan Harian / Magang",
}
