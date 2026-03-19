-- ============================================
-- D2C Unit Economics SQL Project
-- File: 03_cac_analysis.sql
-- Description: Customer Acquisition Cost
-- ============================================

USE d2c_unit_economics;

-- CAC by Brand and Channel (monthly)
SELECT
    b.brand_name,
    ms.channel,
    DATE_FORMAT(ms.spend_month, '%Y-%m') AS month,
    ms.amount_spent AS total_spend,
    ms.new_customers_acquired,
    ROUND(ms.amount_spent / ms.new_customers_acquired, 2) AS cac
FROM marketing_spend ms
JOIN brands b ON ms.brand_id = b.brand_id
ORDER BY b.brand_name, ms.spend_month;

-- Blended CAC per brand (all channels combined)
SELECT
    b.brand_name,
    DATE_FORMAT(ms.spend_month, '%Y-%m') AS month,
    SUM(ms.amount_spent) AS total_spend,
    SUM(ms.new_customers_acquired) AS total_customers,
    ROUND(SUM(ms.amount_spent) / SUM(ms.new_customers_acquired), 2) AS blended_cac
FROM marketing_spend ms
JOIN brands b ON ms.brand_id = b.brand_id
GROUP BY b.brand_name, ms.spend_month
ORDER BY b.brand_name, ms.spend_month;
