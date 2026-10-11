# Student Information Management System

## Run locally

1. Make sure MySQL is running and the `SIMS` database contains the application tables.
2. From this directory, start PHP:

	```bash
	php -S 127.0.0.1:8000
	```

3. Open <http://127.0.0.1:8000/>. The root page redirects to the login screen.

## Project structure

- `auth/` contains login and registration pages and their stylesheets.
- `admin/` contains the admin dashboard and management pages.
- `student/` contains student dashboards and student-facing pages.
- `includes/` contains shared PHP configuration, including the database connection.
- `assets/css/` contains stylesheets shared by admin and student pages.
