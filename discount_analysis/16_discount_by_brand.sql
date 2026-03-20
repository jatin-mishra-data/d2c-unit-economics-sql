-- ============================================
-- D2C Unit Economics SQL Project
-- File: 16_discount_by_brand.sql
-- Description: Discount analysis by brand
-- ============================================

USE d2c_unit_economics;

SELECT
    b.brand_name,
    COUNT(o.order_id) AS total_orders,
    COUNT(CASE WHEN o.discount_amount > 0 THEN 1 END) AS discounted_orders,
    ROUND(COUNT(CASE WHEN o.discount_amount > 0 THEN 1 END)
        / COUNT(o.order_id) * 100, 2) AS discount_rate_pct,
    ROUND(SUM(o.discount_amount), 2) AS total_discounts,
    ROUND(AVG(CASE WHEN o.discount_amount > 0
        THEN o.discount_amount END), 2) AS avg_discount_when_applied,
    ROUND(AVG(o.gross_revenue), 2) AS avg_gross_aov,
    ROUND(AVG(o.net_revenue), 2) AS avg_net_aov,
    ROUND(SUM(o.discount_amount) / SUM(o.gross_revenue) * 100, 2) AS discount_pct_of_revenue
FROM orders o
JOIN brands b ON o.brand_id = b.brand_id
GROUP BY b.brand_name
ORDER BY discount_rate_pct DESC;
