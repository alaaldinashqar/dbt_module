CREATE TABLE mart_route_stats AS
SELECT
    f.origin AS origin_airport_code,
    f.dest AS destination_airport_code,
    COUNT(*) AS total_flights,
    COUNT(DISTINCT f.tail_number) AS unique_airplanes,
    COUNT(DISTINCT f.airline) AS unique_airlines,
    AVG(f.actual_elapsed_time) AS avg_actual_elapsed_time,
    AVG(f.arr_delay) AS avg_arrival_delay,
    MAX(f.arr_delay) AS max_arrival_delay,
    MIN(f.arr_delay) AS min_arrival_delay,
    SUM(CASE WHEN f.cancelled = 1 THEN 1 ELSE 0 END) AS total_cancelled,
    SUM(CASE WHEN f.diverted = 1 THEN 1 ELSE 0 END) AS total_diverted,
    a.city AS origin_city,
    a.country AS origin_country,
    a.faa AS origin_airport_name,
    d.city AS destination_city,
    d.country AS destination_country,
    d.faa AS destination_airport_name
FROM 
    {{ref('mart_route_stats')}} 
JOIN 
    airports a ON f.origin = a.faa
JOIN 
    airports d ON f.dest = d.faa
GROUP BY
    f.origin,
    f.dest,
    a.city, a.country, a.faa,
    d.city, d.country, d.faa