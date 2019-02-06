--Depricated CHAS CHAS-loan-header handler based on standard loan header produced by Arctos. Requires the get_loan pre-function.
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
  loan.transaction_id=21120949
*/

--Current loan header used by CHAS. The get_loan pre-function should not be used; it makes the header disfunctional.
SELECT *
FROM
  loan
LEFT JOIN
  (SELECT DISTINCT
      agent.preferred_agent_name as institutional_name,
      getAgentNameType(agent.agent_id,'job title') insitutional_title,
      get_address(agent.agent_id, 'correspondence',0) institutional_correspondence,
      get_address(agent.agent_id, 'phone',0) institutional_phone,
      get_address(agent.agent_id, 'email',0) institutional_email,
      get_address(agent.agent_id, 'shipping',0) institutional_shipping,
      loan.transaction_id as transaction_id
    FROM loan
    LEFT JOIN trans ON loan.transaction_id = trans.transaction_id
    LEFT JOIN trans_agent ON trans.transaction_id = trans_agent.transaction_id
    LEFT JOIN agent ON trans_agent.agent_id = agent.agent_id
    LEFT JOIN address ON agent.agent_id = address.agent_id
    WHERE loan.transaction_id = 21120949 AND trans_agent.trans_agent_role = 'received by'
    ) borrowing_institution on loan.transaction_id = borrowing_institution.transaction_id
LEFT JOIN
(SELECT DISTINCT
    agent.preferred_agent_name as out_name,
    getAgentNameType(agent.agent_id,'job title') out_title,
    get_address(agent.agent_id, 'correspondence',0) out_correspondence,
    get_address(agent.agent_id, 'phone',0) out_phone,
    get_address(agent.agent_id, 'email',0) out_email,
    get_address(agent.agent_id, 'shipping',0) out_shipping,
    loan.transaction_id as transaction_id
    FROM loan
    LEFT JOIN trans ON loan.transaction_id = trans.transaction_id
    LEFT JOIN trans_agent ON trans.transaction_id = trans_agent.transaction_id
    LEFT JOIN agent ON trans_agent.agent_id = agent.agent_id
    LEFT JOIN address ON agent.agent_id = address.agent_id
    WHERE loan.transaction_id = 21120949 AND trans_agent.trans_agent_role = 'outside contact'
  ) outside_contact on loan.transaction_id = outside_contact.transaction_id
LEFT JOIN
(SELECT DISTINCT
    agent.preferred_agent_name as in_name,
    getAgentNameType(agent.agent_id,'job title') in_title,
    get_address(agent.agent_id, 'correspondence',0) in_correspondence,
    get_address(agent.agent_id, 'phone',0) in_phone,
    get_address(agent.agent_id, 'email',0) in_email,
    get_address(agent.agent_id, 'shipping',0) in_shipping,
    loan.transaction_id as transaction_id
    FROM loan
    LEFT JOIN trans ON loan.transaction_id = trans.transaction_id
    LEFT JOIN trans_agent ON trans.transaction_id = trans_agent.transaction_id
    LEFT JOIN agent ON trans_agent.agent_id = agent.agent_id
    LEFT JOIN address ON agent.agent_id = address.agent_id

    WHERE loan.transaction_id = 21120949 AND trans_agent.trans_agent_role = 'in-house contact'
  ) inside_contact on loan.transaction_id = inside_contact.transaction_id
LEFT JOIN
(SELECT DISTINCT
    agent.preferred_agent_name as auth_name,
    getAgentNameType(agent.agent_id,'job title') auth_title,
    get_address(agent.agent_id, 'correspondence',0) auth_correspondence,
    get_address(agent.agent_id, 'phone',0) auth_phone,
    get_address(agent.agent_id, 'email',0) auth_email,
    get_address(agent.agent_id, 'shipping',0) auth_shipping,
    loan.transaction_id as transaction_id
    FROM loan
    LEFT JOIN trans ON loan.transaction_id = trans.transaction_id
    LEFT JOIN trans_agent ON trans.transaction_id = trans_agent.transaction_id
    LEFT JOIN agent ON trans_agent.agent_id = agent.agent_id
    LEFT JOIN address ON agent.agent_id = address.agent_id
    WHERE loan.transaction_id = 21120949 AND trans_agent.trans_agent_role = 'authorized by'
  ) authorized_by on loan.transaction_id = authorized_by.transaction_id
LEFT JOIN trans on loan.transaction_id = trans.transaction_id
LEFT JOIN shipment on loan.transaction_id = shipment.transaction_id
WHERE loan.transaction_id = 21120949
