-- ENUM para estado de entrega
CREATE TYPE delivered_status_enum AS ENUM (
    'Pending',
    'Sent',
    'Delivered',
    'Failed'
);

-- Tabla notification_type
CREATE TABLE notification_type (
    notification_type_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(100) NOT NULL,
    active BOOLEAN DEFAULT TRUE
);

-- Tabla channel
CREATE TABLE channel (
    channel_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(100) NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    config JSONB
);

-- Tabla user
CREATE TABLE "user" (
    user_id INT PRIMARY KEY,
    user_status_id INT,
    role_id INT,
    alias VARCHAR(50) NOT NULL UNIQUE,
    activated BOOLEAN DEFAULT FALSE
);

-- Tabla notification
CREATE TABLE notification (
    notification_id INT PRIMARY KEY,
    channel_id INT,
    notification_type_id INT,
    event_id INT,
    subject VARCHAR(150) NOT NULL,
    body TEXT NOT NULL,
    sent_at TIMESTAMP,

    CONSTRAINT fk_notification_channel
        FOREIGN KEY (channel_id) REFERENCES channel(channel_id),

    CONSTRAINT fk_notification_type
        FOREIGN KEY (notification_type_id) REFERENCES notification_type(notification_type_id)
);

-- Tabla notification_user
CREATE TABLE notification_user (
    notification_user_id INT PRIMARY KEY,
    notification_id INT NOT NULL,
    user_id INT NOT NULL,
    email_address VARCHAR(255) NOT NULL,
    delivered_status delivered_status_enum,
    error_message TEXT,
    read_at TIMESTAMP,

    CONSTRAINT fk_notification_user_notification
        FOREIGN KEY (notification_id) REFERENCES notification(notification_id),

    CONSTRAINT fk_notification_user_user
        FOREIGN KEY (user_id) REFERENCES "user"(user_id),

    CONSTRAINT unique_notification_user
        UNIQUE (notification_id, user_id)
);