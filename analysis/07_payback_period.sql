-- ============================================
-- D2C Unit Economics SQL Project
-- File: 07_payback_period.sql
-- Description: CAC Payback Period
-- ============================================

USE d2c_unit_economics;

WITH brand_cac AS (
    SELECT brand_id,
           ROUND(SUM(amount_spent) / SUM(new_customers_acquired), 2) AS blended_cac
    FROM marketing_spend
    GROUP BY brand_id
),
monthly_cm AS (
    SELECT
        o.brand_id,
        ROUND(
            (AVG(o.net_revenue)
            - AVG(pc.avg_cogs_per_order)
            - AVG(pc.avg_shipping_per_order)
            - AVG(pc.avg_payment_gateway)
            - AVG(pc.avg_returns_cost)), 2
        ) AS avg_cm_per_order,
        ROUND(COUNT(o.order_id) / COUNT(DISTINCT o.customer_id) / 3, 2) AS orders_per_month
    FROM orders o
    JOIN product_costs pc
        ON o.brand_id = pc.brand_id
        AND DATE_FORMAT(o.order_date, '%Y-%m') = DATE_FORMAT(pc.cost_month, '%Y-%m')
    GROUP BY o.brand_id
)
SELECT
    b.brand_name,
    bc.blended_cac,
    ROUND(mcm.avg_cm_per_order * mcm.orders_per_month, 2) AS monthly_cm_per_customer,
    ROUND(bc.blended_cac / (mcm.avg_cm_per_order * mcm.orders_per_month), 1) AS payback_months,
    CASE
        WHEN bc.blended_cac / (mcm.avg_cm_per_order * mcm.orders_per_month) <= 6 THEN 'Under 6 months'
        WHEN bc.blended_cac / (mcm.avg_cm_per_order * mcm.orders_per_month) <= 12 THEN '6-12 months'
        ELSE 'Over 12 months'
    END AS payback_status
FROM brands b
JOIN brand_cac bc ON b.brand_id = bc.brand_id
JOIN monthly_cm mcm ON b.brand_id = mcm.brand_id
ORDER BY payback_months;
