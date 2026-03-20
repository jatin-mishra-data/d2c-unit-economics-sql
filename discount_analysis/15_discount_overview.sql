-- ============================================
-- D2C Unit Economics SQL Project
-- File: 15_discount_overview.sql
-- Description: Overall discount stats
-- ============================================

USE d2c_unit_economics;

SELECT
    COUNT(order_id) AS total_orders,
    COUNT(CASE WHEN discount_amount > 0 THEN 1 END) AS discounted_orders,
    COUNT(CASE WHEN discount_amount = 0 THEN 1 END) AS full_price_orders,
    ROUND(COUNT(CASE WHEN discount_amount > 0 THEN 1 END)
        / COUNT(order_id) * 100, 2) AS discount_rate_pct,
    ROUND(SUM(discount_amount), 2) AS total_discount_given,
    ROUND(AVG(CASE WHEN discount_amount > 0
        THEN discount_amount END), 2) AS avg_discount_when_applied,
    ROUND(SUM(gross_revenue), 2) AS total_gross_revenue,
    ROUND(SUM(net_revenue), 2) AS total_net_revenue,
    ROUND(SUM(discount_amount) / SUM(gross_revenue) * 100, 2) AS overall_discount_pct
FROM orders;
