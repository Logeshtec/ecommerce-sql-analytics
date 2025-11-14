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

select* from customers;
 / 
-- categories
CREATE TABLE categories (
  category_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  description TEXT
);

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

select *from products; 

-- orders
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(30), -- e.g., 'placed','shipped','delivered','cancelled'
  total_amount NUMERIC(12,2)
);
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