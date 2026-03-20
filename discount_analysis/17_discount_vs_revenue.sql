-- ============================================
-- D2C Unit Economics SQL Project
-- File: 17_discount_vs_revenue.sql
-- Description: Discounted vs full price order comparison
-- ============================================

USE d2c_unit_economics;

SELECT
    b.brand_name,
    'Discounted' AS order_type,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.gross_revenue), 2) AS avg_gross_revenue,
    ROUND(AVG(o.discount_amount), 2) AS avg_discount,
    ROUND(AVG(o.net_revenue), 2) AS avg_net_revenue
FROM orders o
JOIN brands b ON o.brand_id = b.brand_id
WHERE o.discount_amount > 0
GROUP BY b.brand_name

UNION ALL

SELECT
    b.brand_name,
    'Full Price' AS order_type,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.gross_revenue), 2) AS avg_gross_revenue,
    0 AS avg_discount,
    ROUND(AVG(o.net_revenue), 2) AS avg_net_revenue
FROM orders o
JOIN brands b ON o.brand_id = b.brand_id
WHERE o.discount_amount = 0
GROUP BY b.brand_name
ORDER BY brand_name, order_type;
