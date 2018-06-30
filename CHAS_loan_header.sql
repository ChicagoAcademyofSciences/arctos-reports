--Current CHAS CHAS-loan-header handler
/*
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
*/

--an attempt at fixing the handler- still doesn't work...
select
  (select address.address
    from address
    where trans_agent.trans_agent_role = 'outside contact' AND
      address.address_type = 'work phone') outside_phone_number

FROM
  loan

JOIN trans ON loan.transaction_id = trans.transaction_id
JOIN trans_agent ON trans.transaction_id = trans_agent.transaction_id
JOIN agent ON trans_agent.agent_id = agent.agent_id

WHERE loan.transaction_id = #transaction_id#
LIMIT 1
