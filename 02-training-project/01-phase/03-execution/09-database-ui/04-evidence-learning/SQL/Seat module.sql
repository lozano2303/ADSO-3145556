-----------------------
-- ENUMS
-----------------------

CREATE TYPE seat_status_enum AS ENUM (
'available',
'reserved',
'sold',
'courtesy'
);

CREATE TYPE seat_type_enum AS ENUM (
'regular',
'courtesy'
);

-----------------------
-- USER (referenciado)
-----------------------

CREATE TABLE "user" (
user_id INT PRIMARY KEY,
user_status_id INT,
role_id INT,
alias VARCHAR(50) NOT NULL UNIQUE,
activated BOOLEAN DEFAULT FALSE
);

-----------------------
-- EVENT SECTION
-----------------------

CREATE TABLE event_section (
event_section_id INT PRIMARY KEY,
event_id INT,
section_type_id INT,
capacity INT NOT NULL,
available_seats INT NOT NULL,
price DECIMAL(10,2) NOT NULL,
is_active BOOLEAN DEFAULT TRUE
);

-----------------------
-- SEAT BLOCK
-----------------------

CREATE TABLE seat_block (
seat_block_id INT PRIMARY KEY,
event_section_id INT NOT NULL,
name VARCHAR(100) NOT NULL,
capacity INT NOT NULL,

FOREIGN KEY (event_section_id)
REFERENCES event_section(event_section_id)
);

-----------------------
-- SEAT
-----------------------

CREATE TABLE seat (
seat_id INT PRIMARY KEY,
seat_block_id INT NOT NULL,
event_section_id INT NOT NULL,
code VARCHAR(20) NOT NULL,
row INT NOT NULL,
position INT NOT NULL,
type seat_type_enum,
status seat_status_enum,

FOREIGN KEY (seat_block_id)
REFERENCES seat_block(seat_block_id),

FOREIGN KEY (event_section_id)
REFERENCES event_section(event_section_id)
);

-----------------------
-- SEAT LOG
-----------------------

CREATE TABLE seat_log (
seat_log_id INT PRIMARY KEY,
seat_id INT NOT NULL,
old_status seat_status_enum,
new_status seat_status_enum,
changed_at TIMESTAMP,
changed_by INT,
reason VARCHAR(255),

FOREIGN KEY (seat_id)
REFERENCES seat(seat_id),

FOREIGN KEY (changed_by)
REFERENCES "user"(user_id)
);