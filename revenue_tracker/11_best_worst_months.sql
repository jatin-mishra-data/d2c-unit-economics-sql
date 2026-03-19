-- ============================================
-- D2C Unit Economics SQL Project
-- File: 11_best_worst_months.sql
-- Description: Best and worst month per brand
-- ============================================

USE d2c_unit_economics;

SELECT
    b.brand_name,
    MAX(DATE_FORMAT(o.order_date, '%Y-%m')) AS latest_month,
    MIN(DATE_FORMAT(o.order_date, '%Y-%m')) AS earliest_month,
    ROUND(MAX(monthly_rev.monthly_net), 2) AS best_month_revenue,
    ROUND(MIN(monthly_rev.monthly_net), 2) AS worst_month_revenue
FROM brands b
JOIN orders o ON b.brand_id = o.brand_id
JOIN (
    SELECT
        brand_id,
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(net_revenue) AS monthly_net
    FROM orders
    GROUP BY brand_id, DATE_FORMAT(order_date, '%Y-%m')
) AS monthly_rev ON b.brand_id = monthly_rev.brand_id
GROUP BY b.brand_name
ORDER BY best_month_revenue DESC;
