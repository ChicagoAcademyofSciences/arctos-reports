SELECT collection.collection_cde, SUM(specimenPartCollObject.lot_count) NumberOfSpecimenParts

FROM
   collection,   
   cataloged_item,
   specimen_part,
   coll_object specimenPartCollObject

WHERE
  collection.institution_acronym LIKE 'CHAS' AND
  collection.collection_id=cataloged_item.collection_id (+) AND
  cataloged_item.collection_object_id=specimen_part.derived_from_cat_item (+) AND
  specimen_part.collection_object_id=specimenPartCollObject.collection_object_id (+) AND
  (specimenPartCollObject.coll_obj_disposition LIKE 'in collection' OR
   specimenPartCollObject.coll_obj_disposition LIKE 'on exhibit' OR
   specimenPartCollObject.coll_obj_disposition LIKE 'on loan')

GROUP BY collection.collection_cde