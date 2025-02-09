-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit
-- INSERT INTO attendance(check_in_time, member_id, location_id) VALUES
-- (datetime('now'), 7, 1);

-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history
SELECT date(check_in_time) AS visit_date, check_in_time, check_out_time
FROM attendance
WHERE member_id = 5;

-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits
WITH dayList AS (SELECT strftime('%u',check_in_time) AS day_of_week, COUNT(strftime('%u',check_in_time)) AS visit_count
                 FROM attendance
                 GROUP BY strftime('%u',check_in_time))
SELECT day_of_week, visit_count
FROM dayList
WHERE visit_count = (SELECT MAX(visit_count) FROM dayList);

-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location
