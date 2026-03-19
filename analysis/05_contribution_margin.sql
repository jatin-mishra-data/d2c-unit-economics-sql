-- ============================================
-- D2C Unit Economics SQL Project
-- File: 05_contribution_margin.sql
-- Description: Contribution Margin Analysis
-- ============================================

USE d2c_unit_economics;

SELECT
    b.brand_name,
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.net_revenue), 2) AS avg_net_revenue,
    ROUND(AVG(pc.avg_cogs_per_order), 2) AS avg_cogs,
    ROUND(AVG(pc.avg_shipping_per_order), 2) AS avg_shipping,
    ROUND(AVG(pc.avg_payment_gateway), 2) AS avg_pg_fee,
    ROUND(AVG(pc.avg_returns_cost), 2) AS avg_returns,
    ROUND(AVG(o.net_revenue)
        - AVG(pc.avg_cogs_per_order)
        - AVG(pc.avg_shipping_per_order)
        - AVG(pc.avg_payment_gateway)
        - AVG(pc.avg_returns_cost), 2) AS contribution_margin,
    ROUND(
        (AVG(o.net_revenue)
        - AVG(pc.avg_cogs_per_order)
        - AVG(pc.avg_shipping_per_order)
        - AVG(pc.avg_payment_gateway)
        - AVG(pc.avg_returns_cost))
        / AVG(o.net_revenue) * 100, 2
    ) AS cm_pct
FROM orders o
JOIN brands b ON o.brand_id = b.brand_id
JOIN product_costs pc
    ON o.brand_id = pc.brand_id
    AND DATE_FORMAT(o.order_date, '%Y-%m') = DATE_FORMAT(pc.cost_month, '%Y-%m')
GROUP BY b.brand_name, DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY b.brand_name, month;
