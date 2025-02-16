SELECT *
FROM approvals
WHERE approver_id = ${USER_ID} -- 특정 사용자가 승인자로 지정된 결재건
AND status = 'PENDING' -- 아직 처리되지 않은 결재건
ORDER BY created_at ASC; -- 오래된 요청 순서대로 정렬