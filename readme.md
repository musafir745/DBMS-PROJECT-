# WanderLust: Hotel Booking DBMS

WanderLust is a Node.js, Express.js, EJS, Bootstrap, and MySQL hotel booking system with separate customer and administrator panels.

MongoDB and Mongoose are not used. The database layer uses MySQL through `mysql2`, and passwords use `bcrypt` hashes.

## Roles and Panels

### Customer Panel

- Register, login, and logout
- View and update their own profile
- Browse hotel listings
- Create booking requests
- View only their own bookings
- Cancel only their own pending or confirmed bookings

### Admin Panel

- Separate administrator login and logout
- Dashboard statistics for listings, rooms, customers, bookings, and pending bookings
- Manage listings and rooms
- View, create, edit, cancel, and delete all bookings
- View, edit, and delete users

## Database Setup

Use one SQL option only.

### Fresh setup

Import `database.sql` through XAMPP/phpMyAdmin. It recreates `wanderlust_db` with:

- `users` with `customer` and `admin` roles
- `hotels`
- `rooms`
- `bookings`

This script drops the four project tables before creating fresh sample data.

### Existing converted project database

If you already imported the earlier schema and want to preserve its hotel, room, customer, and booking records, run `database_migration_auth.sql` once. It migrates old customer records into `users`, reconnects bookings to users, and creates the administrator account.

## Sample Accounts

| Panel | Email | Password |
| --- | --- | --- |
| Admin | `admin@wanderlust.com` | `Admin@123` |
| Customer | `ayesha@example.com` | `Customer@123` |

All passwords in MySQL are stored as bcrypt hashes. Do not store plaintext passwords.

## Run With XAMPP

1. Start MySQL in XAMPP.
2. Import the relevant SQL file in phpMyAdmin.
3. Copy `.env.example` to `.env` and set your own session secret.
4. Install dependencies:

```bash
npm install
```

5. Start the application:

```bash
npm start
```

6. Open `http://localhost:8080`.

## Important Routes

| Area | Routes |
| --- | --- |
| Public listings | `/listings` |
| Customer auth | `/auth/register`, `/auth/login` |
| Customer panel | `/customer/dashboard`, `/customer/profile`, `/customer/bookings` |
| Admin login | `/admin/login` |
| Admin dashboard | `/admin/dashboard` |
| Admin listing management | `/listings` |
| Admin room management | `/rooms` |
| Admin booking management | `/bookings` |
| Admin user management | `/customers` |

Customers are blocked from all administrator management routes. Administrators can inspect customer data through Manage Users.
