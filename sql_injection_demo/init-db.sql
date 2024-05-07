CREATE DATABASE IF NOT EXISTS demo;
USE demo;

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

INSERT INTO products (name, price) VALUES ('Laptop', 999.99);
INSERT INTO products (name, price) VALUES ('Phone', 299.99);
INSERT INTO products (name, price) VALUES ('Tablet', 399.99);
