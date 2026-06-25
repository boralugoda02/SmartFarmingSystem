CREATE DATABASE IF NOT EXISTS smart_farming_db;
USE smart_farming_db;

CREATE TABLE IF NOT EXISTS users (
                                     user_id INT AUTO_INCREMENT PRIMARY KEY,
                                     name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE IF NOT EXISTS farms (
                                     farm_id INT AUTO_INCREMENT PRIMARY KEY,
                                     farm_name VARCHAR(100) NOT NULL,
    location VARCHAR(200) NOT NULL,
    owner_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(user_id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS sensors (
                                       sensor_id INT AUTO_INCREMENT PRIMARY KEY,
                                       sensor_name VARCHAR(100) NOT NULL,
    sensor_type VARCHAR(50) NOT NULL,
    farm_id INT,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    FOREIGN KEY (farm_id) REFERENCES farms(farm_id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS sensor_readings (
                                               reading_id INT AUTO_INCREMENT PRIMARY KEY,
                                               sensor_id INT,
                                               reading_value DECIMAL(10,2) NOT NULL,
    reading_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS alerts (
                                      alert_id INT AUTO_INCREMENT PRIMARY KEY,
                                      farm_id INT,
                                      message TEXT NOT NULL,
                                      severity VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (farm_id) REFERENCES farms(farm_id) ON DELETE CASCADE
    );