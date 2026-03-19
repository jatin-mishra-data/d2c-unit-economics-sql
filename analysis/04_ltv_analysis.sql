-- ============================================
-- D2C Unit Economics SQL Project
-- File: 04_ltv_analysis.sql
-- Description: LTV and LTV:CAC Ratio
-- ============================================

USE d2c_unit_economics;

-- Average LTV by brand
SELECT
    b.brand_name,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    ROUND(AVG(customer_revenue.total_rev), 2) AS avg_ltv,
    ROUND(AVG(customer_revenue.order_count), 2) AS avg_orders_per_customer
FROM customers c
JOIN brands b ON c.brand_id = b.brand_id
JOIN (
    SELECT customer_id,
           SUM(net_revenue) AS total_rev,
           COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) AS customer_revenue ON c.customer_id = customer_revenue.customer_id
GROUP BY b.brand_name
ORDER BY avg_ltv DESC;

-- LTV:CAC Ratio
WITH brand_ltv AS (
    SELECT c.brand_id,
           ROUND(AVG(cr.total_rev), 2) AS avg_ltv
    FROM customers c
    JOIN (
        SELECT customer_id, SUM(net_revenue) AS total_rev
        FROM orders GROUP BY customer_id
    ) cr ON c.customer_id = cr.customer_id
    GROUP BY c.brand_id
),
brand_cac AS (
    SELECT brand_id,
           ROUND(SUM(amount_spent) / SUM(new_customers_acquired), 2) AS blended_cac
    FROM marketing_spend
    GROUP BY brand_id
)
SELECT
    b.brand_name,
    bl.avg_ltv,
    bc.blended_cac,
    ROUND(bl.avg_ltv / bc.blended_cac, 2) AS ltv_cac_ratio,
    CASE
        WHEN bl.avg_ltv / bc.blended_cac >= 3 THEN 'Healthy'
        WHEN bl.avg_ltv / bc.blended_cac >= 1.5 THEN 'Borderline'
        ELSE 'Burning Cash'
    END AS health_status
FROM brands b
JOIN brand_ltv bl ON b.brand_id = bl.brand_id
JOIN brand_cac bc ON b.brand_id = bc.brand_id
ORDER BY ltv_cac_ratio DESC;
