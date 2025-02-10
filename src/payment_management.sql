-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Payment Management Queries

-- 1. Record a payment for a membership
-- TODO: Write a query to record a payment for a membership
-- INSERT INTO payments(amount, payment_date, payment_method, payment_type)
-- VALUES(50.00, '2025-01-30 15:58:22', 'Credit Card', 'Monthly membership fee');

-- 2. Calculate total revenue from membership fees for each month of the last year
-- TODO: Write a query to calculate total revenue from membership fees for each month of the last year

SELECT (CASE 
            WHEN strftime('%m', payment_date) = '01' AND strftime('%Y', payment_date) = strftime('%Y', 'now', '-1 year')
            THEN 'JAN'            
            WHEN strftime('%m', payment_date) = '02' AND strftime('%Y', payment_date) = strftime('%Y', 'now', '-1 year')
            THEN 'FEB'
            WHEN strftime('%m', payment_date) = '03' AND strftime('%Y', payment_date) = strftime('%Y', 'now', '-1 year')
            THEN 'MAR'
            WHEN strftime('%m', payment_date) = '04' AND strftime('%Y', payment_date) = strftime('%Y', 'now', '-1 year')
            THEN 'APR'
            WHEN strftime('%m', payment_date) = '04' AND strftime('%Y', payment_date) = strftime('%Y', 'now', '-1 year')
            THEN 'MAY'
            WHEN strftime('%m', payment_date) = '05' AND strftime('%Y', payment_date) = strftime('%Y', 'now', '-1 year')
            THEN 'JUN'
            WHEN strftime('%m', payment_date) = '07' AND strftime('%Y', payment_date) = strftime('%Y', 'now', '-1 year')
            THEN 'JUL   '
            WHEN strftime('%m', payment_date) = '08' AND strftime('%Y', payment_date) = strftime('%Y', 'now', '-1 year')
            THEN 'AUG'
            WHEN strftime('%m', payment_date) = '09' AND strftime('%Y', payment_date) = strftime('%Y', 'now', '-1 year')
            THEN 'SEP'
            WHEN strftime('%m', payment_date) = '10' AND strftime('%Y', payment_date) = strftime('%Y', 'now', '-1 year')
            THEN 'OCT'
            WHEN strftime('%m', payment_date) = '11' AND strftime('%Y', payment_date) = strftime('%Y', 'now', '-1 year')
            THEN 'NOV'
            WHEN strftime('%m', payment_date) = '12' AND strftime('%Y', payment_date) = strftime('%Y', 'now', '-1 year')
            THEN 'DEC'

            ELSE 0
            END) AS months, SUM(amount) AS total_revenue
FROM payments
WHERE payment_date <= strftime('%Y-01-01')
GROUP BY months;


-- 3. Find all day pass purchases
-- TODO: Write a query to find all day pass purchases
-- SELECT payment_id, amount, payment_date, payment_method
-- FROM payments
-- WHERE payment_type = 'Day pass';