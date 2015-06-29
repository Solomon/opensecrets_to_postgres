SELECT s."CYCLE"
, s."CAND_NAME"
, c."CMTE_NM"
, s."TTL_INDIV_CONTRIB"

FROM fec_candidate_summary s
JOIN fec_committees c ON c."CAND_ID" = s."CAND_ID" AND c."CYCLE" = s."CYCLE"
WHERE "CAND_NAME" = 'CROWLEY, JOSEPH'
ORDER BY s."CYCLE" DESC


SELECT s."CYCLE" as cycle
, s."CAND_NAME" as cand_name
, c."CMTE_ID" as cmte_id
, c."CMTE_NM" as cmte_nm
, s."TTL_INDIV_CONTRIB" as total_contributions
, SUM(i."TRANSACTION_AMT") as sum_contributions
, COUNT(i."TRANSACTION_AMT") as total_transactions
, COUNT(CASE WHEN i."MEMO_CD" IS NULL THEN i."SUB_ID" ELSE NULL END) as total_without_code
, SUM(CASE WHEN i."MEMO_CD" IS NULL THEN i."TRANSACTION_AMT" ELSE NULL END) as total_without_code
FROM fec_candidate_summary s
JOIN fec_committees c ON c."CAND_ID" = s."CAND_ID" AND c."CYCLE" = s."CYCLE"
JOIN fec_individual_contributions i ON i."CMTE_ID" = c."CMTE_ID" AND i."CYCLE" = c."CYCLE"
WHERE "CAND_NAME" = 'CROWLEY, JOSEPH'
GROUP BY cycle, cand_name, cmte_id, cmte_nm, total_contributions
ORDER BY s."CYCLE" DESC
