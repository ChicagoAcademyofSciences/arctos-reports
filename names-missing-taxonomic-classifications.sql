SELECT DISTINCT(scientific_name)
FROM flat
WHERE guid LIKE 'CHAS:Inv%' AND kingdom IS NULL AND phylum IS NULL AND phylclass IS NULL AND phylorder IS NULL AND family IS NULL
ORDER BY scientific_name
