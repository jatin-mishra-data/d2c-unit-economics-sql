-- ============================================
-- D2C Unit Economics SQL Project
-- File: 18_discount_customer_behaviour.sql
-- Description: Do discounted customers repeat more?
-- ============================================

USE d2c_unit_economics;

SELECT
    b.brand_name,
    CASE WHEN first_order.discount_amount > 0
        THEN 'First Order Discounted'
        ELSE 'First Order Full Price'
    END AS customer_type,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN repeat_orders.order_id IS NOT NULL
        THEN c.customer_id END) AS repeat_customers,
    ROUND(COUNT(DISTINCT CASE WHEN repeat_orders.order_id IS NOT NULL
        THEN c.customer_id END)
        / COUNT(DISTINCT c.customer_id) * 100, 2) AS repeat_rate_pct,
    ROUND(AVG(first_order.net_revenue), 2) AS avg_first_order_value
FROM customers c
JOIN brands b ON c.brand_id = b.brand_id
JOIN orders first_order
    ON c.customer_id = first_order.customer_id
    AND first_order.order_number = 1
LEFT JOIN orders repeat_orders
    ON c.customer_id = repeat_orders.customer_id
    AND repeat_orders.order_number = 2
GROUP BY b.brand_name,
    CASE WHEN first_order.discount_amount > 0
        THEN 'First Order Discounted'
        ELSE 'First Order Full Price'
    END
ORDER BY b.brand_name, customer_type;
