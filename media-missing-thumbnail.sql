SELECT *
FROM media
WHERE media_uri LIKE '%CAS%' AND mime_type='image/jpeg' AND preview_uri IS NULL
