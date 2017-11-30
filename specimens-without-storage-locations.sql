-- Find specimen parts that are in collection but have no storage location

SELECT
   flat.collection_object_id,
   flat.collection_cde,
   flat.cat_num,
   flat.collectornumber,
   flat.collectors,
   flat.scientific_name,
   flat.identification_remarks,
   specimen_part.part_name,
   specimenPartCollObject.coll_obj_disposition disposition,
   specimenPartCollObject.condition condition,
   specimenPartCollObject.lot_count lot_count,
   specimen_part_attribute.attribute_value location
FROM
   flat,
   specimen_part,
   specimen_part_attribute,
   coll_object specimenPartCollObject
WHERE
  specimenPartCollObject.coll_obj_disposition LIKE 'in collection' AND
  specimen_part_attribute.attribute_value IS NULL AND
  flat.collection_object_id=specimen_part.derived_from_cat_item (+) AND
  specimen_part.collection_object_id=specimenPartCollObject.collection_object_id (+) AND
  specimen_part.collection_object_id=specimen_part_attribute.collection_object_id (+)
ORDER BY scientific_name, cat_num
