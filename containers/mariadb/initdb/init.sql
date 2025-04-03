-- ./mariadb/initdb/init.sql
-- This script runs automatically on first container start if the data directory is empty.
-- It runs *after* the database specified by MARIADB_DATABASE is created.
-- It connects using the root user initially.

-- IMPORTANT: Specify the database to use (replace 'myappdb_maria' if you changed it in .env)
USE `db_example`;

-- Example: Create a sample table
CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Example: Insert some initial data
INSERT INTO products (name, price) VALUES
    ('Gadget', 19.99),
    ('Widget', 25.50);

-- Example: Grant privileges to the application user (replace names if changed in .env)
-- GRANT SELECT, INSERT, UPDATE, DELETE ON `myappdb_maria`.* TO 'myappuser_maria'@'%';
-- FLUSH PRIVILEGES;

-- Add any other initial schema setup here
