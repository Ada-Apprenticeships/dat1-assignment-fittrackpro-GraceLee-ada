-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors
SELECT c.class_id, c.name AS class_name, s.first_name||' '||s.last_name AS instructor_name
FROM classes c
LEFT OUTER JOIN class_schedule cs, staff s ON s.staff_id = cs.staff_id AND cs.class_id = c.class_id;

-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date
SELECT c.class_id, c.name, cs.start_time, cs.end_time, c.capacity AS available_spots
FROM classes c 
INNER JOIN class_schedule cs ON cs.class_id = c.class_id AND date(cs.start_time) = '2025-02-01';


-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class
-- INSERT INTO class_attendance(attendance_status, member_id, schedule_id)
-- VALUES('Registered', 11, 7);

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration
-- DELETE FROM class_attendance
-- WHERE member_id = 2 AND schedule_id = 7;

-- 5. List top 3 most popular classes
-- TODO: Write a query to list top 3 most popular classes
SELECT c.class_id, c.name AS class_name, ca.class_attendance_id, COUNT(ca.schedule_id) AS registration_count
FROM class_attendance ca
INNER JOIN class_schedule cs ON cs.schedule_id = ca.schedule_id
INNER JOIN classes c ON c.class_id = cs.class_id
WHERE ca.attendance_status = 'Registered'
GROUP BY ca.schedule_id
ORDER BY COUNT(*) DESC LIMIT 3;


-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member
SELECT AVG(class_count) AS avg_classes
FROM (SELECT m.member_id, COUNT(ca.member_id) AS class_count
      FROM members m
      LEFT JOIN class_attendance ca ON m.member_id = ca.member_id
      GROUP BY m.member_id);