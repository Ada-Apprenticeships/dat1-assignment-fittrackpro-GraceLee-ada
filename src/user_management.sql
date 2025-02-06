-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- User Management Queries

-- 1. Retrieve all members
-- TODO: Write a query to retrieve all members
SELECT member_id, first_name, last_name, email, join_date
FROM members;

-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information

--Displays phone number and email before
SELECT phone_number, email
FROM members
WHERE member_id = 5;

--Update query
UPDATE members
SET phone_number = '123-123', email = 'emily.jones.updated@email.com' --When testing this, change to a different phone number to see difference
WHERE member_id = 5;

--Displays phone number after
SELECT phone_number, email
FROM members
WHERE member_id = 5;

-- 3. Count total number of members
-- TODO: Write a query to count the total number of members
SELECT COUNT(*) AS memberCount
FROM members;

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations
SELECT m.member_id, m.first_name, m.last_name, MAX(registration_count) AS registration_count
FROM (SELECT m.member_id, COUNT(ca.member_id) AS registration_count
    FROM members m 
    INNER JOIN class_attendance ca ON ca.member_id = m.member_id AND ca.attendance_status = 'Registered'
    GROUP BY ca.member_id) countList
LEFT JOIN members m ON m.member_id = countList.member_id;

-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations
SELECT m.member_id, m.first_name, m.last_name, MIN(registration_count) AS registration_count
FROM (SELECT m.member_id, COUNT(ca.member_id) AS registration_count
    FROM members m 
    INNER JOIN class_attendance ca ON ca.member_id = m.member_id AND ca.attendance_status = 'Registered'
    GROUP BY ca.member_id) countList
INNER JOIN members m ON m.member_id = countList.member_id;

-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class
-- SELECT  (SELECT COUNT(member_id)
--         FROM class_attendance
--         WHERE attendance_status = 'Attended')/(SELECT COUNT(*) FROM members)*100
        
