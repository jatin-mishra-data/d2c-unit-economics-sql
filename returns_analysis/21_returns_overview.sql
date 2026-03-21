-- ============================================
-- D2C Unit Economics SQL Project
-- File: 21_returns_overview.sql
-- Description: Overall returns cost across all brands
-- ============================================

USE d2c_unit_economics;

SELECT
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.net_revenue), 2) AS total_net_revenue,
    ROUND(SUM(pc.avg_returns_cost), 2) AS total_returns_cost,
    ROUND(AVG(pc.avg_returns_cost), 2) AS avg_returns_cost_per_order,
    ROUND(SUM(pc.avg_returns_cost) / SUM(o.net_revenue) * 100, 2) AS returns_pct_of_revenue,
    ROUND(SUM(o.net_revenue) - SUM(pc.avg_returns_cost), 2) AS revenue_after_returns,
    ROUND(SUM(pc.avg_shipping_per_order), 2) AS total_shipping_cost,
    ROUND(SUM(pc.avg_cogs_per_order), 2) AS total_cogs,
    ROUND(
        (SUM(o.net_revenue) - SUM(pc.avg_cogs_per_order)
        - SUM(pc.avg_shipping_per_order)
        - SUM(pc.avg_payment_gateway)
        - SUM(pc.avg_returns_cost))
        / SUM(o.net_revenue) * 100, 2
    ) AS net_margin_after_all_costs_pct
FROM orders o
JOIN product_costs pc
    ON o.brand_id = pc.brand_id
    AND DATE_FORMAT(o.order_date, '%Y-%m') = DATE_FORMAT(pc.cost_month, '%Y-%m');
