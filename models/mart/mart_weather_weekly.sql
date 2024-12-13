SELECT airport_code, station_id, cw,
AVG(avg_temp_c)::NUMERIC (4,2) AS avg_temp_c,
min(min_temp_c)::NUMERIC (4,2) AS min_temp_c,
max(max_temp_c)::NUMERIC (4,2) AS max_temp_c,
sum(precipitation_mm) AS total_precp_mm,
sum(max_snow_mm) AS total_max_snow_mm,
sum(sun_minutes) AS total_sun_min
FROM {{ref('prep_weather_daily')}} pwd
GROUP BY airport_code, station_id, date_year, cw
ORDER BY 1, 2, 3