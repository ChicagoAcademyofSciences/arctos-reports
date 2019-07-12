SELECT
  scientific_name,
  higher_geog,
  SPEC_LOCALITY,
  VERBATIM_LOCALITY,
  BEGAN_DATE,
  ENDED_DATE,
  VERBATIM_DATE,
  COLL_EVENT_REMARKS,
  habitat,
  family,
  DECODE(identifiedby,'unknown','', 'Teenagers Exploring and Explaining Nature and Science', 'Det. CHAS TEENS', ('Det. ' || identifiedby)) formatted_identifiedby,
  made_date,
  collectors,
  DECODE(country, 'United States', 'USA', country) country,
  state_prov,
  (NVL(SUBSTR(county, 0, INSTR(county, 'County')-1),county) || 'Co.') county,
  concatsingleotherid(flat.collection_object_id,'preparator number') as preparator_number,
  concatsingleotherid(flat.collection_object_id,'original identifier') as original_identifier,
  concatsingleotherid(flat.collection_object_id,'secondary identifier') as secondary_identifier,
  concatsingleotherid(flat.collection_object_id,'collector number') as collector_number,
  NVL(SUBSTR(identification_remarks, 0, INSTR(identification_remarks, '.')-1),identification_remarks) common_name,
  DECODE(age_class,NULL,DECODE(sex,'female',sex,'male',sex,''),(DECODE(sex,'female',(age_class || ', female'),'male',(age_class || ', male'),''))) age_sex,
  DECODE(collection_id,'124','BOT-','130','ENTO-','126','FISH-','131','MALA-','113','MAM-','114','ORN-','115','OOL-','144','TEACH-') || cat_num formatted_cat_num,
  DECODE(verbatim_date, '[no date recorded]', NULL, REPLACE(verbatim_date,'[transcribed directly into formatted date fields]',began_date)) collecting_date
FROM
  flat
WHERE
  flat.collection_object_id IN (#collection_object_id#)
ORDER BY
  family, scientific_name, formatted_cat_num
