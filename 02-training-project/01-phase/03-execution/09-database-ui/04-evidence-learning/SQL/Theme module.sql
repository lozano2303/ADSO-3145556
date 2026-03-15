-- =========================
-- THEME
-- =========================

CREATE TABLE theme (
    theme_id SERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,

    default_palette JSONB
);

-- =========================
-- USER_THEME
-- =========================

CREATE TABLE user_theme (
    user_theme_id SERIAL PRIMARY KEY,

    user_id INT NOT NULL,
    theme_id INT NOT NULL,

    is_active BOOLEAN DEFAULT TRUE,

    created_at TIMESTAMP,
    updated_at TIMESTAMP,

    FOREIGN KEY(user_id)
        REFERENCES "user"(user_id),

    FOREIGN KEY(theme_id)
        REFERENCES theme(theme_id),

    UNIQUE(user_id, theme_id)
);

-- =========================
-- THEME_CUSTOMIZATION
-- =========================

CREATE TABLE theme_customization (
    customization_id SERIAL PRIMARY KEY,

    user_theme_id INT NOT NULL,

    property VARCHAR(100) NOT NULL,
    value VARCHAR(255),

    created_at TIMESTAMP,
    updated_at TIMESTAMP,

    FOREIGN KEY(user_theme_id)
        REFERENCES user_theme(user_theme_id)
);

-- =========================
-- THEME_LOG
-- =========================

CREATE TABLE theme_log (
    log_id SERIAL PRIMARY KEY,

    user_theme_id INT NOT NULL,

    action VARCHAR(50),
    property VARCHAR(100),

    old_value VARCHAR(255),
    new_value VARCHAR(255),

    FOREIGN KEY(user_theme_id)
        REFERENCES user_theme(user_theme_id)
);