SELECT COUNT(*), c.institution_acronym, c.collection_cde
FROM cataloged_item ci, collection c, media m, media_relations mr
WHERE ci.collection_id = c.collection_id
AND ci.collection_object_id = mr.related_primary_key
AND mr.media_relationship = 'shows cataloged_item'
AND mr.media_id = m.media_id
AND m.media_type = 'image'
GROUP BY c.institution_acronym, c.collection_cde
