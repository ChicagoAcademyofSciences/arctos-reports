-- This is used in CHAS_label_vert, CHAS_label_vertLongNames, CHAS_label_exhibit

SELECT DISTINCT(locality_id), COUNT(locality_id) num_catalog_records
FROM flat
WHERE guid LIKE 'CHAS:Inv%'
  AND dec_lat IS NULL
  AND higher_geog LIKE '%North America%'
  AND spec_locality != 'no specific locality recorded'
GROUP BY locality_id
ORDER BY num_catalog_records DESC
