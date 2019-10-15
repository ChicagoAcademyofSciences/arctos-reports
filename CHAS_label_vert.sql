-- This is used in CHAS_label_vert and CHAS_label_vertLongNames
SELECT
  scientific_name,
  cat_num,
  ACCESSION,
  replace(higher_geog,'North America, United States, ','') higher_geog,
  SPEC_LOCALITY,
  VERBATIM_LOCALITY,
  COLLECTING_METHOD,
  COLLECTING_SOURCE,
  BEGAN_DATE,
  ENDED_DATE,
  VERBATIM_DATE,
  COLL_EVENT_REMARKS,
  round(dec_lat,5) dec_lat,
  round(dec_long,5) dec_long,
  COLLECTORS,  -- use this instead if you only want the first collector to show up: NVL(SUBSTR(COLLECTORS, 1, INSTR(COLLECTORS, ',')-1), collectors) collectors,
  decode(trim(flat.sex),
    'male','M',
    'female','F',
    'male ?','M?',
    'female ?','F?',
    '') sex,
  ATTRIBUTES,
  PREPARATORS,
  PARTS,
  REMARKS,
  flat.MINIMUM_ELEVATION,
  flat.ORIG_ELEV_UNITS,
  flat.DATUM,
  ConcatAttributevalue(flat.collection_object_id,'verbatim preservation date') as verbatim_preservation_date,
  ConcatAttributevalue(flat.collection_object_id,'age class') as age_class,
  concatsingleotherid(flat.collection_object_id,'preparator number') as preparator_number,
  concatsingleotherid(flat.collection_object_id,'original identifier') as original_identifier,
  concatsingleotherid(flat.collection_object_id,'secondary identifier') as secondary_identifier,
  concatsingleotherid(flat.collection_object_id,'collector number') as collector_number,
  habitat,
  DECODE(collection_id,'124','BOT-','130','ENTO-','126','FISH-','131','MALA-','113','MAM-','114','ORN-','115','OOL-','144','TEACH-', '154', 'HERP-') || cat_num formatted_cat_num,
  NVL(SUBSTR(identification_remarks, 0, INSTR(identification_remarks, '.')-1),identification_remarks) common_name,
  RELATEDCATALOGEDITEMS,
  NVL(SUBSTR(RELATEDCATALOGEDITEMS, INSTR(RELATEDCATALOGEDITEMS, ')')+1, 100), RELATEDCATALOGEDITEMS) related_to,
  NVL(SUBSTR(RELATEDCATALOGEDITEMS, INSTR(RELATEDCATALOGEDITEMS, '(')+1, INSTR(RELATEDCATALOGEDITEMS, ')')-2), RELATEDCATALOGEDITEMS) related_how,
  parts_distinct

FROM
  flat

-- this section creates column 'parts_distint', a field that lists distinct specimen parts separated by semicolons.
RIGHT JOIN
  (SELECT
    collection_object_id,
    listagg(parts, '; ') within group (order by parts) as parts_distinct
  FROM
    (SELECT distinct
      collection_object_id,
      trim(regexp_substr(parts, '[^;]+', 1, level)) parts
    FROM
      (SELECT
        collection_object_id,
        parts
      FROM flat
      WHERE
        flat.collection_object_id IN (#collection_object_id#))
    CONNECT BY regexp_substr(parts, '[^;]+', 1, level) is not null)
  GROUP BY collection_object_id) a on flat.collection_object_id = a.collection_object_ID
