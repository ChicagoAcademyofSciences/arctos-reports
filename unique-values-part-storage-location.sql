SELECT
    COUNT(specimen_part_attribute.attribute_value) count,
    specimen_part_attribute.attribute_value location
FROM
    collection,
    cataloged_item,
    specimen_part,
    specimen_part_attribute
WHERE
    collection.institution_acronym = 'CHAS' AND
    collection.collection_id = cataloged_item.collection_id AND
    cataloged_item.collection_object_id = specimen_part.derived_from_cat_item AND
    specimen_part.collection_object_id = specimen_part_attribute.collection_object_id AND
    specimen_part_attribute.attribute_type LIKE 'location'
GROUP BY specimen_part_attribute.attribute_value
ORDER BY specimen_part_attribute.attribute_value, count
