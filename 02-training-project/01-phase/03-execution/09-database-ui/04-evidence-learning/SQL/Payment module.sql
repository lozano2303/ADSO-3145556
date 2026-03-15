CREATE TYPE payment_status_enum AS ENUM (
'pending',
'processing',
'paid',
'failed',
'refunded'
);

CREATE TYPE refund_status_enum AS ENUM (
'requested',
'approved',
'processed',
'failed'
);

CREATE TYPE order_status_enum AS ENUM (
'pending',
'processing',
'paid',
'failed',
'refunded'
);

CREATE TYPE payment_method_enum AS ENUM (
'card',
'pse',
'nequi',
'cash'
);

CREATE TYPE gateway_enum AS ENUM (
'wompi'
);

CREATE TYPE event_status_enum AS ENUM (
'Draft',
'Published',
'Cancelled',
'Completed'
);


-- USER 

CREATE TABLE "user" (
user_id INT PRIMARY KEY,
user_status_id INT,
role_id INT,
alias VARCHAR(50) NOT NULL UNIQUE,
activated BOOLEAN DEFAULT FALSE
);

-- EVENT

CREATE TABLE event (
event_id INT PRIMARY KEY,
user_id INT NOT NULL,
site_id INT NOT NULL,
event_name VARCHAR(100) NOT NULL,
description VARCHAR(255) NOT NULL,
start_date DATE NOT NULL,
finish_date DATE NOT NULL,
status event_status_enum,
is_public BOOLEAN DEFAULT TRUE,
available_seats INT NOT NULL,

CONSTRAINT fk_event_user
FOREIGN KEY (user_id) REFERENCES "user"(user_id),

CONSTRAINT chk_event_dates
CHECK (finish_date > start_date)
);

-- ORDER

CREATE TABLE "order" (
order_id INT PRIMARY KEY,
user_id INT NOT NULL,
event_id INT NOT NULL,
total_amount DECIMAL(10,2) NOT NULL,
currency VARCHAR(3) DEFAULT 'COP',
status order_status_enum,
created_at TIMESTAMP,

CONSTRAINT fk_order_user
FOREIGN KEY (user_id) REFERENCES "user"(user_id),

CONSTRAINT fk_order_event
FOREIGN KEY (event_id) REFERENCES event(event_id)
);

-- PAYMENT

CREATE TABLE payment (
payment_id INT PRIMARY KEY,
order_id INT NOT NULL,
gateway gateway_enum,
gateway_transaction_id VARCHAR(100),
status payment_status_enum,
amount DECIMAL(10,2) NOT NULL,
payment_method payment_method_enum,
processed_at TIMESTAMP,

CONSTRAINT fk_payment_order
FOREIGN KEY (order_id) REFERENCES "order"(order_id)
);

-- PAYMENT LOG

CREATE TABLE payment_log (
payment_log_id INT PRIMARY KEY,
payment_id INT NOT NULL,
old_status payment_status_enum,
new_status payment_status_enum,
changed_at TIMESTAMP,
reason VARCHAR(255),

CONSTRAINT fk_paymentlog_payment
FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
);

-- REFUND

CREATE TABLE refund (
refund_id INT PRIMARY KEY,
payment_id INT NOT NULL,
status refund_status_enum,
reason VARCHAR(255),
requested_at TIMESTAMP,
processed_at TIMESTAMP,

CONSTRAINT fk_refund_payment
FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
);

-- TRANSACTION WEBHOOK

CREATE TABLE transaction_webhook (
webhook_id INT PRIMARY KEY,
payment_id INT NOT NULL,
payload JSONB NOT NULL,
received_at TIMESTAMP,

CONSTRAINT fk_webhook_payment
FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
);