SELECT * 
FROM {{source('staging_flights', 'airports')}} AS a
LEFT  JOIN {{sources('staging_flights', 'regions')}} AS r
ON a.country = r.country;