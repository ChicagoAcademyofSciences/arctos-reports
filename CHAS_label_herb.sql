SELECT
  scientific_name,
  family,
  identifiedby,
  coll_event_remarks,
  verbatim_coordinates,
  habitat,
  DECODE(collection_id,'124','BOTANY COLLECTION','144','TEACHING COLLECTION',NULL) collection,
  DECODE(CONCATSINGLEOTHERID(flat.collection_object_id,'collector number'),NULL,collectors,(collectors || '; ' || CONCATSINGLEOTHERID(flat.collection_object_id,'collector number'))) collectors_numbers,
  NVL(SUBSTR(identification_remarks, 0, INSTR(identification_remarks, '.')-1),identification_remarks) common_name,
  DECODE(collection_id,'124','CHAS:Herb:','130','ENTO-','126','FISH-','131','MALA-','113','MAM-','114','ORN-','115','OOL-','144','TEACH-') || cat_num formatted_cat_num,
  DECODE(verbatim_date, '[no date recorded]', NULL, REPLACE(verbatim_date,'[transcribed directly into formatted date fields]',began_date)) collecting_date,
  TRIM(TRIM(leading ',' FROM DECODE(higher_geog,'no higher geography recorded',NULL, REPLACE(higher_geog,'North America, United States','USA')) || DECODE(REPLACE(spec_locality,'no specific locality recorded'),NULL,'',', ' || spec_locality))) locstring
FROM
  flat
WHERE
  flat.collection_object_id IN (#collection_object_id#)
ORDER BY
  formatted_cat_num
