-- ============================================
-- D2C Unit Economics SQL Project
-- File: 10_brand_monthly_revenue.sql
-- Description: Revenue breakdown by brand each month
-- ============================================

USE d2c_unit_economics;

SELECT
    b.brand_name,
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.net_revenue), 2) AS net_revenue,
    ROUND(AVG(o.net_revenue), 2) AS avg_order_value
FROM orders o
JOIN brands b ON o.brand_id = b.brand_id
GROUP BY b.brand_name, DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY b.brand_name, month;
