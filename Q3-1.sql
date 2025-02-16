CREATE TABLE approvals (
    id                 BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- 결재 ID
    requestor_id       BIGINT UNSIGNED NOT NULL, -- 결재를 요청한 사용자 ID (FK)
    approver_id        BIGINT UNSIGNED, -- 결재를 요청받은 사용자 ID (FK)
    title              VARCHAR(255) NOT NULL, -- 결재 제목
    contents           TEXT NOT NULL, -- 결재 요청 내용
    status             ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'PENDING', -- 결재 상태
    created_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 생성 시간

    -- 외래 키 설정: 결재를 요청한 사용자의 ID (users 테이블의 id 참조)
    FOREIGN KEY (requestor_id) REFERENCES users(id) ON DELETE CASCADE,
    -- 외래 키 설정: 결재를 요청받은 사용자의 ID (users 테이블의 id 참조)
    FOREIGN KEY (approver_id) REFERENCES users(id) ON DELETE CASCADE
)

CREATE TABLE rejected_approvals (
    id                 BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- 반려 ID
    approval_id        BIGINT UNSIGNED NOT NULL, -- 반려된 결재 요청 ID (FK)
    reason             VARCHAR(255) NOT NULL, -- 반려 사유
    created_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 반려 시간

    -- 외래 키 설정: 원본 결재 ID (approvals 테이블의 id를 참조)
    FOREIGN KEY (approval_id) REFERENCES approvals(id) ON DELETE CASCADE
)

CREATE TABLE approval_logs (
    id                     BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- 결재 로그 ID
    approval_id            BIGINT UNSIGNED NOT NULL, -- 결재 요청 ID (FK)
    approver_id            BIGINT UNSIGNED , -- 결재 처리 담당자 ID (FK)
    status                 ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL, -- 결재 상태
    title                  VARCHAR(255) NOT NULL, -- 결재 제목
    contents               TEXT NOT NULL, -- 결재 내용
    created_at             DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 생성 시간

    -- 외래 키 설정: 결재 ID (approvals 테이블의 id를 참조)
    FOREIGN KEY (approval_id) REFERENCES approvals(id) ON DELETE CASCADE,
    -- 외래 키 설정: 결재 처리 담당자 ID (users 테이블의 id를 참조)
    FOREIGN KEY (approver_id) REFERENCES users(id) ON DELETE CASCADE
);