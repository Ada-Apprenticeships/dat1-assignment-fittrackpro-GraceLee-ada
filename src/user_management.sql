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
SELECT COUNT(*) as memberCount
FROM members;

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations
-- SELECT m.member_id, m.first_name, m.last_name, COUNT(c.member_id) as registration_Count
-- FROM class_attendance c
-- INNER JOIN members m ON (c.attendance_status = 'Registered') AND (c.member_id = m.member_id);

-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations

-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class
