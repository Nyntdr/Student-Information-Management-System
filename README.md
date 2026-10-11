# Student Information Management System

## Run locally

1. Make sure MySQL is running.
2. Create the database, application user, and tables using the SQL below.
3. From this directory, start PHP:

	```bash
	php -S 127.0.0.1:8000
	```

4. Open <http://127.0.0.1:8000/>. The root page redirects to the login screen.

## Database setup

The application expects these settings in `includes/connection.php`:

```text
Database: SIMS
Username: sims_user
Password: Sims@1234
Host: localhost
```

Run the following as a MySQL administrator:

```sql
CREATE DATABASE IF NOT EXISTS SIMS;
CREATE USER IF NOT EXISTS 'sims_user'@'localhost' IDENTIFIED BY 'Sims@1234';
ALTER USER 'sims_user'@'localhost' IDENTIFIED BY 'Sims@1234';
GRANT ALL PRIVILEGES ON SIMS.* TO 'sims_user'@'localhost';
FLUSH PRIVILEGES;

USE SIMS;

CREATE TABLE IF NOT EXISTS users (
	uid INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE,
	email VARCHAR(255) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL,
	role VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS students (
	sid INT AUTO_INCREMENT PRIMARY KEY,
	uid INT NOT NULL,
	sname VARCHAR(100) NOT NULL,
	age INT,
	address VARCHAR(255),
	p_phoneno VARCHAR(30),
	s_phoneno VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS subjects (
	subjectid INT AUTO_INCREMENT PRIMARY KEY,
	subject_name VARCHAR(100) NOT NULL UNIQUE,
	scode VARCHAR(50) NOT NULL UNIQUE,
	theory INT DEFAULT 0,
	practical INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS learns (
	id INT AUTO_INCREMENT PRIMARY KEY,
	sid INT NOT NULL,
	subjectid INT NOT NULL,
	UNIQUE KEY unique_learning (sid, subjectid)
);

CREATE TABLE IF NOT EXISTS attendance (
	id INT AUTO_INCREMENT PRIMARY KEY,
	sid INT NOT NULL,
	subject_name VARCHAR(100) NOT NULL,
	attendance DECIMAL(5,2) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS notice (
	id INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	description TEXT NOT NULL,
	date DATE NOT NULL
);
```

The tables are created empty. Register an account through `auth/register.php`, then add student, subject, learning, attendance, and notice records through the admin pages.

### Sample data

This repository includes Nepal-themed demo data in `database/sample_data.sql`. Import it after creating the tables:

```bash
sudo mysql SIMS < database/sample_data.sql
```

The sample login accounts are:

| Username | Password | Role |
| --- | --- | --- |
| `nepaladmin` | `Kathmandu@123` | Admin |
| `sita_kc` | `Himalaya@123` | Student |
| `ram_thapa` | `Pokhara@123` | Student |
| `anil_gurung` | `Lumbini@123` | Student |

These are local demo credentials only and must not be used in a production deployment.

## Project structure

- `auth/` contains login and registration pages and their stylesheets.
- `admin/` contains the admin dashboard and management pages.
- `student/` contains student dashboards and student-facing pages.
- `includes/` contains shared PHP configuration, including the database connection.
- `assets/css/` contains stylesheets shared by admin and student pages.
