-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships
SELECT m.member_id, m.first_name, m.last_name, ms.type AS membership_type, m.join_date
FROM memberships ms
LEFT JOIN members m ON m.member_id = ms.member_id
WHERE ms.status = 'Active';

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type
-- SELECT type AS membership_type, (SELECT (JULIANDAY(check_out_time)-JULIANDAY(check_in_time))*1440
--                                  FROM attendance)
-- FROM memberships
-- GROUP BY type

-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year
SELECT m.member_id, m.first_name, m.last_name, m.email, ms.end_date
FROM members m 
INNER JOIN memberships ms ON m.member_id = ms.member_id AND JULIANDAY(ms.end_date) < JULIANDAY(date('now', '+365 day'))