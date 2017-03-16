SELECT
    flat.collection,
    flat.collection_cde,
    flat.collection_id,
    flat.cat_num,
    flat.scientific_name,
    flat.identification_remarks,
    loan.loan_number,
    trans.trans_date,
    specimen_part.part_name,
    specimen_part_attribute.attribute_value location,
    coll_object.lot_count lot_count,
    coll_object.condition part_condition,
    coll_object.coll_obj_disposition
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
ORDER BY collection_id, cat_num
