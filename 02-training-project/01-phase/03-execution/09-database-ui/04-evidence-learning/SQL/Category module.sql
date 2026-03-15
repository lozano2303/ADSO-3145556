-- =========================
-- TABLA CATEGORY
-- =========================
CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(100) NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    visible BOOLEAN DEFAULT TRUE,
    dad_id INT,

    CONSTRAINT fk_category_parent
        FOREIGN KEY (dad_id)
        REFERENCES category(category_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- =========================
-- TABLA EVENT
-- =========================
CREATE TABLE event (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    site_id INT NOT NULL,

    event_name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,

    start_date DATE NOT NULL,
    finish_date DATE NOT NULL,

    status ENUM('DRAFT','PUBLISHED','CANCELLED','COMPLETED'),

    is_public BOOLEAN DEFAULT TRUE,
    available_seats INT NOT NULL,

    CONSTRAINT chk_event_dates
        CHECK (finish_date > start_date),

    CONSTRAINT unique_event
        UNIQUE (event_name, start_date, site_id)
);

-- =========================
-- TABLA CATEGORY_EVENT
-- =========================
CREATE TABLE category_event (
    category_event_id INT AUTO_INCREMENT PRIMARY KEY,

    category_id INT NOT NULL,
    event_id INT NOT NULL,

    CONSTRAINT fk_category_event_category
        FOREIGN KEY (category_id)
        REFERENCES category(category_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_category_event_event
        FOREIGN KEY (event_id)
        REFERENCES event(event_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT unique_category_event
        UNIQUE (category_id, event_id)
);