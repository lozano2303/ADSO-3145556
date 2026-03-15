-- =====================================
-- ENUM
-- =====================================
CREATE TYPE event_status AS ENUM (
    'Draft',
    'Published',
    'Canceled',
    'Completed'
);

CREATE TABLE section_type (
    section_type_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- =====================================
-- Tabla: event
-- =====================================
CREATE TABLE event (
    event_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    user_id INT NOT NULL,
    site_id INT NOT NULL,

    event_name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,

    start_date DATE NOT NULL,
    finish_date DATE NOT NULL,

    status event_status,
    is_public BOOLEAN DEFAULT TRUE,

    available_seats INT NOT NULL,

    -- Restricciones
    CONSTRAINT chk_event_dates
        CHECK (finish_date > start_date),

    CONSTRAINT unique_event_name_date_site
        UNIQUE (event_name, start_date, site_id)
);

-- =====================================
-- Tabla: event_section
-- =====================================
CREATE TABLE event_section (
    event_section_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    event_id INT NOT NULL,
    section_type_id INT NOT NULL,

    capacity INT NOT NULL,
    available_seats INT NOT NULL,

    price DECIMAL(10,2) NOT NULL,

    is_active BOOLEAN DEFAULT TRUE,

    -- Foreign Keys
    CONSTRAINT fk_event_section_event
        FOREIGN KEY (event_id)
        REFERENCES event(event_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_event_section_section_type
        FOREIGN KEY (section_type_id)
        REFERENCES section_type(section_type_id),

    -- Restricciones
    CONSTRAINT chk_capacity_positive
        CHECK (capacity > 0),

    CONSTRAINT chk_available_seats
        CHECK (available_seats <= capacity),

    CONSTRAINT chk_price_positive
        CHECK (price >= 0),

    CONSTRAINT unique_event_section
        UNIQUE (event_id, section_type_id)
);