-- ============================================
-- D2C Unit Economics SQL Project
-- File: 06_cohort_repeat_rate.sql
-- Description: Repeat Rate and Cohort Analysis
-- ============================================

USE d2c_unit_economics;

-- Repeat purchase rate by brand
SELECT
    b.brand_name,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN o.order_number >= 2 THEN c.customer_id END) AS repeat_customers,
    ROUND(
        COUNT(DISTINCT CASE WHEN o.order_number >= 2 THEN c.customer_id END)
        / COUNT(DISTINCT c.customer_id) * 100, 2
    ) AS repeat_rate_pct
FROM customers c
JOIN brands b ON c.brand_id = b.brand_id
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY b.brand_name
ORDER BY repeat_rate_pct DESC;

-- Cohort analysis: Jan 2025 customers returning in Feb and Mar
SELECT
    b.brand_name,
    COUNT(DISTINCT c.customer_id) AS jan_cohort_size,
    COUNT(DISTINCT CASE
        WHEN MONTH(o.order_date) = 2 AND YEAR(o.order_date) = 2025
        THEN o.customer_id END) AS returned_in_feb,
    COUNT(DISTINCT CASE
        WHEN MONTH(o.order_date) = 3 AND YEAR(o.order_date) = 2025
        THEN o.customer_id END) AS returned_in_mar,
    ROUND(COUNT(DISTINCT CASE
        WHEN MONTH(o.order_date) = 2 AND YEAR(o.order_date) = 2025
        THEN o.customer_id END)
        / COUNT(DISTINCT c.customer_id) * 100, 2) AS month2_retention_pct,
    ROUND(COUNT(DISTINCT CASE
        WHEN MONTH(o.order_date) = 3 AND YEAR(o.order_date) = 2025
        THEN o.customer_id END)
        / COUNT(DISTINCT c.customer_id) * 100, 2) AS month3_retention_pct
FROM customers c
JOIN brands b ON c.brand_id = b.brand_id
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE MONTH(c.acquisition_date) = 1 AND YEAR(c.acquisition_date) = 2025
GROUP BY b.brand_name;
