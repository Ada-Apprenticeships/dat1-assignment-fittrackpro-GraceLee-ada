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

-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member