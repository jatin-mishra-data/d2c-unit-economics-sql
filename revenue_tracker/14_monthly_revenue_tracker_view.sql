-- ============================================
-- D2C Unit Economics SQL Project
-- File: 14_monthly_revenue_tracker_view.sql
-- Description: Master monthly revenue tracker view
-- ============================================

USE d2c_unit_economics;

CREATE OR REPLACE VIEW v_monthly_revenue_tracker AS
SELECT
    b.brand_name,
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.gross_revenue), 2) AS gross_revenue,
    ROUND(SUM(o.discount_amount), 2) AS total_discounts,
    ROUND(SUM(o.net_revenue), 2) AS net_revenue,
    ROUND(AVG(o.net_revenue), 2) AS avg_order_value,
    ROUND(SUM(o.discount_amount) / SUM(o.gross_revenue) * 100, 2) AS discount_pct
FROM orders o
JOIN brands b ON o.brand_id = b.brand_id
GROUP BY b.brand_name, DATE_FORMAT(o.order_date, '%Y-%m');

-- Query the view
SELECT * FROM v_monthly_revenue_tracker
ORDER BY brand_name, month;
