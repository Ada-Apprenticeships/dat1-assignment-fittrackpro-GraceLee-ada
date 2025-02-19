-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Equipment Management Queries

-- 1. Find equipment due for maintenance
-- TODO: Write a query to find equipment due for maintenance
SELECT equipment_id, 
       name, 
       next_maintenance_date
FROM equipment
WHERE next_maintenance_date BETWEEN DATE('now') 
                            AND DATE('now', '+30 day');

-- 2. Count equipment types in stock
-- TODO: Write a query to count equipment types in stock
SELECT type AS equipment_type, 
       COUNT(type) as count
FROM equipment
GROUP BY type;

-- 3. Calculate average age of equipment by type (in days)
-- TODO: Write a query to calculate average age of equipment by type (in days)
SELECT type AS equipment_type, 
       AVG(days) AS avg_age_days
FROM (SELECT type, 
             JULIANDAY('now')-JULIANDAY(purchase_date) AS days
      FROM equipment)
GROUP BY type;