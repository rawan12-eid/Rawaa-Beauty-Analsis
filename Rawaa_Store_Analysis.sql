 -- 1. Create the Database for Rawaa Beauty Store
CREATE DATABASE IF NOT EXISTS Beauty_Store_Analysis;
USE Beauty_Store_Analysis;

-- 2. Create tables: Products, Customers, and Orders
CREATE TABLE products(
    id INT PRIMARY KEY,
    name varchar (50),
    price decimal (10, 2)
);

CREATE TABLE Customers (
    customer_id int primary key,
    customer_name varchar (50),
    email varchar (100)
);

CREATE TABLE Orders (
    order_id INT primary key,
    product_id INT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 3. Insert sample data to simulate real store transactions
INSERT INTO products VALUES (1, 'Lip Mask Strawberry', 45.00);
INSERT INTO products VALUES (2, 'Face Serum Vitamin C', 120.50);
INSERT INTO products VALUES (3, 'Body Mist Lavender', 85.00);

INSERT INTO Customers VALUES (1, 'Rawan', 'rawaneid@com');
INSERT INTO Customers VALUES (2, 'Amani', 'amani@com');
INSERT INTO Customers VALUES (3, 'Sara', 'sara@com');

INSERT INTO Orders VALUES (101, 1, 1, '2026-04-08');
INSERT INTO Orders VALUES (102, 2, 2, '2026-06-04');
INSERT INTO Orders VALUES (103, 3, 3, '2026-08-06');

-- 4. Business Analysis: Customer Loyalty Report (Views)
CREATE VIEW customer_loyalty_report AS
SELECT Customers.customer_name, SUM(price) as total_spent
FROM Orders
JOIN Customers ON Orders.customer_id = Customers.customer_id
JOIN products ON Orders.product_id = products.id
GROUP BY Customers.customer_name;

-- 5. Data Integrity: Prevent deleting products linked to active orders
ALTER TABLE Orders 
ADD CONSTRAINT fk_product_protection
FOREIGN KEY (product_id) REFERENCES products(id)
ON DELETE RESTRICT;

-- 6. Performance Optimization: Speed up search by product name
CREATE INDEX idx_product_name ON products (name);