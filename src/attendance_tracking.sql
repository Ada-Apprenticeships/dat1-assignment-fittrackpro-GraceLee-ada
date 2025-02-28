-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit
INSERT INTO attendance(check_in_time, member_id, location_id) VALUES
(DATETIME('now'), 7, 1);

-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history
SELECT DATE(check_in_time) AS visit_date, 
       check_in_time, 
       check_out_time
FROM attendance
WHERE member_id = 5;

-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits
-- NOTES: Individual days for readability
WITH dayList AS (
    SELECT 
        STRFTIME('%u', check_in_time) AS day_of_week, 
        COUNT(*) AS visit_count
    FROM attendance
    GROUP BY STRFTIME('%u', check_in_time)
)
SELECT 
    CASE day_of_week
        WHEN '1' THEN 'MONDAY'
        WHEN '2' THEN 'TUESDAY'
        WHEN '3' THEN 'WEDNESDAY'
        WHEN '4' THEN 'THURSDAY'
        WHEN '5' THEN 'FRIDAY'
        WHEN '6' THEN 'SATURDAY'
        WHEN '7' THEN 'SUNDAY'
    END AS day_of_week,
    visit_count
FROM dayList
WHERE visit_count = (SELECT MAX(visit_count) FROM dayList);

-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location
SELECT location_name, 
       AVG(day_count) AS avg_daily_attendance
FROM (SELECT l.name AS location_name, 
             DATE(a.check_in_time) AS day, 
             COUNT(DATE(a.check_in_time)) AS day_count
      FROM attendance a
      INNER JOIN locations l ON l.location_id = a.location_id
      GROUP BY DATE(a.check_in_time)
      ORDER BY location_name)
GROUP BY location_name;