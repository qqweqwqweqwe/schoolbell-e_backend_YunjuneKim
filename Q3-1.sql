CREATE TABLE approvals (
    id                 BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- 결재 ID
    requestor_id       BIGINT UNSIGNED NOT NULL, -- 결재를 요청한 사용자 ID (FK)
    approver_id        BIGINT UNSIGNED NOT NULL, -- 결재를 요청받은 사용자 ID (FK)
    title              VARCHAR(255) NOT NULL, -- 결재 제목
    content            TEXT NOT NULL, -- 결재 요청 내용
    status             ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'PENDING', -- 결재 상태
    created_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 결재 생성 시간
    updated_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 반려 및 승인으로 인한 상태 변경 or 결재 제목 및 내용 변경 or 결재자 변경

    -- 외래 키 설정: users 테이블의 id를 참조
    CONSTRAINT fk_approval_requestor FOREIGN KEY (requestor_id) REFERENCES users(id)
    -- 외래 키 설정: users 테이블의 id를 참조
    CONSTRAINT fk_approval_approver FOREIGN KEY (approver_id) REFERENCES users(id)
)

CREATE TABLE rejected_approvals (
    id                 BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- 반려 ID
    approval_id        BIGINT UNSIGNED NOT NULL, -- 반려된 결재 요청 ID (FK)
    reason             VARCHAR(255) NOT NULL, -- 반려 사유
    created_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 반려 시간
    updated_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 반려 사유가 추후에 변경될 수도 있으므로 추가가

    -- 외래 키 설정: approvals 테이블의 id를 참조
    -- 해당 결재 내용이 삭제되면 반려 결재 내용도 삭제되게끔 cascade 적용
    CONSTRAINT fk_rejection_approval FOREIGN KEY (approval_id) REFERENCES approvals(id) ON DELETE CASCADE,
)

/**
결재 로그
결재 제목 변경 추적
결재 내용 변경 추적
결재 상태 변경 추적
결재자 변경 상태 추적
**/
CREATE TABLE approval_logs (
    id                 BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- 결재 로그 ID
    approval_id        BIGINT UNSIGNED NOT NULL, -- 결재 요청 ID (FK)
    old_approvel_id        BIGINT UNSIGNED NOT NULL, -- 결재를 처리한 사용자 ID (FK)
    new_approvel_id        BIGINT UNSIGNED NOT NULL, -- 결재를 처리한 사용자 ID (FK)
    old_status             ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL, -- 결재 처리 유형
    new_status             ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL, -- 결재 처리 유형
    old_title              VARCHAR(255) NOT NULL, -- 결재 제목
    new_title              VARCHAR(255) NOT NULL, -- 결재 제목
    old_content            TEXT NOT NULL, -- 결재 요청 내용
    new_content            TEXT NOT NULL, -- 결재 요청 내용
    created_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 처리 시간

    -- 외래 키 설정: approval 테이블의 id를 참조
    CONSTRAINT fk_logs_approval FOREIGN KEY (approval_id) REFERENCES approval(id) ON DELETE CASCADE,
    -- 외래 키 설정: 처리한 사용자 ID (users 테이블의 id를 참조)
    CONSTRAINT fk_logs_action_by FOREIGN KEY (action_by) REFERENCES users(id) ON DELETE RESTRICT,
)
