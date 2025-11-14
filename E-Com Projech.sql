create database ecom;
use ecom;
show databases
/
-- customers
CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(150) UNIQUE,
  phone VARCHAR(20),
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- insert
-- ========================
INSERT INTO customers (first_name, last_name, email, phone, city, state, country)
VALUES
('Rahul', 'Sharma', 'rahul.sharma@example.com', '9876543210', 'Mumbai', 'Maharashtra', 'India'),
('Priya', 'Menon', 'priya.menon@example.com', '9876501234', 'Chennai', 'Tamil Nadu', 'India'),
('Amit', 'Patel', 'amit.patel@example.com', '9876512345', 'Ahmedabad', 'Gujarat', 'India'),
('Sneha', 'Verma', 'sneha.verma@example.com', '9876523456', 'Delhi', 'Delhi', 'India'),
('Ravi', 'Kumar', 'ravi.kumar@example.com', '9876534567', 'Hyderabad', 'Telangana', 'India'),
('Neha', 'Gupta', 'neha.gupta@example.com', '9876545678', 'Kolkata', 'West Bengal', 'India'),
('Vikram', 'Nair', 'vikram.nair@example.com', '9876556789', 'Bangalore', 'Karnataka', 'India'),
('Aishwarya', 'Iyer', 'aish.iyer@example.com', '9876567890', 'Pune', 'Maharashtra', 'India'),
('Deepak', 'Singh', 'deepak.singh@example.com', '9876578901', 'Jaipur', 'Rajasthan', 'India'),
('Kavya', 'Rao', 'kavya.rao@example.com', '9876589012', 'Cochin', 'Kerala', 'India');

select* from customers;
 / 
-- categories
CREATE TABLE categories (
  category_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  description TEXT
);
-- insert 
-- ========================
INSERT INTO categories (name, description) VALUES
('Electronics', 'Devices and gadgets'),
('Clothing', 'Men and women fashion'),
('Home Appliances', 'Household electrical items'),
('Books', 'Printed and digital books'),
('Sports', 'Sports and fitness equipment'),
('Beauty', 'Cosmetics and skincare'),
('Toys', 'Children toys and games'),
('Furniture', 'Home and office furniture'),
('Groceries', 'Daily use grocery items'),
('Accessories', 'Watches, bags, belts, etc.');

select* from categories;

-- products
CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(200),
  category_id INT REFERENCES categories(category_id),
  price NUMERIC(10,2),
  sku VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- ========================
INSERT INTO products (name, category_id, price, sku)
VALUES
('Smartphone X100', 1, 699.99, 'ELEC100'),
('Laptop Pro 15"', 1, 1099.00, 'ELEC200'),
('Men T-Shirt', 2, 19.99, 'CLTH101'),
('Air Conditioner', 3, 350.00, 'HOME301'),
('Yoga Mat', 5, 25.50, 'SPRT501'),
('Lipstick Rose', 6, 12.00, 'BEAU601'),
('Kids Puzzle Set', 7, 15.75, 'TOY701'),
('Wooden Dining Table', 8, 499.99, 'FURN801'),
('Organic Rice 5kg', 9, 9.50, 'GROC901'),
('Leather Wallet', 10, 35.00, 'ACCS1001');

select *from products; 

-- orders
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(30), -- e.g., 'placed','shipped','delivered','cancelled'
  total_amount NUMERIC(12,2)
);
-- ========================
INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
(1, '2025-01-05', 'delivered', 750.00),
(2, '2025-01-12', 'delivered', 1100.00),
(3, '2025-02-20', 'cancelled', 25.50),
(4, '2025-03-11', 'delivered', 400.00),
(5, '2025-03-15', 'shipped', 499.99),
(6, '2025-04-01', 'delivered', 35.00),
(7, '2025-04-10', 'delivered', 19.99),
(8, '2025-05-22', 'delivered', 699.99),
(9, '2025-06-05', 'delivered', 9.50),
(10, '2025-06-08', 'processing', 15.75);
select*from orders;
-- order_items
CREATE TABLE order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id INT REFERENCES orders(order_id),
  product_id INT REFERENCES products(product_id),
  quantity INT,
  unit_price NUMERIC(10,2),
  discount NUMERIC(6,2) DEFAULT 0
);
-- ========================
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount)
VALUES
(1, 1, 1, 699.99, 0),
(1, 3, 2, 19.99, 5),
(2, 2, 1, 1099.00, 0),
(3, 5, 1, 25.50, 0),
(4, 4, 1, 350.00, 0),
(5, 8, 1, 499.99, 0),
(6, 10, 1, 35.00, 0),
(7, 3, 1, 19.99, 0),
(8, 1, 1, 699.99, 0),
(9, 9, 1, 9.50, 0);
select* from order_items;

-- payments
CREATE TABLE payments (
  payment_id SERIAL PRIMARY KEY,
  order_id INT REFERENCES orders(order_id),
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  amount NUMERIC(12,2),
  payment_method VARCHAR(50), -- e.g., 'card','upi','netbanking','cod'
  payment_status VARCHAR(30)  -- 'paid','failed','refunded'
);
INSERT INTO payments (order_id, payment_date, amount, payment_method, payment_status)
VALUES
(1, '2025-01-05', 750.00, 'Card', 'paid'),
(2, '2025-01-12', 1100.00, 'UPI', 'paid'),
(3, '2025-02-20', 25.50, 'Card', 'refunded'),
(4, '2025-03-11', 400.00, 'NetBanking', 'paid'),
(5, '2025-03-15', 499.99, 'UPI', 'paid'),
(6, '2025-04-01', 35.00, 'COD', 'paid'),
(7, '2025-04-10', 19.99, 'Card', 'paid'),
(8, '2025-05-22', 699.99, 'UPI', 'paid'),
(9, '2025-06-05', 9.50, 'Card', 'paid'),
(10, '2025-06-08', 15.75, 'UPI', 'pending');
select * from payments;
/
-- shipments
CREATE TABLE shipments (
  shipment_id SERIAL PRIMARY KEY,
  order_id INT REFERENCES orders(order_id),
  shipped_date TIMESTAMP,
  delivered_date TIMESTAMP,
  courier VARCHAR(100),
  tracking_number VARCHAR(100)
);
-- ========================
INSERT INTO shipments (order_id, shipped_date, delivered_date, courier, tracking_number)
VALUES
(1, '2025-01-06', '2025-01-08', 'BlueDart', 'BD12345'),
(2, '2025-01-13', '2025-01-15', 'DTDC', 'DT45678'),
(3, '2025-02-21', NULL, 'EcomExpress', 'EE78901'),
(4, '2025-03-12', '2025-03-14', 'Delhivery', 'DL23456'),
(5, '2025-03-16', NULL, 'BlueDart', 'BD56789'),
(6, '2025-04-02', '2025-04-03', 'EcomExpress', 'EE34567'),
(7, '2025-04-11', '2025-04-13', 'DTDC', 'DT56789'),
(8, '2025-05-23', '2025-05-25', 'Delhivery', 'DL67890'),
(9, '2025-06-06', '2025-06-07', 'BlueDart', 'BD78901'),
(10, '2025-06-09', NULL, 'DTDC', 'DT89012');
select*from shipments;
-- reviews
CREATE TABLE reviews (
  review_id SERIAL PRIMARY KEY,
  product_id INT REFERENCES products(product_id),
  customer_id INT REFERENCES customers(customer_id),
  rating SMALLINT CHECK (rating BETWEEN 1 AND 5),
  review_text TEXT,
  review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- ========================
INSERT INTO reviews (product_id, customer_id, rating, review_text)
VALUES
(1, 1, 5, 'Excellent phone, good performance!'),
(2, 2, 4, 'Good laptop but slightly heavy.'),
(3, 4, 5, 'Comfortable and good quality.'),
(4, 5, 4, 'Cools well, a bit noisy.'),
(5, 3, 3, 'Average yoga mat.'),
(6, 6, 5, 'Beautiful shade and long-lasting.'),
(7, 9, 4, 'Kids love it!'),
(8, 7, 5, 'Sturdy and looks premium.'),
(9, 10, 5, 'Fresh and great quality rice.'),
(10, 8, 4, 'Nice leather and stylish.');
/
-- Indexes & constraints (add after creating data)
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
CREATE INDEX idx_customers_created_at ON customers(created_at);
CREATE INDEX idx_products_category ON products(category_id);
/
-- 1. Total revenue
SELECT SUM(total_amount) AS total_revenue FROM orders WHERE status <> 'cancelled';

-- 2. Orders count by status
SELECT status, COUNT(*) FROM orders GROUP BY status;

-- 3. Top 10 selling products by quantity
SELECT p.product_id, p.name, SUM(oi.quantity) AS total_qty
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.status = 'delivered'
GROUP BY p.product_id, p.name
ORDER BY total_qty DESC
LIMIT 5;

-- 4. Top 10 products by revenue
SELECT p.product_id, p.name, SUM(oi.quantity * oi.unit_price - oi.discount) AS revenue
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY revenue DESC
LIMIT 3;

-- =======
-- 5. Monthly revenue for last 12 months
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(o.total_amount) AS revenue
FROM orders o
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
  AND o.status = 'delivered'
GROUP BY month
ORDER BY month;

DESCRIBE orders;

-- 6. Daily orders and average order value (last 30 days)
SELECT 
    DATE(o.order_date) AS day,
    COUNT(*) AS orders_count,
    AVG(o.total_amount) AS avg_order_value
FROM orders o
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 5 DAY)
GROUP BY day
ORDER BY day;

-- ========

-- 7. Top customers by lifetime spend
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS name,
       SUM(o.total_amount) AS lifetime_spend,
       COUNT(o.order_id) AS orders_count
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status = 'delivered'
GROUP BY c.customer_id, name
ORDER BY lifetime_spend DESC
LIMIT 7;

-- 8. New vs returning cohort (simplified)
WITH first_order AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id
)
SELECT 
    DATE_FORMAT(first_order_date, '%Y-%m-01') AS cohort_month,
    COUNT(*) AS new_customers
FROM first_order
GROUP BY cohort_month
ORDER BY cohort_month;


-- 9. RFM (recency, frequency, monetary) example
WITH last_order AS (
  SELECT 
      customer_id, 
      MAX(order_date) AS last_order_date, 
      COUNT(*) AS freq, 
      SUM(total_amount) AS monetary
  FROM orders
  WHERE status = 'delivered'
  GROUP BY customer_id
)
SELECT 
    c.customer_id,
    DATEDIFF(CURDATE(), l.last_order_date) AS recency_days,
    l.freq, 
    l.monetary
FROM last_order l
JOIN customers c 
    ON l.customer_id = c.customer_id
ORDER BY l.monetary DESC
LIMIT 5;


-- 10. Retention: % customers placing order in month t+1 who ordered in month t (simplified)
WITH monthly_customers AS (
  SELECT 
      DATE_FORMAT(order_date, '%Y-%m-01') AS month,
      customer_id
  FROM orders
  WHERE status = 'delivered'
  GROUP BY month, customer_id
)
SELECT 
    m1.month,
    COUNT(DISTINCT m1.customer_id) AS customers_month,
    COUNT(DISTINCT m2.customer_id) AS customers_next_month,
    (COUNT(DISTINCT m2.customer_id) / NULLIF(COUNT(DISTINCT m1.customer_id), 0)) * 100 AS retention_pct
FROM monthly_customers m1
LEFT JOIN monthly_customers m2 
       ON m2.customer_id = m1.customer_id
      AND m2.month = DATE_FORMAT(DATE_ADD(m1.month, INTERVAL 1 MONTH), '%Y-%m-01')
GROUP BY m1.month
ORDER BY m1.month;

/

CREATE VIEW vw_monthly_revenue AS
SELECT 
    DATE_FORMAT(order_date, '%Y-%m-01') AS month,
    SUM(total_amount) AS revenue
FROM orders
WHERE status = 'delivered'
GROUP BY month;





