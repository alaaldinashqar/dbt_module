SELECT
    a.faa AS airport_code,
    COUNT(DISTINCT CASE WHEN f.origin = a.faa THEN f.dest END) AS unique_departure_connections,
    COUNT(DISTINCT CASE WHEN f.dest = a.faa THEN f.origin END) AS unique_arrival_connections,
    COUNT(*) AS total_planned_flights,
    SUM(CASE WHEN f.cancelled = 1 THEN 1 ELSE 0 END) AS total_cancelled,
    SUM(CASE WHEN f.diverted = 1 THEN 1 ELSE 0 END) AS total_diverted,
    SUM(CASE WHEN f.cancelled = 0 AND f.diverted = 0 THEN 1 ELSE 0 END) AS total_actual_flights,
    AVG(COUNT(DISTINCT CASE WHEN f.cancelled = 0 AND f.diverted = 0 THEN f.tail_number END)) OVER () AS avg_unique_airplanes,
    AVG(COUNT(DISTINCT CASE WHEN f.cancelled = 0 AND f.diverted = 0 THEN f.airline END)) OVER () AS avg_unique_airlines,
    a.city AS city,
    a.country AS country,
    a.name AS airport_name
FROM 
    {{ref('prep_flights')}} f
JOIN 
    {{ref('prep_airports')}} a ON f.origin = a.faa OR f.dest = a.faa
GROUP BY
    a.faa,
    a.city,
    a.country,
    a.name
