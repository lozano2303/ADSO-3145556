-------------------------
-- ENUMS
-------------------------

CREATE TYPE event_status_enum AS ENUM ('Draft','Published','Cancelled','Completed');

CREATE TYPE payment_status_enum AS ENUM ('pending','approved','rejected','error','refunded');

CREATE TYPE wallet_transaction_type_enum AS ENUM ('recharge','payment','refund');

CREATE TYPE wallet_transaction_status_enum AS ENUM ('pending','approved','rejected','error');

CREATE TYPE ticket_status_enum AS ENUM ('pending','approved','rejected','refunded');

-------------------------
-- LANGUAGE
-------------------------

CREATE TABLE language (
language_id INT PRIMARY KEY,
code VARCHAR(10) NOT NULL,
name VARCHAR(50) NOT NULL,
is_active BOOLEAN DEFAULT TRUE,
created_at TIMESTAMP,
created_by INT,
updated_at TIMESTAMP,
updated_by INT
);

-------------------------
-- THEME
-------------------------

CREATE TABLE theme (
theme_id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
description VARCHAR(255) NOT NULL,
default_palette JSONB,
created_at TIMESTAMP,
created_by INT
);

-------------------------
-- USER
-------------------------

CREATE TABLE "user" (
user_id INT PRIMARY KEY,
user_status_id INT,
role_id INT,
alias VARCHAR(50) NOT NULL UNIQUE,
activated BOOLEAN DEFAULT FALSE
);

-------------------------
-- PREFERENCES
-------------------------

CREATE TABLE preferences (
preference_id INT PRIMARY KEY,
user_id INT NOT NULL,
language_id INT NOT NULL,
theme_id INT NOT NULL,
notifications BOOLEAN DEFAULT FALSE,

FOREIGN KEY (user_id) REFERENCES "user"(user_id),
FOREIGN KEY (language_id) REFERENCES language(language_id),
FOREIGN KEY (theme_id) REFERENCES theme(theme_id)
);

-------------------------
-- ACTIVITY LOG
-------------------------

CREATE TABLE activity_log (
log_id INT PRIMARY KEY,
user_id INT NOT NULL,
module VARCHAR(50),
action VARCHAR(100),
reference_id INT,
occurred_at TIMESTAMP,

FOREIGN KEY (user_id) REFERENCES "user"(user_id)
);

-------------------------
-- WALLET
-------------------------

CREATE TABLE wallet (
wallet_id INT PRIMARY KEY,
user_id INT NOT NULL,
balance DECIMAL(10,2) DEFAULT 0,
currency VARCHAR(3) DEFAULT 'COP',

FOREIGN KEY (user_id) REFERENCES "user"(user_id)
);

-------------------------
-- WALLET TRANSACTION
-------------------------

CREATE TABLE wallet_transaction (
transaction_id INT PRIMARY KEY,
wallet_id INT NOT NULL,
type wallet_transaction_type_enum,
amount DECIMAL(10,2),
status wallet_transaction_status_enum,
created_at TIMESTAMP,

FOREIGN KEY (wallet_id) REFERENCES wallet(wallet_id)
);

-------------------------
-- WALLET SUMMARY
-------------------------

CREATE TABLE wallet_summary (
summary_id INT PRIMARY KEY,
user_id INT NOT NULL,
wallet_id INT NOT NULL,
transaction_id INT NOT NULL,
type wallet_transaction_type_enum,
amount DECIMAL(10,2) NOT NULL,
occurred_at TIMESTAMP,

FOREIGN KEY (user_id) REFERENCES "user"(user_id),
FOREIGN KEY (wallet_id) REFERENCES wallet(wallet_id),
FOREIGN KEY (transaction_id) REFERENCES wallet_transaction(transaction_id)
);

-------------------------
-- EVENT
-------------------------

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

FOREIGN KEY (user_id) REFERENCES "user"(user_id),

CHECK (finish_date > start_date)
);

-------------------------
-- CITY
-------------------------

CREATE TABLE city (
city_id INT PRIMARY KEY,
department_id INT NOT NULL,
name VARCHAR(100) NOT NULL,
code VARCHAR(10)
);

-------------------------
-- PROFILE
-------------------------

CREATE TABLE profile (
profile_id INT PRIMARY KEY,
user_id INT NOT NULL,
city_id INT NOT NULL,
full_name VARCHAR(100) NOT NULL,
photo_url VARCHAR(255) NOT NULL,
bio VARCHAR(255),

FOREIGN KEY (user_id) REFERENCES "user"(user_id),
FOREIGN KEY (city_id) REFERENCES city(city_id)
);

-------------------------
-- PROFILE LOG
-------------------------

CREATE TABLE profile_log (
log_id INT PRIMARY KEY,
profile_id INT NOT NULL,
action VARCHAR(50),
old_value VARCHAR(255),
new_value VARCHAR(255),
occurred_at TIMESTAMP,

FOREIGN KEY (profile_id) REFERENCES profile(profile_id)
);

-------------------------
-- REVIEW
-------------------------

CREATE TABLE review (
review_id INT PRIMARY KEY,
user_id INT NOT NULL,
event_id INT NOT NULL,
rating INT CHECK (rating BETWEEN 1 AND 5),
comment VARCHAR(255) NOT NULL,
created_at TIMESTAMP,
updated_at TIMESTAMP,

FOREIGN KEY (user_id) REFERENCES "user"(user_id),
FOREIGN KEY (event_id) REFERENCES event(event_id)
);

-------------------------
-- ORDER 
-------------------------

CREATE TABLE "order" (
order_id INT PRIMARY KEY,
user_id INT NOT NULL,
event_id INT NOT NULL,
total_amount DECIMAL(10,2) NOT NULL,
currency VARCHAR(3) DEFAULT 'COP',
status payment_status_enum,
created_at TIMESTAMP,

FOREIGN KEY (user_id) REFERENCES "user"(user_id),
FOREIGN KEY (event_id) REFERENCES event(event_id)
);

-------------------------
-- PAYMENT
-------------------------

CREATE TABLE payment (
payment_id INT PRIMARY KEY,
order_id INT NOT NULL,
gateway VARCHAR(50),
gateway_transaction_id VARCHAR(100),
status payment_status_enum,
amount DECIMAL(10,2) NOT NULL,
payment_method VARCHAR(50),
processed_at TIMESTAMP,

FOREIGN KEY (order_id) REFERENCES "order"(order_id)
);

-------------------------
-- TICKET
-------------------------

CREATE TABLE ticket (
ticket_id INT PRIMARY KEY,
event_id INT NOT NULL,
user_id INT NOT NULL,
order_id INT NOT NULL,
code VARCHAR(20) NOT NULL,
qr_code VARCHAR(255),
status ticket_status_enum,
expiration_date DATE,
total_price DECIMAL(10,2) NOT NULL,

FOREIGN KEY (event_id) REFERENCES event(event_id),
FOREIGN KEY (user_id) REFERENCES "user"(user_id),
FOREIGN KEY (order_id) REFERENCES "order"(order_id)
);

-------------------------
-- PURCHASE HISTORY
-------------------------

CREATE TABLE purchase_history (
purchase_id INT PRIMARY KEY,
user_id INT NOT NULL,
ticket_id INT NOT NULL,
payment_id INT NOT NULL,
amount DECIMAL(10,2) NOT NULL,
status payment_status_enum,
purchased_at TIMESTAMP,

FOREIGN KEY (user_id) REFERENCES "user"(user_id),
FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id),
FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
);