-- ============================================
-- D2C Unit Economics SQL Project
-- File: 20_discount_summary_view.sql
-- Description: Master discount analysis view
-- ============================================

USE d2c_unit_economics;

CREATE OR REPLACE VIEW v_discount_analysis AS
SELECT
    b.brand_name,
    COUNT(o.order_id) AS total_orders,
    COUNT(CASE WHEN o.discount_amount > 0 THEN 1 END) AS discounted_orders,
    COUNT(CASE WHEN o.discount_amount = 0 THEN 1 END) AS full_price_orders,
    ROUND(COUNT(CASE WHEN o.discount_amount > 0 THEN 1 END)
        / COUNT(o.order_id) * 100, 2) AS discount_rate_pct,
    ROUND(SUM(o.discount_amount), 2) AS total_discounts_given,
    ROUND(AVG(CASE WHEN o.discount_amount > 0
        THEN o.discount_amount END), 2) AS avg_discount_when_applied,
    ROUND(SUM(o.gross_revenue), 2) AS total_gross_revenue,
    ROUND(SUM(o.net_revenue), 2) AS total_net_revenue,
    ROUND(SUM(o.discount_amount) / SUM(o.gross_revenue) * 100, 2) AS discount_pct_of_revenue,
    ROUND(AVG(o.net_revenue), 2) AS avg_order_value
FROM orders o
JOIN brands b ON o.brand_id = b.brand_id
GROUP BY b.brand_name;

-- Query the view
SELECT * FROM v_discount_analysis
ORDER BY discount_rate_pct DESC;
