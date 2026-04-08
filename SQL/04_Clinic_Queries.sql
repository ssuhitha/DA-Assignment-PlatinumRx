-- =============================================
-- Clinic Management System - Query Solutions
-- =============================================

-- Q1: Revenue from each sales channel for a given year
-- Replace 2021 with any year as needed
SELECT
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel
ORDER BY total_revenue DESC;

-- -----------------------------------------------

-- Q2: Top 10 most valuable customers for a given year
SELECT
    cs.uid,
    c.name,
    SUM(cs.amount) AS total_spent
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY cs.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;

-- -----------------------------------------------

-- Q3: Month-wise revenue, expense, profit, and status for a given year
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(datetime, '%Y-%m') AS month,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY month
),
monthly_expenses AS (
    SELECT
        DATE_FORMAT(datetime, '%Y-%m') AS month,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY month
)
SELECT
    r.month,
    r.total_revenue,
    COALESCE(e.total_expense, 0) AS total_expense,
    (r.total_revenue - COALESCE(e.total_expense, 0)) AS profit,
    CASE
        WHEN (r.total_revenue - COALESCE(e.total_expense, 0)) > 0 THEN 'Profitable'
        ELSE 'Not-Profitable'
    END AS status
FROM monthly_revenue r
LEFT JOIN monthly_expenses e ON r.month = e.month
ORDER BY r.month;

-- -----------------------------------------------

-- Q4: Most profitable clinic for each city for a given month
-- Replace '2021-12' with target month
WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.city,
        COALESCE(SUM(cs.amount), 0) - COALESCE(SUM(ex.amount), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs ON cl.cid = cs.cid AND DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-12'
    LEFT JOIN expenses ex     ON cl.cid = ex.cid AND DATE_FORMAT(ex.datetime, '%Y-%m') = '2021-12'
    GROUP BY cl.cid, cl.clinic_name, cl.city
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
    FROM clinic_profit
)
SELECT city, cid, clinic_name, profit AS highest_profit
FROM ranked
WHERE rnk = 1
ORDER BY city;

-- -----------------------------------------------

-- Q5: Second least profitable clinic for each state for a given month
WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.state,
        COALESCE(SUM(cs.amount), 0) - COALESCE(SUM(ex.amount), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs ON cl.cid = cs.cid AND DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-12'
    LEFT JOIN expenses ex     ON cl.cid = ex.cid AND DATE_FORMAT(ex.datetime, '%Y-%m') = '2021-12'
    GROUP BY cl.cid, cl.clinic_name, cl.state
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM clinic_profit
)
SELECT state, cid, clinic_name, profit AS second_least_profit
FROM ranked
WHERE rnk = 2
ORDER BY state;
