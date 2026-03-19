-- ============================================
-- D2C Unit Economics SQL Project
-- File: 13_avg_order_value_trend.sql
-- Description: AOV and discount trend by brand
-- ============================================

USE d2c_unit_economics;

SELECT
    b.brand_name,
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    ROUND(AVG(o.gross_revenue), 2) AS avg_gross_order_value,
    ROUND(AVG(o.discount_amount), 2) AS avg_discount,
    ROUND(AVG(o.net_revenue), 2) AS avg_net_order_value,
    ROUND(AVG(o.discount_amount) / AVG(o.gross_revenue) * 100, 2) AS discount_pct
FROM orders o
JOIN brands b ON o.brand_id = b.brand_id
GROUP BY b.brand_name, DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY b.brand_name, month;
