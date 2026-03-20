# D2C Unit Economics & Revenue Tracker — SQL Project

## Overview
A MySQL-based SQL portfolio project analyzing unit economics and monthly revenue trends
for 5 Indian D2C brands — Pilgrim, Sleepy Owl, WishCare, Urban Platter, and Carbamide Forte.

Built to demonstrate business-side SQL skills relevant to Founder's Office,
Business Strategy, and Corporate Finance roles.

---

## Database Schema
5 tables: `brands`, `customers`, `orders`, `marketing_spend`, `product_costs`

---

## Project 1 — D2C Unit Economics

| File | Description |
|---|---|
| `schema/01_create_tables.sql` | Create all 5 tables |
| `data/02_insert_sample_data.sql` | Insert sample data (5 brands, 22 orders) |
| `analysis/03_cac_analysis.sql` | CAC by brand and channel |
| `analysis/04_ltv_analysis.sql` | LTV and LTV:CAC ratio |
| `analysis/05_contribution_margin.sql` | Contribution margin % by month |
| `analysis/06_cohort_repeat_rate.sql` | Repeat rate and cohort retention |
| `analysis/07_payback_period.sql` | CAC payback period |
| `views/08_summary_views.sql` | Master summary view |

### Key Findings
- **Pilgrim** has the best LTV:CAC ratio (2.52) among all 5 brands
- **Urban Platter** spends ₹1,750 CAC but has 0% repeat rate — classic omnichannel problem
- **Sleepy Owl** leads on repeat rate (66.7%) despite mid-range LTV:CAC
- All 5 brands recover CAC within 6 months — Urban Platter closest to the edge at 5.3 months

---

## Project 2 — Monthly Revenue Tracker

| File | Description |
|---|---|
| `revenue_tracker/09_monthly_revenue_summary.sql` | Total revenue per month across all brands |
| `revenue_tracker/10_brand_monthly_revenue.sql` | Revenue breakdown by brand each month |
| `revenue_tracker/11_best_worst_months.sql` | Best and worst month per brand |
| `revenue_tracker/12_monthly_order_volume.sql` | Order volume with cumulative window function |
| `revenue_tracker/13_avg_order_value_trend.sql` | AOV and discount % trend |
| `revenue_tracker/14_monthly_revenue_tracker_view.sql` | Master revenue tracker view |

### Key Findings
- **January 2025** was the highest revenue month (₹12,437 net) but lowest AOV (₹957)
- **Pilgrim** ran 9.3% discounts in Jan — stopped in Feb and AOV went UP to ₹1,066
- **Sleepy Owl** has highest AOV volatility — best month 3x better than worst month
- Window function used to track cumulative order volume per brand over time

---

## Project 3 — Discount & Promo Analysis

| File | Description |
|---|---|
| `discount_analysis/15_discount_overview.sql` | Overall discount stats across all brands |
| `discount_analysis/16_discount_by_brand.sql` | Which brand discounts the most |
| `discount_analysis/17_discount_vs_revenue.sql` | Discounted vs full price order comparison |
| `discount_analysis/18_discount_customer_behaviour.sql` | Do discounted customers repeat more? |
| `discount_analysis/19_discount_by_channel.sql` | Discount rate by acquisition channel |
| `discount_analysis/20_discount_summary_view.sql` | Master discount analysis view |

### Key Findings
- 40.9% of all orders had a discount — above industry benchmark of 20-25%
- Pilgrim's discounted first-time customers return 100% vs 0% for full price
- Discounted orders have HIGHER gross AOV — customers buy premium with discounts
- Google channel has lowest discount rate (25%) but strong AOV (₹949) — best quality channel
- Urban Platter discounts 50% of orders but still has 0% repeat rate

---

## SQL Concepts Used
- SELECT, WHERE, GROUP BY, ORDER BY, LIMIT
- JOINs (INNER, LEFT)
- Aggregate functions (SUM, AVG, COUNT, MAX, MIN)
- DATE functions (DATE_FORMAT, MONTH, YEAR)
- CTEs (WITH clause)
- CASE WHEN statements
- Subqueries
- Window Functions (SUM OVER, PARTITION BY)
- Views (CREATE VIEW, CREATE OR REPLACE VIEW)
- UNION ALL
- Multiple JOINs in single query
- CREATE OR REPLACE VIEW

---

## Tools
- MySQL 8.0
- MySQL Workbench
- GitHub

---

## Author
**Jatin Mishra**
B.Tech ECE — SRM Chennai | Ex-Bank of America | D2C & Startup Enthusiast
[LinkedIn](https://www.linkedin.com/in/your-linkedin-url)
[GitHub](https://github.com/jatin-mishra-data)
```

---
