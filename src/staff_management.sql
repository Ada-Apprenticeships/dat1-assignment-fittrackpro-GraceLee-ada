-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role
SELECT staff_id, first_name, last_name, position AS role
FROM staff
ORDER BY position;

-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days
SELECT s.staff_id AS trainer_id, s.first_name||' '||s.last_name AS trainer_name, COUNT(date(cs.start_time)) AS session_count
FROM staff s
LEFT JOIN class_schedule cs ON s.staff_id = cs.staff_id AND JULIANDAY(cs.start_time) < JULIANDAY(date('now', '+30 day'))
GROUP BY cs.staff_id
HAVING COUNT(date(cs.start_time)) >= 1;
