-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Payment Management Queries

-- 1. Record a payment for a membership
-- TODO: Write a query to record a payment for a membership
-- INSERT INTO payments(amount, payment_date, payment_method, payment_type)
-- VALUES(50.00, DATETIME('now'), 'Credit Card', 'Monthly membership fee');

-- 2. Calculate total revenue from membership fees for each month of the last year
-- TODO: Write a query to calculate total revenue from membership fees for each month of the last year
--Notes: Individual months for readability
SELECT
    SUM(CASE WHEN STRFTIME('%m', payment_date)= '01' AND STRFTIME('%Y', payment_date) = '2024' THEN amount ELSE 0 END) AS "JAN",
    SUM(CASE WHEN STRFTIME('%m', payment_date)= '02' AND STRFTIME('%Y', payment_date) = '2024' THEN amount ELSE 0 END) AS "FEB",
    SUM(CASE WHEN STRFTIME('%m', payment_date)= '03' AND STRFTIME('%Y', payment_date) = '2024' THEN amount ELSE 0 END) AS "MAR",
    SUM(CASE WHEN STRFTIME('%m', payment_date)= '04' AND STRFTIME('%Y', payment_date) = '2024' THEN amount ELSE 0 END) AS "APR",
    SUM(CASE WHEN STRFTIME('%m', payment_date)= '05' AND STRFTIME('%Y', payment_date) = '2024' THEN amount ELSE 0 END) AS "MAY",
    SUM(CASE WHEN STRFTIME('%m', payment_date)= '06' AND STRFTIME('%Y', payment_date) = '2024' THEN amount ELSE 0 END) AS "JUN",
    SUM(CASE WHEN STRFTIME('%m', payment_date)= '07' AND STRFTIME('%Y', payment_date) = '2024' THEN amount ELSE 0 END) AS "JUL",
    SUM(CASE WHEN STRFTIME('%m', payment_date)= '08' AND STRFTIME('%Y', payment_date) = '2024' THEN amount ELSE 0 END) AS "AUG",
    SUM(CASE WHEN STRFTIME('%m', payment_date)= '09' AND STRFTIME('%Y', payment_date) = '2024' THEN amount ELSE 0 END) AS "SEP",
    SUM(CASE WHEN STRFTIME('%m', payment_date)= '10' AND STRFTIME('%Y', payment_date) = '2024' THEN amount ELSE 0 END) AS "OCT",
    SUM(CASE WHEN STRFTIME('%m', payment_date)= '11' AND STRFTIME('%Y', payment_date) = '2024' THEN amount ELSE 0 END) AS "NOV",
    SUM(CASE WHEN STRFTIME('%m', payment_date)= '12' AND STRFTIME('%Y', payment_date) = '2024' THEN amount ELSE 0 END) AS "DEC"        
from payments;


-- 3. Find all day pass purchases
-- TODO: Write a query to find all day pass purchases
SELECT payment_id, amount, payment_date, payment_method
FROM payments
WHERE payment_type = 'Day pass';