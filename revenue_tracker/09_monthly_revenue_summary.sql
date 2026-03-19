-- ============================================
-- D2C Unit Economics SQL Project
-- File: 09_monthly_revenue_summary.sql
-- Description: Total revenue per month
-- ============================================

USE d2c_unit_economics;

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(gross_revenue), 2) AS total_gross_revenue,
    ROUND(SUM(discount_amount), 2) AS total_discounts,
    ROUND(SUM(net_revenue), 2) AS total_net_revenue,
    ROUND(AVG(net_revenue), 2) AS avg_order_value
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;
