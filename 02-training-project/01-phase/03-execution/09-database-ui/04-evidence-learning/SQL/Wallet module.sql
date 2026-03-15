-- =========================
-- ENUMS
-- =========================

CREATE TYPE wallet_transaction_type AS ENUM (
    'refund',
    'top-up',
    'withdrawal',
    'payment'
);

CREATE TYPE wallet_transaction_status AS ENUM (
    'pending',
    'completed',
    'failed'
);

CREATE TYPE wallet_entity_type AS ENUM (
    'order',
    'payment',
    'refund'
);

-- =========================
-- WALLET
-- =========================

CREATE TABLE wallet (
    wallet_id SERIAL PRIMARY KEY,

    user_id INT NOT NULL,

    balance DECIMAL(10,2) DEFAULT 0,
    currency VARCHAR(3) DEFAULT 'COP',

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id)
);

-- =========================
-- WALLET_TRANSACTION
-- =========================

CREATE TABLE wallet_transaction (
    transaction_id SERIAL PRIMARY KEY,

    wallet_id INT NOT NULL,

    type wallet_transaction_type,

    amount DECIMAL(10,2),

    status wallet_transaction_status,

    created_at TIMESTAMP,

    FOREIGN KEY(wallet_id)
        REFERENCES wallet(wallet_id)
);

-- =========================
-- WALLET_REFERENCE
-- =========================

CREATE TABLE wallet_reference (
    wallet_reference_id SERIAL PRIMARY KEY,

    transaction_id INT NOT NULL,

    entity_type wallet_entity_type,
    entity_id INT,

    FOREIGN KEY(transaction_id)
        REFERENCES wallet_transaction(transaction_id)
);