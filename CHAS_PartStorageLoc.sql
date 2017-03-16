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
  flat.collection_object_id IN (#collection_object_id#) AND
  flat.collection_object_id=specimen_part.derived_from_cat_item (+) AND
  specimen_part.collection_object_id=specimenPartCollObject.collection_object_id (+) AND
  specimen_part.collection_object_id=specimen_part_attribute.collection_object_id (+)
ORDER BY location, disposition, collection_cde, cat_num
