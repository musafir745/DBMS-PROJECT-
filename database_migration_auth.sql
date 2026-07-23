USE wanderlust_db;

CREATE TABLE IF NOT EXISTS users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  phone VARCHAR(30) NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('customer', 'admin') NOT NULL DEFAULT 'customer',
  legacy_customer_id INT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_users_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO users (name, email, phone, password, role, legacy_customer_id)
SELECT
  c.name,
  c.email,
  c.phone,
  '$2b$12$.7ivXfyLDTLoADwIbfrT..yN8fxLA2lpnfODKqHh/Zhtqvd5BDy0W',
  'customer',
  c.customer_id
FROM customers c
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  phone = VALUES(phone),
  legacy_customer_id = VALUES(legacy_customer_id);

ALTER TABLE bookings DROP FOREIGN KEY fk_bookings_customers;

UPDATE bookings b
JOIN users u ON u.legacy_customer_id = b.customer_id
SET b.customer_id = u.user_id;

ALTER TABLE bookings
  ADD CONSTRAINT fk_bookings_users
  FOREIGN KEY (customer_id) REFERENCES users(user_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE;

INSERT INTO users (name, email, phone, password, role)
SELECT
  'System Administrator',
  'admin@wanderlust.com',
  '+880 1700-000000',
  '$2b$12$a/eOy0QxGeo8VlQftapDe.R033R5fEFKME9wTfqa9Q5o2xEsG1t/W',
  'admin'
WHERE NOT EXISTS (
  SELECT 1 FROM users WHERE email = 'admin@wanderlust.com'
);
