SELECT
   flat.phylorder,
   flat.family,
   flat.scientific_name,
   specimen_part.part_name,
   specimenPartCollObject.coll_obj_disposition disposition,
   specimenPartCollObject.condition condition,
   specimenPartCollObject.lot_count lot_count,
   specimen_part_attribute.attribute_value location,
   DECODE(flat.collection_id,'124','BOT-','130','ENTO-','126','FISH-','131','MALA-','113','MAM-','114','ORN-','115','OOL-','144','TEACH-') || flat.cat_num formatted_cat_num,
   NVL(SUBSTR(flat.identification_remarks, 0, INSTR(flat.identification_remarks, '.')-1),flat.identification_remarks) common_name,
   TRIM(TRIM(leading ',' FROM DECODE(flat.higher_geog,'no higher geography recorded',NULL, REPLACE(flat.higher_geog,'North America, United States','USA')) || DECODE(REPLACE(flat.spec_locality,'no specific locality recorded'),NULL,'',', ' || flat.spec_locality))) locstring,
   DECODE(CONCATSINGLEOTHERID(flat.collection_object_id,'collector number'),NULL,flat.collectors,(flat.collectors || '; ' || CONCATSINGLEOTHERID(flat.collection_object_id,'collector number'))) collectors_numbers


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
ORDER BY family, scientific_name, formatted_cat_num, part_name, location
