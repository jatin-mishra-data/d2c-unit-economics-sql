-- ============================================
-- D2C Unit Economics SQL Project
-- File: 19_discount_by_channel.sql
-- Description: Discount rate by acquisition channel
-- ============================================

USE d2c_unit_economics;

SELECT
    c.acquisition_channel,
    COUNT(o.order_id) AS total_orders,
    COUNT(CASE WHEN o.discount_amount > 0 THEN 1 END) AS discounted_orders,
    ROUND(COUNT(CASE WHEN o.discount_amount > 0 THEN 1 END)
        / COUNT(o.order_id) * 100, 2) AS discount_rate_pct,
    ROUND(AVG(o.net_revenue), 2) AS avg_net_revenue,
    ROUND(SUM(o.discount_amount), 2) AS total_discounts_given
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.acquisition_channel
ORDER BY discount_rate_pct DESC;
