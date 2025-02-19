-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Payment Management Queries

-- 1. Record a payment for a membership
-- TODO: Write a query to record a payment for a membership
INSERT INTO payments(amount, payment_date, payment_method, payment_type, member_id)
VALUES(50.00, DATETIME('now'), 'Credit Card', 'Monthly membership fee', 11);

-- 2. Calculate total revenue from membership fees for each month of the last year
-- TODO: Write a query to calculate total revenue from membership fees for each month of the last year
-- NOTES: Individual months for readability, shows months from last year (2024)
SELECT
    SUM(CASE WHEN month = '01' THEN amount ELSE 0 END) AS "JAN",
    SUM(CASE WHEN month = '02' THEN amount ELSE 0 END) AS "FEB",
    SUM(CASE WHEN month = '03' THEN amount ELSE 0 END) AS "MAR",
    SUM(CASE WHEN month = '04' THEN amount ELSE 0 END) AS "APR",
    SUM(CASE WHEN month = '05' THEN amount ELSE 0 END) AS "MAY",
    SUM(CASE WHEN month = '06' THEN amount ELSE 0 END) AS "JUN",
    SUM(CASE WHEN month = '07' THEN amount ELSE 0 END) AS "JUL",
    SUM(CASE WHEN month = '08' THEN amount ELSE 0 END) AS "AUG",
    SUM(CASE WHEN month = '09' THEN amount ELSE 0 END) AS "SEP",
    SUM(CASE WHEN month = '10' THEN amount ELSE 0 END) AS "OCT",
    SUM(CASE WHEN month = '11' THEN amount ELSE 0 END) AS "NOV",
    SUM(CASE WHEN month = '12' THEN amount ELSE 0 END) AS "DEC"
FROM (
    SELECT 
        amount, 
        STRFTIME('%m', payment_date) AS month,
        STRFTIME('%Y', payment_date) AS year
    FROM payments
)
WHERE year = STRFTIME('%Y', 'now', '-1 year');


-- 3. Find all day pass purchases
-- TODO: Write a query to find all day pass purchases
SELECT payment_id, 
       amount, 
       payment_date, 
       payment_method
FROM payments
WHERE payment_type = 'Day pass';