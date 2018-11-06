-- This is used in CHAS_label_EH.cfr

SELECT
  replace(scientific_name, '-',', ') scientific_name,
  kingdom,
  collectors,
  concatCollectorAgent(flat.collection_object_id,'maker') as maker,
  higher_geog,
  spec_locality,
  began_date,
  decode(began_date,
    '1800','unknown',
    '1800-01-01','unknown',
    began_date) b_date,
  ended_date,
  replace(replace(verbatim_date,'[',''),']','') verbatim_date,
  concatsingleotherid(flat.collection_object_id,'preparator number') as preparator_number,
  concatsingleotherid(flat.collection_object_id,'original identifier') as original_identifier,
  concatsingleotherid(flat.collection_object_id,'secondary identifier') as secondary_identifier,
  concatsingleotherid(flat.collection_object_id,'collector number') as collector_number,
  NVL(SUBSTR(identification_remarks, 0, INSTR(identification_remarks, '.')-1),identification_remarks) common_name,
  DECODE(collection_id,
    '132','EH-',
    '144','TEACH-'
  ) || cat_num formatted_cat_num,

  decode(lower(substr(ConcatAttributevalue(flat.collection_object_id,'description'),0,5)),
    'anthr','anthropology',
    'scien','scientific history',
    'model','model',
    'TEST') obj_type,

  ConcatAttributevalue(flat.collection_object_id,'culture of origin') as orig_cult

FROM
  flat
WHERE
  flat.collection_object_id IN (#collection_object_id#)
ORDER BY
  formatted_cat_num


  SELECT
    scientific_name,
    collectors,
    concatCollectorAgent(flat.collection_object_id,'maker') as maker,
    higher_geog,
    spec_locality,
    began_date,
    decode(began_date,
      '1800','unknown',
      '1800-01-01','unknown',
      began_date) b_date,
    ended_date,
    replace(replace(verbatim_date,'[',''),']','') verbatim_date,
    concatsingleotherid(flat.collection_object_id,'preparator number') as preparator_number,
    concatsingleotherid(flat.collection_object_id,'original identifier') as original_identifier,
    concatsingleotherid(flat.collection_object_id,'secondary identifier') as secondary_identifier,
    concatsingleotherid(flat.collection_object_id,'collector number') as collector_number,
    NVL(SUBSTR(identification_remarks, 0, INSTR(identification_remarks, '.')-1),identification_remarks) common_name,
    DECODE(collection_id,
      '132','EH-',
      '144','TEACH-'
    ) || cat_num formatted_cat_num,
    lower(nvl(SUBSTR(ConcatAttributevalue(flat.collection_object_id,'description'), 0, INSTR(ConcatAttributevalue(flat.collection_object_id,'description'), 'anthropology:')-1),
      nvl(SUBSTR(ConcatAttributevalue(flat.collection_object_id,'description'), 0, INSTR(ConcatAttributevalue(flat.collection_object_id,'description'), '.')-1),'')
    )) obj_type,
    ConcatAttributevalue(flat.collection_object_id,'culture of origin') as orig_cult

  FROM
    flat
  WHERE
    flat.collection_object_id IN (#collection_object_id#)
  ORDER BY
    formatted_cat_num
