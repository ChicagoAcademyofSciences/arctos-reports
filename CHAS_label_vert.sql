-- This is used in CHAS_label_vert, CHAS_label_vertLongNames, CHAS_label_exhibit

SELECT
  scientific_name,
  accn.accn_number as accn,
  DECODE(CONCATSINGLEOTHERID(flat.collection_object_id,'collector number'),NULL,collectors,(collectors || '; ' || CONCATSINGLEOTHERID(flat.collection_object_id,'collector number'))) collectors_numbers,
  NVL(SUBSTR(identification_remarks, 0, INSTR(identification_remarks, '.')-1),identification_remarks) common_name,
  DECODE(age_class,NULL,DECODE(sex,'female',sex,'male',sex,''),(DECODE(sex,'female',(age_class || ', female'),'male',(age_class || ', male'),''))) age_sex,
  DECODE(collection_id,'124','BOT-','130','ENTO-','126','FISH-','131','MALA-','113','MAM-','114','ORN-','115','OOL-','144','TEACH-') || cat_num formatted_cat_num,
  DECODE(verbatim_date, '[no date recorded]', NULL, REPLACE(verbatim_date,'[transcribed directly into formatted date fields]',began_date)) collecting_date,
  TRIM(TRIM(leading ',' FROM DECODE(higher_geog,'no higher geography recorded',NULL, REPLACE(higher_geog,'North America, United States','USA')) || DECODE(REPLACE(spec_locality,'no specific locality recorded'),NULL,'',', ' || spec_locality))) locstring
FROM
  flat,
  accn
WHERE
  flat.collection_object_id IN (#collection_object_id#) AND
  flat.accn_id = accn.transaction_id
ORDER BY
  formatted_cat_num
