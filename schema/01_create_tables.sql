-- ============================================
-- D2C Unit Economics SQL Project
-- File: 01_create_tables.sql
-- Description: Create all tables
-- ============================================

CREATE DATABASE IF NOT EXISTS d2c_unit_economics;
USE d2c_unit_economics;

-- Brands
CREATE TABLE brands (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    founded_year INT,
    channel VARCHAR(50)
);

-- Customers
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_id INT NOT NULL,
    acquisition_channel VARCHAR(50),
    acquisition_date DATE NOT NULL,
    city VARCHAR(50),
    age_group VARCHAR(20),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id)
);

-- Marketing Spend
CREATE TABLE marketing_spend (
    spend_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_id INT NOT NULL,
    channel VARCHAR(50),
    spend_month DATE,
    amount_spent DECIMAL(12,2),
    new_customers_acquired INT,
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id)
);

-- Orders
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    brand_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_number INT DEFAULT 1,
    gross_revenue DECIMAL(10,2),
    discount_amount DECIMAL(10,2) DEFAULT 0,
    net_revenue DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id)
);

-- Product Costs
CREATE TABLE product_costs (
    cost_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_id INT NOT NULL,
    cost_month DATE,
    avg_cogs_per_order DECIMAL(10,2),
    avg_shipping_per_order DECIMAL(10,2),
    avg_payment_gateway DECIMAL(10,2),
    avg_returns_cost DECIMAL(10,2),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id)
);
