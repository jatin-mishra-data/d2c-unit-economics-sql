-- ============================================
-- D2C Unit Economics SQL Project
-- File: 22_returns_by_brand.sql
-- Description: Returns cost breakdown by brand
-- ============================================

USE d2c_unit_economics;

SELECT
    b.brand_name,
    b.category,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.net_revenue), 2) AS total_net_revenue,
    ROUND(SUM(pc.avg_returns_cost), 2) AS total_returns_cost,
    ROUND(AVG(pc.avg_returns_cost), 2) AS avg_returns_per_order,
    ROUND(SUM(pc.avg_returns_cost) / SUM(o.net_revenue) * 100, 2) AS returns_pct_of_revenue,
    ROUND(AVG(pc.avg_cogs_per_order), 2) AS avg_cogs,
    ROUND(AVG(pc.avg_shipping_per_order), 2) AS avg_shipping,
    ROUND(AVG(pc.avg_returns_cost) / AVG(pc.avg_cogs_per_order) * 100, 2) AS returns_pct_of_cogs
FROM orders o
JOIN brands b ON o.brand_id = b.brand_id
JOIN product_costs pc
    ON o.brand_id = pc.brand_id
    AND DATE_FORMAT(o.order_date, '%Y-%m') = DATE_FORMAT(pc.cost_month, '%Y-%m')
GROUP BY b.brand_name, b.category
ORDER BY returns_pct_of_revenue DESC;
