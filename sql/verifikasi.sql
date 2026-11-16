SELECT 
    t.period_label,
    COUNT(f.fact_id) AS total_sdm,
    SUM(f.dosen_count) AS total_dosen,
    SUM(f.tpa_count) AS total_tpa,
    SUM(f.research_project_count) AS total_penelitian,
    SUM(f.abdimas_count) AS total_abdimas,
    SUM(f.publication_count) AS total_publikasi,
    ROUND(AVG(f.avg_edom_score), 2) AS rata_rata_edom
FROM fact_staff_performance f
JOIN dim_time t ON f.time_key = t.time_key
GROUP BY t.time_key, t.period_label
ORDER BY t.time_key;

SELECT u.unit_name, u.unit_category, COUNT(DISTINCT f.staff_key) AS jumlah_sdm
FROM fact_staff_performance f
JOIN dim_unit u ON f.unit_key = u.unit_key
GROUP BY u.unit_name, u.unit_category
ORDER BY jumlah_sdm DESC;

SELECT * FROM fact_staff_performance

SELECT * FROM dim_staff

SELECT * FROM dim_position

SELECT * FROM dim_unit

SELECT * FROM dim_employment_status

SELECT * FROM dim_education

SELECT * FROM dim_time
