-- =========================
-- TABLE: user
-- =========================
CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_status_id INT,
    role_id INT,
    alias VARCHAR(50) NOT NULL UNIQUE,
    activated BOOLEAN DEFAULT FALSE
);

-- =========================
-- TABLE: site
-- =========================
CREATE TABLE site (
    site_id INT AUTO_INCREMENT PRIMARY KEY,
    city_id INT NOT NULL,
    name VARCHAR(150) NOT NULL,
    address VARCHAR(200) NOT NULL,
    capacity INT,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6)
);

-- =========================
-- TABLE: event
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

    CONSTRAINT fk_event_user
        FOREIGN KEY (user_id) REFERENCES user(user_id),

    CONSTRAINT fk_event_site
        FOREIGN KEY (site_id) REFERENCES site(site_id),

    CONSTRAINT chk_event_dates
        CHECK (finish_date > start_date),

    CONSTRAINT unique_event
        UNIQUE (event_name, start_date, site_id)
);

-- =========================
-- TABLE: event_layout
-- =========================
CREATE TABLE event_layout (
    event_layout_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    layout_data JSON NOT NULL,

    FOREIGN KEY (event_id)
        REFERENCES event(event_id)
);

-- =========================
-- TABLE: event_media
-- =========================
CREATE TABLE event_media (
    media_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    img_url VARCHAR(255) NOT NULL,

    FOREIGN KEY (event_id)
        REFERENCES event(event_id)
);

-- =========================
-- TABLE: event_media_log
-- =========================
CREATE TABLE event_media_log (
    media_log_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    media_id INT NOT NULL,
    img_url VARCHAR(255) NOT NULL,
    version INT NOT NULL,
    is_visible BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (event_id)
        REFERENCES event(event_id),

    FOREIGN KEY (media_id)
        REFERENCES event_media(media_id)
);

-- =========================
-- TABLE: event_rating
-- =========================
CREATE TABLE event_rating (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT,
    comment TEXT NOT NULL,
    is_visible BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP,

    FOREIGN KEY (event_id)
        REFERENCES event(event_id),

    FOREIGN KEY (user_id)
        REFERENCES user(user_id),

    CHECK (rating BETWEEN 1 AND 5)
);

-- =========================
-- TABLE: event_comment_reply
-- =========================
CREATE TABLE event_comment_reply (
    reply_id INT AUTO_INCREMENT PRIMARY KEY,
    parent_reply_id INT,
    rating_id INT NOT NULL,
    user_id INT NOT NULL,
    reply_text TEXT NOT NULL,
    is_visible BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP,

    FOREIGN KEY (parent_reply_id)
        REFERENCES event_comment_reply(reply_id),

    FOREIGN KEY (rating_id)
        REFERENCES event_rating(rating_id),

    FOREIGN KEY (user_id)
        REFERENCES user(user_id)
);

-- =========================
-- TABLE: event_status_log
-- =========================
CREATE TABLE event_status_log (
    status_log_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    old_status ENUM('DRAFT','PUBLISHED','CANCELLED','COMPLETED'),
    new_status ENUM('DRAFT','PUBLISHED','CANCELLED','COMPLETED'),
    changed_at TIMESTAMP,
    changed_by INT,

    FOREIGN KEY (event_id)
        REFERENCES event(event_id),

    FOREIGN KEY (changed_by)
        REFERENCES user(user_id)
);