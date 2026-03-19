-- ============================================
-- D2C Unit Economics SQL Project
-- File: 12_monthly_order_volume.sql
-- Description: Monthly order volume with cumulative count
-- ============================================

USE d2c_unit_economics;

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    b.brand_name,
    COUNT(o.order_id) AS total_orders,
    SUM(COUNT(o.order_id)) OVER (PARTITION BY b.brand_name
        ORDER BY DATE_FORMAT(o.order_date, '%Y-%m')) AS cumulative_orders
FROM orders o
JOIN brands b ON o.brand_id = b.brand_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m'), b.brand_name
ORDER BY month, b.brand_name;
