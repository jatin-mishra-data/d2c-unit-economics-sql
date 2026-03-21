-- ============================================
-- D2C Unit Economics SQL Project
-- File: 25_returns_monthly_trend.sql
-- Description: Monthly returns cost trend with cumulative total
-- ============================================

USE d2c_unit_economics;

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.net_revenue), 2) AS total_net_revenue,
    ROUND(SUM(pc.avg_returns_cost), 2) AS total_returns_cost,
    ROUND(AVG(pc.avg_returns_cost), 2) AS avg_returns_per_order,
    ROUND(SUM(pc.avg_returns_cost) / SUM(o.net_revenue) * 100, 2) AS returns_pct,
    ROUND(SUM(o.net_revenue) - SUM(pc.avg_returns_cost), 2) AS net_after_returns,
    SUM(SUM(pc.avg_returns_cost)) OVER (
        ORDER BY DATE_FORMAT(o.order_date, '%Y-%m')
    ) AS cumulative_returns_cost
FROM orders o
JOIN product_costs pc
    ON o.brand_id = pc.brand_id
    AND DATE_FORMAT(o.order_date, '%Y-%m') = DATE_FORMAT(pc.cost_month, '%Y-%m')
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;
