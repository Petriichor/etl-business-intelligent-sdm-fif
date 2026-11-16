CREATE TABLE IF NOT EXISTS dim_staff (
    staff_key       SERIAL PRIMARY KEY,
    staff_id        VARCHAR(20),         
    staff_name      VARCHAR(200) NOT NULL,
    nip             VARCHAR(30),
    staff_type      VARCHAR(20) NOT NULL,
    is_active       BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_dim_staff_nip ON dim_staff(nip);
CREATE INDEX IF NOT EXISTS idx_dim_staff_id ON dim_staff(staff_id);

CREATE TABLE IF NOT EXISTS dim_time (
    time_key        INTEGER PRIMARY KEY,  
    year            INTEGER NOT NULL,
    quarter         INTEGER NOT NULL,
    semester        VARCHAR(20) NOT NULL,
    period_label    VARCHAR(30) NOT NULL 
);

CREATE TABLE IF NOT EXISTS dim_education (
    education_key   SERIAL PRIMARY KEY,
    education_level VARCHAR(50) NOT NULL UNIQUE, 
    education_group VARCHAR(50) NOT NULL        
);

CREATE TABLE IF NOT EXISTS dim_position (
    position_key    SERIAL PRIMARY KEY,
    position_type   VARCHAR(50) NOT NULL,       
    position_name   VARCHAR(100) NOT NULL UNIQUE 
);

CREATE TABLE IF NOT EXISTS dim_employment_status (
    employment_status_key   SERIAL PRIMARY KEY,
    employment_status_name  VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS dim_unit (
    unit_key        SERIAL PRIMARY KEY,
    unit_name       VARCHAR(150) NOT NULL UNIQUE,
    unit_category   VARCHAR(50) NOT NULL         
);

CREATE TABLE IF NOT EXISTS fact_staff_performance (
    fact_id                     SERIAL PRIMARY KEY,
    staff_key                   INTEGER NOT NULL REFERENCES dim_staff(staff_key),
    time_key                    INTEGER NOT NULL REFERENCES dim_time(time_key),
    education_key               INTEGER NOT NULL REFERENCES dim_education(education_key),
    position_key                INTEGER NOT NULL REFERENCES dim_position(position_key),
    employment_status_key       INTEGER NOT NULL REFERENCES dim_employment_status(employment_status_key),
    unit_key                    INTEGER NOT NULL REFERENCES dim_unit(unit_key),
    staff_count                 INTEGER NOT NULL DEFAULT 1,
    dosen_count                 INTEGER NOT NULL DEFAULT 0,
    tpa_count                   INTEGER NOT NULL DEFAULT 0,
    publication_count           INTEGER NOT NULL DEFAULT 0,
    avg_edom_score              NUMERIC(5,2),
    research_project_count      INTEGER NOT NULL DEFAULT 0,
    abdimas_count               INTEGER NOT NULL DEFAULT 0,
    abdimas_participation_flag  INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT uq_fact_staff_time UNIQUE (staff_key, time_key)
);