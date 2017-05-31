SELECT col, genera_c, families_c, species_c, accn_records, total_loans, total_cons_loans, total_spec_loans, total_spec_cons_loans, total_accn, '2016' AS year, 'calendar year' AS year_type, 'CHAS' AS institution_name

FROM (SELECT col, genera_c, families_c, species_c, accn_records, total_loans, total_cons_loans, total_spec_loans, total_spec_cons_loans
FROM (SELECT col, genera_c, families_c, species_c, accn_records, total_loans, total_cons_loans, total_spec_loans
FROM (SELECT col, genera_c, families_c, species_c, accn_records, total_loans, total_cons_loans
FROM (SELECT col, genera_c, families_c, species_c, accn_records, total_loans
FROM (SELECT col, genera_c, families_c, species_c, accn_records
FROM (SELECT col, genera_c, families_c, species_c
FROM (SELECT col, genera_c, families_c
FROM (SELECT collection AS col, COUNT(DISTINCT(genus)) AS genera_c FROM flat GROUP BY collection ORDER BY collection)

FULL OUTER JOIN (SELECT COUNT(DISTINCT(family)) AS families_c, collection
FROM flat
GROUP BY collection)
ON col = collection
ORDER BY collection)

FULL OUTER JOIN (SELECT COUNT(DISTINCT(species)) AS species_c, collection
FROM flat
GROUP BY collection)
ON col = collection
ORDER BY collection)

LEFT OUTER JOIN (SELECT collection, SUM(estimated_count) AS accn_records
FROM accn, trans, trans_agent, collection
WHERE collection.collection_id = trans.collection_id
AND trans_agent_role = 'entered by'
AND trans.transaction_id = trans_agent.transaction_id
AND trans_agent.transaction_id = accn.transaction_id
AND accn.received_date BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY collection)
ON col = collection)

LEFT OUTER JOIN (SELECT collection, count(loan_number) AS total_loans
FROM loan, trans, collection
WHERE loan.transaction_id = trans.transaction_id
AND trans.collection_id = collection.collection_id
AND (loan_number LIKE '2016%')
AND trans_date BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY collection)
ON col = collection)

LEFT OUTER JOIN (SELECT collection, count(loan_number) AS total_cons_loans
FROM loan, trans, collection
WHERE loan.transaction_id = trans.transaction_id
AND trans.collection_id = collection.collection_id
AND (loan_number LIKE '2016%')
AND trans_date BETWEEN '2016-01-01' AND '2016-12-31'
AND loan_type = 'consumable'
GROUP BY collection)
ON col = collection)

LEFT OUTER JOIN (SELECT COUNT(DISTINCT(specimen_part.derived_from_cat_item)) AS total_spec_loans, collection
FROM loan, trans, collection, loan_item, specimen_part
WHERE loan.transaction_id = trans.transaction_id
AND trans.collection_id = collection.collection_id
AND loan.transaction_id = loan_item.transaction_id
AND loan_item.collection_object_id = specimen_part.collection_object_id
AND (loan_number LIKE '2016%')
AND trans_date BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY collection)
ON col = collection)

LEFT OUTER JOIN (SELECT COUNT(DISTINCT(specimen_part.derived_from_cat_item)) AS total_spec_cons_loans, collection
FROM loan, trans, collection, loan_item, specimen_part
WHERE loan.transaction_id = trans.transaction_id
AND trans.collection_id = collection.collection_id
AND loan.transaction_id = loan_item.transaction_id
AND loan_item.collection_object_id = specimen_part.collection_object_id
AND (loan_number LIKE '2016%')
AND loan_type = 'consumable'
AND trans_date BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY  collection)
ON col = collection)

LEFT OUTER JOIN (SELECT collection, COUNT(DISTINCT(accn_number)) AS total_accn
FROM accn,trans,trans_agent,collection
WHERE collection.collection_id = trans.collection_id
AND trans_agent_role = 'entered by'
AND trans.transaction_id = trans_agent.transaction_id
AND trans_agent.transaction_id = accn.transaction_id
AND accn.received_date BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY collection)
ON col = collection
