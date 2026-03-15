-- Tabla department
CREATE TABLE department (
    department_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(10)
);

-- Tabla city
CREATE TABLE city (
    city_id INT PRIMARY KEY,
    department_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(10),
    
    CONSTRAINT fk_city_department
        FOREIGN KEY (department_id)
        REFERENCES department(department_id)
);

-- Tabla site
CREATE TABLE site (
    site_id INT PRIMARY KEY,
    city_id INT NOT NULL,
    name VARCHAR(150) NOT NULL,
    address VARCHAR(200) NOT NULL,
    capacity INT,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),

    CONSTRAINT fk_site_city
        FOREIGN KEY (city_id)
        REFERENCES city(city_id)
);

-- Tabla profile
CREATE TABLE profile (
    profile_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    city_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    photo_url VARCHAR(255) NOT NULL,
    bio VARCHAR(255),

    CONSTRAINT fk_profile_city
        FOREIGN KEY (city_id)
        REFERENCES city(city_id)
);

-- Tabla event
CREATE TABLE event (
    event_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    site_id INT NOT NULL,
    event_name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    finish_date DATE NOT NULL,
    status ENUM('Draft','Published','Cancelled','Completed'),
    is_public BOOLEAN DEFAULT TRUE,
    available_seats INT NOT NULL,

    CONSTRAINT fk_event_site
        FOREIGN KEY (site_id)
        REFERENCES site(site_id),

    CONSTRAINT chk_event_dates
        CHECK (finish_date > start_date),

    CONSTRAINT unique_event
        UNIQUE (event_name, start_date, site_id)
);