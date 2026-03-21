-- ============================================
-- D2C Unit Economics SQL Project
-- File: 24_returns_vs_discounts.sql
-- Description: Do discounted orders have higher return costs?
-- ============================================

USE d2c_unit_economics;

SELECT
    b.brand_name,
    CASE WHEN o.discount_amount > 0
        THEN 'Discounted Order'
        ELSE 'Full Price Order'
    END AS order_type,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.net_revenue), 2) AS avg_net_revenue,
    ROUND(AVG(o.discount_amount), 2) AS avg_discount,
    ROUND(AVG(pc.avg_returns_cost), 2) AS avg_returns_cost,
    ROUND(AVG(pc.avg_returns_cost) / AVG(o.net_revenue) * 100, 2) AS returns_pct,
    ROUND(AVG(o.net_revenue)
        - AVG(pc.avg_cogs_per_order)
        - AVG(pc.avg_shipping_per_order)
        - AVG(pc.avg_payment_gateway)
        - AVG(pc.avg_returns_cost), 2) AS net_margin_per_order
FROM orders o
JOIN brands b ON o.brand_id = b.brand_id
JOIN product_costs pc
    ON o.brand_id = pc.brand_id
    AND DATE_FORMAT(o.order_date, '%Y-%m') = DATE_FORMAT(pc.cost_month, '%Y-%m')
GROUP BY b.brand_name,
    CASE WHEN o.discount_amount > 0
        THEN 'Discounted Order'
        ELSE 'Full Price Order'
    END
ORDER BY b.brand_name, order_type;
