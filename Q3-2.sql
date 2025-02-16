SELECT *
FROM approval_request
WHERE approver_id = {USER_ID} -- 특정 사용자가 승인자로 지정된 결재건
AND approval_status = 'PENDING' -- 아직 처리되지 않은 결재건
ORDER BY requested_at ASC; -- 요청된 순서대로 정렬