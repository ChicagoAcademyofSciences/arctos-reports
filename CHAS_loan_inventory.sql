SELECT
    flat.scientific_name,
    loan.loan_number,
    trans.trans_date,
    specimen_part.part_name,
    specimen_part_attribute.attribute_value location,
    coll_object.lot_count lot_count,
    coll_object.condition part_condition,
    coll_object.coll_obj_disposition,
    NVL(SUBSTR(flat.identification_remarks, 0, INSTR(flat.identification_remarks, '.')-1),flat.identification_remarks) common_name,
    DECODE(flat.collection_id,'124','BOT-','130','ENTO-','126','FISH-','131','MALA-','113','MAM-','114','ORN-','115','OOL-','144','TEACH-') || flat.cat_num formatted_cat_num
FROM
    flat,
    loan,
    trans,
    specimen_part,
    specimen_part_attribute,
    coll_object,
    loan_item
WHERE
    loan_item.transaction_id = #transaction_id# AND
    loan.transaction_id = trans.transaction_id AND
    loan.transaction_id = loan_item.transaction_id AND
    loan_item.collection_object_id = specimen_part.collection_object_id AND
    specimen_part.collection_object_id = coll_object.collection_object_id AND
    specimen_part.collection_object_id = specimen_part_attribute.collection_object_id AND
    specimen_part.derived_from_cat_item = flat.collection_object_id
ORDER BY formatted_cat_num
