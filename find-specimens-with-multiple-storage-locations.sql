SELECT
    flat.collection_id,
    flat.cat_num,
    specimen_part.part_name,
    specimen_part_attribute.attribute_value location,
    COUNT(location) count
    coll_object.lot_count lot_count,
    coll_object.coll_obj_disposition
FROM
    flat,
    specimen_part,
    specimen_part_attribute,
    coll_object,
    loan_item
WHERE
    specimen_part.collection_object_id = coll_object.collection_object_id AND
    specimen_part.collection_object_id = specimen_part_attribute.collection_object_id AND
    specimen_part.derived_from_cat_item = flat.collection_object_id AND
    flat.cat_num IN (SELECT flat.cat_num FROM flat
GROUP BY flat.cat_num HAVING COUNT (flat.cat_num) >1)
