-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- User Management Queries

-- 1. Retrieve all members
-- TODO: Write a query to retrieve all members
SELECT member_id, 
       first_name, 
       last_name, 
       email, 
       join_date
FROM members;

-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information
UPDATE members
SET phone_number = '555-9876',
    email = 'emily.jones.updated@email.com'
WHERE member_id = 5;

-- 3. Count total number of members
-- TODO: Write a query to count the total number of members
SELECT COUNT(*) AS member_count
FROM members;

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations
-- NOTES: interpreted as resulting in multiple members if all have the highest registration amount
WITH countList AS (SELECT m.member_id, 
                          COUNT(ca.member_id) AS registration_count
                   FROM members m 
                   INNER JOIN class_attendance ca ON ca.member_id = m.member_id 
                                                  AND ca.attendance_status = 'Registered'
                   GROUP BY ca.member_id)
SELECT m.member_id, 
       m.first_name, 
       m.last_name, 
       cl.registration_count
FROM members m 
INNER JOIN countList cl ON m.member_id = cl.member_id 
                        AND cl.registration_count = (SELECT MAX(registration_count) 
                                                     FROM countList);


-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations
-- NOTES: interpreted as resulting in multiple members if all have the lowest registration amount
WITH countList AS (SELECT m.member_id, 
                          COUNT(ca.member_id) AS registration_count
                   FROM members m 
                   INNER JOIN class_attendance ca ON ca.member_id = m.member_id 
                                                  AND ca.attendance_status = 'Registered'
                   GROUP BY ca.member_id)
SELECT m.member_id, 
       m.first_name, 
       m.last_name, 
       cl.registration_count
FROM members m 
INNER JOIN countList cl ON m.member_id = cl.member_id
                        AND cl.registration_count = (SELECT MIN(registration_count) 
                                                     FROM countList);

-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class
WITH countList AS (SELECT COUNT(member_id) AS count
                   FROM class_attendance
                   WHERE attendance_status = 'Attended')
SELECT 1.0*cl.count/COUNT(*)*100 AS percentage --Percentage formula
FROM members m
INNER JOIN countList cl;
