# DATABASE_DESIGN.md

## 1. Main Entities & Relational Tables
Our Smart Farming System consists of 5 core entities that transform into relational tables:
1. **users** - Stores system users (Administrators & Farmers).
2. **farms** - Stores agricultural land details.
3. **sensors** - Stores information about hardware nodes (Temperature, Moisture, etc.).
4. **sensor_readings** - Stores historical time-series data captured by sensors.
5. **alerts** - Stores automated system warning messages.

---

## 2. Table Schemas & Data Types

### 2.1 Table: users
Stores credentials and role-based access data.

| Column Name | Data Type | Key / Constraints | Description |
| :--- | :--- | :--- | :--- |
| user_id | INT | PK, AUTO_INCREMENT | Unique identifier for each user |
| name | VARCHAR(100) | NOT NULL | Full name of the user |
| email | VARCHAR(100) | UNIQUE, NOT NULL | Used for login; cannot be duplicated |
| password | VARCHAR(255) | NOT NULL | Hashed password (BCrypt/SHA-256) |
| role | VARCHAR(20) | NOT NULL | Role identification ('ADMIN' or 'FARMER') |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Registration timestamp |

### 2.2 Table: farms
Stores individual farm locations assigned to landowners.

| Column Name | Data Type | Key / Constraints | Description |
| :--- | :--- | :--- | :--- |
| farm_id | INT | PK, AUTO_INCREMENT | Unique identifier for each farm |
| farm_name | VARCHAR(100) | NOT NULL | Name of the farm plot |
| location | VARCHAR(200) | NOT NULL | Physical address or coordinates |
| owner_id | INT | FK -> users(user_id) | Links the farm to its specific owner/farmer |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation timestamp |

### 2.3 Table: sensors
Stores IoT monitoring devices deployed in various fields.

| Column Name | Data Type | Key / Constraints | Description |
| :--- | :--- | :--- | :--- |
| sensor_id | INT | PK, AUTO_INCREMENT | Unique identifier for the sensor |
| sensor_name | VARCHAR(100) | NOT NULL | Custom label given to the sensor |
| sensor_type | VARCHAR(50) | NOT NULL | Type: 'TEMPERATURE', 'HUMIDITY', 'MOISTURE' |
| farm_id | INT | FK -> farms(farm_id) | The physical farm where the sensor is installed |
| status | VARCHAR(20) | DEFAULT 'ACTIVE' | Hardware status: 'ACTIVE', 'INACTIVE', 'FAULTY' |

### 2.4 Table: sensor_readings
Captures historical data over time. A separate table ensures historical logging instead of just overriding a single row value.

| Column Name | Data Type | Key / Constraints | Description |
| :--- | :--- | :--- | :--- |
| reading_id | INT | PK, AUTO_INCREMENT | Unique identifier for the transaction |
| sensor_id | INT | FK -> sensors(sensor_id) | Target sensor providing data |
| reading_value| DECIMAL(10,2)| NOT NULL | Precise scientific reading value |
| reading_time | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Exact date & time of the transmission |

### 2.5 Table: alerts
Logs anomalies detected by the system architecture automatically.

| Column Name | Data Type | Key / Constraints | Description |
| :--- | :--- | :--- | :--- |
| alert_id | INT | PK, AUTO_INCREMENT | Unique identifier for the alert |
| farm_id | INT | FK -> farms(farm_id) | Location where the issue occurred |
| message | TEXT | NOT NULL | Contextual descriptive alert warning text |
| severity | VARCHAR(20) | NOT NULL | Levels: 'LOW', 'MEDIUM', 'HIGH', 'CRITICAL' |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Event logging timestamp |

---

## 3. Entity Relationships (ER Model)
The relationships within the database schema are structured hierarchically as follows:

- **User to Farm (1:N):** A User (Farmer) can own or manage multiple farms, but each farm explicitly points to one registered owner_id.
- **Farm to Sensor (1:N):** A single Farm can host multiple sensors to monitor different spots, but a physical sensor node can only be installed in one farm_id.
- **Sensor to SensorReading (1:N):** One sensor can stream thousands of readings over time (capturing full history), while a single reading log points to its specific generator sensor_id.
- **Farm to Alert (1:N):** A Farm can experience multiple system anomalies resulting in many alerts, but each alert logs the specific farm_id it originated from.

```text
  [ users ] 1 -------- N [ farms ]
                            |   |
                            | 1 | 1
                            |   |
                            |   +-------- N [ alerts ]
                            V
                        N [ sensors ] 1 -------- N [ sensor_readings ]