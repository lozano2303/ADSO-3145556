-- -----------------
-- IDIOMAS
-- -----------------
CREATE TABLE language (
  language_id INT PRIMARY KEY,
  code VARCHAR(10) NOT NULL,
  name VARCHAR(50) NOT NULL,
  is_active BOOLEAN DEFAULT TRUE
);

-- -----------------
-- UBICACION
-- -----------------
CREATE TABLE department (
  department_id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  code VARCHAR(10)
);

CREATE TABLE city (
  city_id INT PRIMARY KEY,
  department_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  code VARCHAR(10),
  FOREIGN KEY (department_id) REFERENCES department(department_id)
);

CREATE TABLE site (
  site_id INT PRIMARY KEY,
  city_id INT NOT NULL,
  name VARCHAR(150) NOT NULL,
  address VARCHAR(200) NOT NULL,
  capacity INT,
  latitude DECIMAL(9,6),
  longitude DECIMAL(9,6),
  FOREIGN KEY (city_id) REFERENCES city(city_id)
);

-- -----------------
-- PERFIL
-- -----------------
CREATE TABLE profile (
  profile_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  city_id INT NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  photo_url VARCHAR(255),
  bio VARCHAR(255),
  FOREIGN KEY (city_id) REFERENCES city(city_id)
);

-- -----------------
-- EVENTOS
-- -----------------
CREATE TABLE event (
  event_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  site_id INT NOT NULL,
  event_name VARCHAR(100) NOT NULL,
  description VARCHAR(255) NOT NULL,
  start_date DATE NOT NULL,
  finish_date DATE NOT NULL,
  status VARCHAR(20),
  is_public BOOLEAN DEFAULT TRUE,
  available_seats INT NOT NULL,

  FOREIGN KEY (site_id) REFERENCES site(site_id),

  CHECK (finish_date > start_date),
  UNIQUE (event_name, start_date, site_id)
);

-- -----------------
-- CATEGORIAS
-- -----------------
CREATE TABLE category (
  category_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(100),
  active BOOLEAN DEFAULT TRUE,
  visible BOOLEAN DEFAULT TRUE,
  tag_id INT
);

-- -----------------
-- TEMAS
-- -----------------
CREATE TABLE theme (
  theme_id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(255),
  default_palette JSON
);

-- -----------------
-- SECCIONES
-- -----------------
CREATE TABLE section_type (
  section_type_id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- -----------------
-- BLOQUES DE ASIENTO
-- -----------------
CREATE TABLE seat_block (
  seat_block_id INT PRIMARY KEY,
  event_section_id INT,
  name VARCHAR(100) NOT NULL,
  capacity INT NOT NULL
);

-- -----------------
-- CALIFICACION EVENTO
-- -----------------
CREATE TABLE event_rating (
  rating_id INT PRIMARY KEY,
  event_id INT NOT NULL,
  user_id INT NOT NULL,
  rating INT CHECK (rating BETWEEN 1 AND 5),
  comment VARCHAR(255),
  is_visible BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP,
  FOREIGN KEY (event_id) REFERENCES event(event_id)
);

-- -----------------
-- RESPUESTAS A COMENTARIOS
-- -----------------
CREATE TABLE event_comment_reply (
  reply_id INT PRIMARY KEY,
  parent_reply_id INT,
  rating_id INT NOT NULL,
  user_id INT NOT NULL,
  reply_text VARCHAR(255) NOT NULL,
  is_visible BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP,
  FOREIGN KEY (rating_id) REFERENCES event_rating(rating_id)
);

-- -----------------
-- REVIEWS
-- -----------------
CREATE TABLE review (
  review_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  event_id INT NOT NULL,
  rating INT CHECK (rating BETWEEN 1 AND 5),
  comment VARCHAR(255),
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  FOREIGN KEY (event_id) REFERENCES event(event_id)
);

-- -----------------
-- TIPOS DE NOTIFICACION
-- -----------------
CREATE TABLE notification_type (
  notification_type_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(100),
  active BOOLEAN DEFAULT TRUE
);

-- -----------------
-- CANALES
-- -----------------
CREATE TABLE channel (
  channel_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(100),
  active BOOLEAN DEFAULT TRUE,
  config JSON
);

-- -----------------
-- NOTIFICACIONES
-- -----------------
CREATE TABLE notification (
  notification_id INT PRIMARY KEY,
  channel_id INT,
  notification_type_id INT,
  event_id INT,
  subject VARCHAR(150) NOT NULL,
  body TEXT,
  sent_at TIMESTAMP,

  FOREIGN KEY (channel_id) REFERENCES channel(channel_id),
  FOREIGN KEY (notification_type_id) REFERENCES notification_type(notification_type_id),
  FOREIGN KEY (event_id) REFERENCES event(event_id)
);

-- =====================================
-- TRADUCCIONES (MULTI IDIOMA)
-- =====================================

CREATE TABLE event_translation (
  translation_id INT PRIMARY KEY,
  event_id INT NOT NULL,
  language_id INT NOT NULL,
  translated_name VARCHAR(100),
  translated_description VARCHAR(255),
  status VARCHAR(20),

  FOREIGN KEY (event_id) REFERENCES event(event_id),
  FOREIGN KEY (language_id) REFERENCES language(language_id),

  UNIQUE (event_id, language_id)
);

CREATE TABLE category_translation (
  translation_id INT PRIMARY KEY,
  category_id INT NOT NULL,
  language_id INT NOT NULL,
  translated_name VARCHAR(100),
  translated_description VARCHAR(255),
  source VARCHAR(50),
  status VARCHAR(20),

  FOREIGN KEY (category_id) REFERENCES category(category_id),
  FOREIGN KEY (language_id) REFERENCES language(language_id),

  UNIQUE (category_id, language_id)
);

CREATE TABLE profile_translation (
  translation_id INT PRIMARY KEY,
  profile_id INT NOT NULL,
  language_id INT NOT NULL,
  translated_bio VARCHAR(255),
  source VARCHAR(50),
  status VARCHAR(20),

  FOREIGN KEY (profile_id) REFERENCES profile(profile_id),
  FOREIGN KEY (language_id) REFERENCES language(language_id),

  UNIQUE (profile_id, language_id)
);

CREATE TABLE theme_translation (
  translation_id INT PRIMARY KEY,
  theme_id INT NOT NULL,
  language_id INT NOT NULL,
  translated_name VARCHAR(100),
  translated_description VARCHAR(255),
  source VARCHAR(50),
  status VARCHAR(20),

  FOREIGN KEY (theme_id) REFERENCES theme(theme_id),
  FOREIGN KEY (language_id) REFERENCES language(language_id),

  UNIQUE (theme_id, language_id)
);

CREATE TABLE review_translation (
  translation_id INT PRIMARY KEY,
  review_id INT NOT NULL,
  language_id INT NOT NULL,
  translated_comment VARCHAR(255),
  source VARCHAR(50),
  status VARCHAR(20),

  FOREIGN KEY (review_id) REFERENCES review(review_id),
  FOREIGN KEY (language_id) REFERENCES language(language_id),

  UNIQUE (review_id, language_id)
);