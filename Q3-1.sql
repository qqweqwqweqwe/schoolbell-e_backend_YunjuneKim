CREATE TABLE approvals (
    id                 BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- 결재 ID
    requestor_id       BIGINT UNSIGNED NOT NULL, -- 결재를 요청한 사용자 ID
    approver_id        BIGINT UNSIGNED NOT NULL, -- 결재를 요청받은 사용자 ID
    title              VARCHAR(255) NOT NULL, -- 결재 제목
    content            TEXT NOT NULL, -- 결재 내용
    status             ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'PENDING', -- 결재 상태
    created_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 결재 생성 시간간
    updated_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 상태가 변경된 시간 (반려 or 승인인)

    CONSTRAINT fk_approval_requestor FOREIGN KEY (requestor_id) REFERENCES users(id)
    CONSTRAINT fk_approval_approver FOREIGN KEY (approver_id) REFERENCES users(id)
)

CREATE TABLE rejected_approvals (
    id                 BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- 반려 ID
    approval_id        BIGINT UNSIGNED NOT NULL, -- 반려된 결재 요청 ID (FK)
    reason             VARCHAR(255) NOT NULL, -- 반려 사유
    created_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 반려 시간
    updated_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 만약에 반려사유가 변경되었을 시 update

    CONSTRAINT fk_rejection_approval FOREIGN KEY (approval_id) REFERENCES approvals(id) ON DELETE CASCADE,
)

CREATE TABLE approval_logs (
    id                 BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- 결재 로그 ID
    approval_id        BIGINT UNSIGNED NOT NULL, -- 결재 요청 ID (FK)
    action_type        ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL, -- 결재 처리 유형
    action_by          BIGINT UNSIGNED NOT NULL, -- 처리한 사용자 ID
    created_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 처리 시간

    -- 외래 키 설정: approval 테이블의 id를 참조
    CONSTRAINT fk_logs_approval FOREIGN KEY (approval_id) REFERENCES approval(id) ON DELETE CASCADE,
    
    -- 외래 키 설정: 처리한 사용자 ID (users 테이블의 id를 참조)
    CONSTRAINT fk_logs_action_by FOREIGN KEY (action_by) REFERENCES users(id) ON DELETE RESTRICT,

) 
