SELECT
    specimen_part.collection_object_id part,
    COUNT(specimen_part_attribute.part_attribute_id) attribute_count
FROM
    flat,
    specimen_part,
    specimen_part_attribute,
    coll_object
WHERE
    flat.guid LIKE 'CHAS:Egg%' AND
    flat.collection_object_id=specimen_part.derived_from_cat_item (+) AND
    specimen_part.collection_object_id=coll_object.collection_object_id (+) AND
    specimen_part.collection_object_id=specimen_part_attribute.collection_object_id (+)
GROUP BY  specimen_part.collection_object_id
ORDER BY attribute_count DESC
