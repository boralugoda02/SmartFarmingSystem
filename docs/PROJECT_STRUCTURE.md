# PROJECT_STRUCTURE.md

## 1. Architectural Pattern: MVC (Model-View-Controller)
This project implements a clean 3-Tier MVC Architecture combined with the DAO (Data Access Object) pattern to separate business logic, database management, and UI rendering.



### Architecture Components:
* **Model:** Represents the blueprint of application data (Java Beans/POJOs).
* **View:** The user interface components implemented using JavaServer Pages (JSP), CSS, and JS.
* **Controller:** Servlets that intercept incoming requests, validate payloads, and forward actions.
* **Service Layer:** Contains core business logic (e.g., calculations, alerts evaluation). Bridges Controller and DAO.
* **DAO Layer:** Handles direct low-level CRUD queries with the MySQL Database using JDBC.

---

## 2. Java Package Mapping (`src/main/java`)

```text
com.smartfarming
├── controller      # Servlets handling requests/responses & session routing
├── service         # Intermediate core logic, calculations & security filters
├── dao             # Data Access Objects executing SQL queries
├── model           # Plain Old Java Objects (POJO) representing SQL entities
└── util            # Shared utility classes (DBConnection, Password Hashing)