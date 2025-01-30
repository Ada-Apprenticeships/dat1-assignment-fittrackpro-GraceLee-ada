-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- User Management Queries

-- 1. Retrieve all members
-- TODO: Write a query to retrieve all members
SELECT member_id, first_name, last_name
FROM members;

-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information

--Displays phone number before
SELECT phone_number
FROM members
WHERE first_name = 'Ivy' AND last_name = 'Moore';

--Update query
UPDATE members
SET phone_number = '111-2222'
WHERE members.first_name = 'Ivy' AND members.last_name = 'Moore';

--Displays phone number after
SELECT phone_number
FROM members
WHERE first_name = 'Ivy' AND last_name = 'Moore';

-- 3. Count total number of members
-- TODO: Write a query to count the total number of members
SELECT COUNT(*) as memberCount
FROM members;

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations


-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations

-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class