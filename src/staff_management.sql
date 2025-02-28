-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role
SELECT staff_id, 
       first_name, 
       last_name, 
       position AS role
FROM staff
ORDER BY position;

-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days

SELECT s.staff_id AS trainer_id, 
       s.first_name||' '||s.last_name AS trainer_name, 
       COUNT(pts.staff_id) AS session_count
FROM staff s
INNER JOIN personal_training_sessions pts ON s.staff_id = pts.staff_id 
                                          AND pts.session_date BETWEEN DATE(JULIANDAY('now')) 
                                                               AND DATE(JULIANDAY('now', '+30 days')) 
                                          AND s.position = 'Trainer'
GROUP BY trainer_id
HAVING session_count >= 1
ORDER BY session_count DESC;