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
-- TODO: Write a query to calculate total revenue from membership fees for each month of the current year
-- SELECT strftime('%m', payment_date) AS months, SUM(amount) AS total_revenue
-- FROM payments
-- GROUP BY months
-- ORDER BY months ASC;

-- SELECT payment_date BETWEEN date(strftime('%Y-01-01', 'now')) AND date('now') FROM payments;
-- 3. Find all day pass purchases
-- TODO: Write a query to find all day pass purchases
SELECT payment_id, amount, payment_date, payment_method
FROM payments
WHERE payment_type = 'Day pass';