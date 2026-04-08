-- =============================================
-- Hotel Management System - Query Solutions
-- =============================================

-- Q1: For every user, get user_id and last booked room_no
SELECT
    u.user_id,
    b.room_no AS last_booked_room
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.booking_date = (
    SELECT MAX(b2.booking_date)
    FROM bookings b2
    WHERE b2.user_id = u.user_id
);

-- -----------------------------------------------

-- Q2: booking_id and total billing amount for bookings in November 2021
SELECT
    bc.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE DATE_FORMAT(bc.bill_date, '%Y-%m') = '2021-11'
GROUP BY bc.booking_id;

-- -----------------------------------------------

-- Q3: bill_id and bill amount for October 2021 bills having amount > 1000
SELECT
    bill_id,
    SUM(item_quantity * item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE DATE_FORMAT(bc.bill_date, '%Y-%m') = '2021-10'
GROUP BY bc.bill_id
HAVING SUM(item_quantity * item_rate) > 1000;

-- -----------------------------------------------

-- Q4: Most ordered and least ordered item of each month in 2021
WITH monthly_item_totals AS (
    SELECT
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS month,
        i.item_name,
        SUM(bc.item_quantity) AS total_ordered,
        RANK() OVER (PARTITION BY DATE_FORMAT(bc.bill_date, '%Y-%m') ORDER BY SUM(bc.item_quantity) DESC) AS rnk_desc,
        RANK() OVER (PARTITION BY DATE_FORMAT(bc.bill_date, '%Y-%m') ORDER BY SUM(bc.item_quantity) ASC)  AS rnk_asc
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY month, i.item_name
)
SELECT
    month,
    MAX(CASE WHEN rnk_desc = 1 THEN item_name END) AS most_ordered_item,
    MAX(CASE WHEN rnk_asc  = 1 THEN item_name END) AS least_ordered_item
FROM monthly_item_totals
GROUP BY month
ORDER BY month;

-- -----------------------------------------------

-- Q5: Customers with the second highest bill value of each month in 2021
WITH bill_totals AS (
    SELECT
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS month,
        b.user_id,
        bc.bill_id,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    JOIN bookings b ON bc.booking_id = b.booking_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY month, b.user_id, bc.bill_id
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY month ORDER BY bill_amount DESC) AS rnk
    FROM bill_totals
)
SELECT
    r.month,
    r.user_id,
    u.name,
    r.bill_id,
    r.bill_amount AS second_highest_bill
FROM ranked r
JOIN users u ON r.user_id = u.user_id
WHERE r.rnk = 2
ORDER BY r.month;
