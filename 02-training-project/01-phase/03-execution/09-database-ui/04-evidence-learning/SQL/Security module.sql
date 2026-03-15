-- =========================
-- ENUMS
-- =========================

CREATE TYPE organizer_petition_status AS ENUM (
    'Pending',
    'Approved',
    'Rejected'
);

-- =========================
-- USER STATUS
-- =========================

CREATE TABLE user_status (
    user_status_id SERIAL PRIMARY KEY,
    code VARCHAR(30) NOT NULL,
    name VARCHAR(60) NOT NULL,
    description VARCHAR(150) NOT NULL
);

-- =========================
-- ROLE
-- =========================

CREATE TABLE role (
    role_id SERIAL PRIMARY KEY,
    code VARCHAR(30) NOT NULL,
    name VARCHAR(60) NOT NULL,
    description VARCHAR(150) NOT NULL
);

-- =========================
-- PERMISSION
-- =========================

CREATE TABLE permission (
    permission_id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    name VARCHAR(80) NOT NULL,
    description VARCHAR(150) NOT NULL
);

-- =========================
-- ROLE PERMISSION
-- =========================

CREATE TABLE role_permission (
    role_permission_id SERIAL PRIMARY KEY,
    permission_id INT NOT NULL,
    role_id INT NOT NULL,

    FOREIGN KEY(permission_id)
        REFERENCES permission(permission_id),

    FOREIGN KEY(role_id)
        REFERENCES role(role_id)
);

-- =========================
-- USER
-- =========================

CREATE TABLE "user" (
    user_id SERIAL PRIMARY KEY,
    user_status_id INT,
    role_id INT,

    alias VARCHAR(50) NOT NULL UNIQUE,
    activated BOOLEAN DEFAULT FALSE,

    FOREIGN KEY(user_status_id)
        REFERENCES user_status(user_status_id),

    FOREIGN KEY(role_id)
        REFERENCES role(role_id)
);

-- =========================
-- USER STATUS HISTORY
-- =========================

CREATE TABLE user_status_history (
    user_status_history_id SERIAL PRIMARY KEY,

    user_id INT,
    user_status_id INT,

    reason VARCHAR(150) NOT NULL,

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id),

    FOREIGN KEY(user_status_id)
        REFERENCES user_status(user_status_id)
);

-- =========================
-- OAUTH ACCOUNT
-- =========================

CREATE TABLE oauth_account (
    oauth_account_id SERIAL PRIMARY KEY,

    user_id INT NOT NULL,

    provider VARCHAR(40) NOT NULL,
    provider_user_id VARCHAR(100),

    email VARCHAR(255),
    linked_at TIMESTAMP,

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id),

    UNIQUE(user_id, provider),
    UNIQUE(provider, provider_user_id)
);

-- =========================
-- AUTH SESSION
-- =========================

CREATE TABLE auth_session (
    auth_session_id SERIAL PRIMARY KEY,

    user_id INT,

    access_token VARCHAR(512),

    issued_at TIMESTAMP,
    expires_at TIMESTAMP,

    ip_address VARCHAR(45),
    user_agent VARCHAR(200),

    revoked BOOLEAN DEFAULT FALSE,
    revoked_at TIMESTAMP,

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id)
);

-- =========================
-- REFRESH TOKEN
-- =========================

CREATE TABLE refresh_token (
    refresh_token_id SERIAL PRIMARY KEY,

    user_id INT,
    auth_session_id INT,

    token VARCHAR(512),

    issued_at TIMESTAMP,
    expires_at TIMESTAMP,

    revoked BOOLEAN DEFAULT FALSE,
    revoked_at TIMESTAMP,

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id),

    FOREIGN KEY(auth_session_id)
        REFERENCES auth_session(auth_session_id)
);

-- =========================
-- ACCOUNT ACTIVATION
-- =========================

CREATE TABLE account_activation (
    user_id INT PRIMARY KEY,

    activation_code VARCHAR(6),

    activated BOOLEAN DEFAULT FALSE,
    expires_at TIMESTAMP,
    created_at TIMESTAMP,

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id)
);

-- =========================
-- ACCOUNT LOCKOUT
-- =========================

CREATE TABLE account_lockout (
    account_lockout_id SERIAL PRIMARY KEY,

    user_id INT,

    failed_attempts INT,
    window_start TIMESTAMP,
    locked_until TIMESTAMP,

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id)
);

-- =========================
-- ORGANIZER PETITION
-- =========================

CREATE TABLE organizer_petition (
    organizer_petition_id SERIAL PRIMARY KEY,

    user_id INT NOT NULL,

    document BYTEA NOT NULL,
    application_date TIMESTAMP,

    status organizer_petition_status,

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id)
);

CREATE UNIQUE INDEX unique_pending_petition
ON organizer_petition(user_id)
WHERE status = 'Pending';

-- =========================
-- RECOVER PASSWORD
-- =========================

CREATE TABLE recover_password (
    recover_password_id SERIAL PRIMARY KEY,

    user_id INT,

    code VARCHAR(6),
    code_status BOOLEAN DEFAULT FALSE,

    expires_at TIMESTAMP,
    created_at TIMESTAMP,

    last_password_hash VARCHAR(255),

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id)
);

-- =========================
-- PASSWORD HISTORY
-- =========================

CREATE TABLE password_history (
    password_history_id SERIAL PRIMARY KEY,

    user_id INT,

    password_hash VARCHAR(255),
    changed_at TIMESTAMP,

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id)
);

-- =========================
-- LOGIN CREDENTIALS
-- =========================

CREATE TABLE login_credentials (
    login_credentials_id SERIAL PRIMARY KEY,

    user_id INT NOT NULL,

    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,

    last_login_at TIMESTAMP,

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id)
);
