SELECT flat.collection_cde, COUNT (DISTINCT flat.guid)

FROM
   flat

WHERE
  flat.guid LIKE 'CHAS%' AND
  (flat.partdetail LIKE '%in collection%' OR
   flat.partdetail LIKE '%on exhibit%' OR
   flat.partdetail LIKE '%on loan%')

GROUP BY flat.collection_cde
