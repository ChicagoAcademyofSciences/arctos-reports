SELECT
  get_address(inside_contact.agent_id,'work phone') inside_phone_number
FROM
  loan,
  trans,
  (select * from trans_agent where trans_agent_role='authorized by') inside_contact
WHERE
  loan.transaction_id = trans.transaction_id AND
  trans.transaction_id = inside_contact.transaction_id (+) AND
  loan.transaction_id=#transaction_id#
