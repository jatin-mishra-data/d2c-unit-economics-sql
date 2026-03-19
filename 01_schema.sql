-- D2C UNIT ECONOMICS DATABASE SCHEMA
-- Project: D2C Unit Economics Analysis
-- Author: Jatin Mishra
-- Date: 2024

-- Create Database
CREATE DATABASE d2c_analysis;
USE d2c_analysis;

-- Table 1: Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    signup_date DATE NOT NULL,
    acquisition_source VARCHAR(50),
    acquisition_cost DECIMAL(10,2),
    status VARCHAR(20)
);

-- [COPY COMPLETE SCHEMA FROM PROJECT FILE]
-- (You'll paste the full schema here)
