-- ============================================
-- D2C Unit Economics SQL Project
-- File: 26_returns_summary_view.sql
-- Description: Master returns analysis view
-- ============================================

USE d2c_unit_economics;

CREATE OR REPLACE VIEW v_returns_analysis AS
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
    ROUND(AVG(o.net_revenue)
        - AVG(pc.avg_cogs_per_order)
        - AVG(pc.avg_shipping_per_order)
        - AVG(pc.avg_payment_gateway)
        - AVG(pc.avg_returns_cost), 2) AS net_margin_per_order,
    ROUND((AVG(o.net_revenue)
        - AVG(pc.avg_cogs_per_order)
        - AVG(pc.avg_shipping_per_order)
        - AVG(pc.avg_payment_gateway)
        - AVG(pc.avg_returns_cost))
        / AVG(o.net_revenue) * 100, 2) AS net_margin_pct
FROM orders o
JOIN brands b ON o.brand_id = b.brand_id
JOIN product_costs pc
    ON o.brand_id = pc.brand_id
    AND DATE_FORMAT(o.order_date, '%Y-%m') = DATE_FORMAT(pc.cost_month, '%Y-%m')
GROUP BY b.brand_name, b.category;

-- Query the view
SELECT * FROM v_returns_analysis
ORDER BY returns_pct_of_revenue DESC;
