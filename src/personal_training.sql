-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Personal Training Queries

-- 1. List all personal training sessions for a specific trainer
-- TODO: Write a query to list all personal training sessions for a specific trainer
--NOTES: interpreted as giving member names for a trainer, not the trainer name
SELECT pts.session_id, 
       m.first_name||' '||m.last_name AS member_name, 
       pts.session_date, 
       pts.start_time, 
       pts.end_time
FROM personal_training_sessions pts
INNER JOIN members m, staff s ON pts.member_id = m.member_id
                              AND pts.staff_id = s.staff_id 
                              AND s.first_name||' '||s.last_name = 'Ivy Irwin';
