-- =========================
-- ENUMS
-- =========================

CREATE TYPE seat_type AS ENUM (
    'regular',
    'courtesy'
);

CREATE TYPE seat_status AS ENUM (
    'available',
    'reserved',
    'sold',
    'courtesy'
);

CREATE TYPE ticket_status AS ENUM (
    'draft',
    'payment_pending',
    'paid',
    'cancelled',
    'refunded',
    'used'
);

CREATE TYPE order_status AS ENUM (
    'pending',
    'processing',
    'paid',
    'failed',
    'refunded'
);

-- =========================
-- EVENT
-- =========================

CREATE TABLE event (
    event_id SERIAL PRIMARY KEY,

    user_id INT NOT NULL,
    site_id INT NOT NULL,

    event_name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,

    start_date DATE NOT NULL,
    finish_date DATE NOT NULL,

    status VARCHAR(20),

    is_public BOOLEAN DEFAULT TRUE,
    available_seats INT NOT NULL,

    CHECK (finish_date > start_date),

    UNIQUE(event_name, start_date, site_id)
);

-- =========================
-- ORDER
-- =========================

CREATE TABLE "order" (
    order_id SERIAL PRIMARY KEY,

    user_id INT NOT NULL,
    event_id INT NOT NULL,

    total_amount DECIMAL(10,2) NOT NULL,

    currency VARCHAR(3) DEFAULT 'COP',

    status order_status,

    created_at TIMESTAMP,

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id),

    FOREIGN KEY(event_id)
        REFERENCES event(event_id)
);

-- =========================
-- TICKET
-- =========================

CREATE TABLE ticket (
    ticket_id SERIAL PRIMARY KEY,

    event_id INT NOT NULL,
    user_id INT NOT NULL,
    order_id INT NOT NULL,

    code VARCHAR(20) NOT NULL,
    qr_code VARCHAR(255),

    status ticket_status,

    expiration_date DATE,

    total_price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY(event_id)
        REFERENCES event(event_id),

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id),

    FOREIGN KEY(order_id)
        REFERENCES "order"(order_id)
);

-- =========================
-- SEAT
-- =========================

CREATE TABLE seat (
    seat_id SERIAL PRIMARY KEY,

    seat_block_id INT NOT NULL,
    event_section_id INT NOT NULL,

    code VARCHAR(20) NOT NULL,
    row INT NOT NULL,
    position INT NOT NULL,

    type seat_type,
    status seat_status
);

-- =========================
-- SEAT_TICKET
-- =========================

CREATE TABLE seat_ticket (
    seat_id INT NOT NULL,
    ticket_id INT NOT NULL,

    price DECIMAL(10,2) NOT NULL,

    PRIMARY KEY(seat_id, ticket_id),

    FOREIGN KEY(seat_id)
        REFERENCES seat(seat_id),

    FOREIGN KEY(ticket_id)
        REFERENCES ticket(ticket_id)
);

-- =========================
-- TICKET_CHECKIN
-- =========================

CREATE TABLE ticket_checkin (
    checkin_id SERIAL PRIMARY KEY,

    ticket_id INT NOT NULL,

    checkin_time TIMESTAMP,

    validated_by INT,

    FOREIGN KEY(ticket_id)
        REFERENCES ticket(ticket_id),

    FOREIGN KEY(validated_by)
        REFERENCES "user"(user_id)
);

-- =========================
-- TICKET_LOG
-- =========================

CREATE TABLE ticket_log (
    ticket_log_id SERIAL PRIMARY KEY,

    ticket_id INT NOT NULL,

    old_status ticket_status,
    new_status ticket_status,

    changed_at TIMESTAMP,

    changed_by INT,

    reason VARCHAR(255),

    FOREIGN KEY(ticket_id)
        REFERENCES ticket(ticket_id),

    FOREIGN KEY(changed_by)
        REFERENCES "user"(user_id)
);