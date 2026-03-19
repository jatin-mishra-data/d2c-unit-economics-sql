-- ============================================
-- D2C Unit Economics SQL Project
-- File: 08_summary_views.sql
-- Description: Master Summary View
-- ============================================

USE d2c_unit_economics;

CREATE VIEW v_brand_unit_economics AS
SELECT
    b.brand_name,
    b.category,
    b.channel,
    ROUND(SUM(o.net_revenue), 2) AS total_revenue,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.net_revenue), 2) AS aov,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    ROUND(SUM(ms.amount_spent) / NULLIF(SUM(ms.new_customers_acquired), 0), 2) AS blended_cac,
    ROUND(
        COUNT(DISTINCT CASE WHEN o.order_number >= 2 THEN o.customer_id END)
        / NULLIF(COUNT(DISTINCT c.customer_id), 0) * 100, 2
    ) AS repeat_rate_pct
FROM brands b
LEFT JOIN customers c ON b.brand_id = c.brand_id
LEFT JOIN orders o ON b.brand_id = o.brand_id
LEFT JOIN marketing_spend ms ON b.brand_id = ms.brand_id
GROUP BY b.brand_id, b.brand_name, b.category, b.channel;

-- Query the summary view
SELECT * FROM v_brand_unit_economics;
