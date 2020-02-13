CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(50) )

CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(50),
  price DECIMAL )

CREATE TABLE orders ( 
order_id SERIAL PRIMARY KEY,
user_id INTEGER,
amount DECIMAL )

INSERT INTO users (name, email)
VALUES ('Dean Winchester', 'dw@yahoo.com'),
('Derek Morgan', 'dm@gmail.com'),
('Chris Bridges', 'cb@aol.com')

INSERT INTO products (product_name, price)
VALUES ('Impala', 299.99),
('Milan', 325.78),
('Eclipse', 634.19)

INSERT INTO orders (user_id, amount)
VALUES (2, 325.78),
(3, 299.99),
(1, 634.19),
(2, 634.19)

SELECT product_id FROM orders WHERE order_id = 1

SELECT amount FROM orders WHERE order_id = 2

ALTER TABLE orders
ADD FOREIGN KEY (user_id) REFERENCES users (id)

SELECT orders.order_id, users.name
FROM orders
JOIN users
ON orders.user_id = users.id

SELECT * FROM orders WHERE user_id = 2

SELECT COUNT (order_id) FROM orders GROUP BY user_id

SELECT SUM (amount) FROM orders

