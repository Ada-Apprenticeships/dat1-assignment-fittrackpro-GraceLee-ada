-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode box

-- Enable foreign key support
PRAGMA foreign_key = ON;

-- Create your tables here
-- Example:
-- CREATE TABLE table_name (
--     column1 datatype,
--     column2 datatype,
--     ...
-- );

-- TODO: Create the following tables:
-- 1. locations
-- 2. members
-- 3. staff
-- 4. equipment
-- 5. classes
-- 6. class_schedule
-- 7. memberships
-- 8. attendance
-- 9. class_attendance
-- 10. payments
-- 11. personal_training_sessions
-- 12. member_health_metrics
-- 13. equipment_maintenance_log

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal

--Locations-------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS locations;

CREATE TABLE locations (
    location_id   INTEGER PRIMARY KEY,
    name          VARCHAR(100),
    address       VARCHAR(100),
    phone_number  VARCHAR(20),
    email         VARCHAR(100),
    opening_hours VARCHAR(11)
);

INSERT INTO locations (name, address, phone_number, email, opening_hours)
VALUES 
('Downtown Fitness', '123 Main St, Cityville', '555-1234', 'downtown@fittrackpro.com', '6:00-22:00'),
('Suburb Gym', '456 Oak Rd, Townsburg', '555-5678', 'suburb@fittrackpro.com', '5:00-23:00');

--Members-----------------------------------------
DROP TABLE IF EXISTS members;

CREATE TABLE members (
    member_id               VARCHAR(10) PRIMARY KEY,
    first_name              VARCHAR(100),
    last_name               VARCHAR(100),
    email                   VARCHAR(100),
    phone_number            VARCHAR(20),
    date_of_birth           DATE,
    join_date               DATE,
    emergency_contact_name  VARCHAR(100),
    emergency_contact_phone VARCHAR(20)
);

INSERT INTO members (first_name, last_name, email, phone_number, date_of_birth, join_date, emergency_contact_name, emergency_contact_phone)
VALUES 
('Alice', 'Johnson', 'alice.j@email.com', '555-1111', '1990-05-15', '2024-11-10', 'Bob Johnson', '555-1112'),
('Bob', 'Smith', 'bob.s@email.com', '555-2222', '1985-09-22', '2024-12-15', 'Alice Smith', '555-2223'),
('Carol', 'Williams', 'carol.w@email.com', '555-3333', '1992-12-03', '2025-01-20', 'David Williams', '555-3334'),
('David', 'Brown', 'david.b@email.com', '555-4444', '1988-07-30', '2024-11-25', 'Emily Brown', '555-4445'),
('Emily', 'Jones', 'emily.j@email.com', '555-5555', '1995-03-12', '2024-12-30', 'Frank Jones', '555-5556'),
('Frank', 'Miller', 'frank.m@email.com', '555-6666', '1983-11-18', '2025-01-10', 'Grace Miller', '555-6667'),
('Grace', 'Davis', 'grace.d@email.com', '555-7777', '1993-01-25', '2024-11-20', 'Henry Davis', '555-7778'),
('Henry', 'Wilson', 'henry.w@email.com', '555-8888', '1987-08-05', '2024-12-15', 'Ivy Wilson', '555-8889'),
('Ivy', 'Moore', 'ivy.m@email.com', '555-9999', '1991-04-09', '2025-01-01', 'Jack Moore', '555-9990'),
('Jack', 'Taylor', 'jack.t@email.com', '555-0000', '1986-06-28', '2024-11-12', 'Kelly Taylor', '555-0001'),
('Karen', 'Lee', 'karen.l@email.com', '555-1313', '1989-02-14', '2024-12-05', 'Liam Lee', '555-1314'),
('Liam', 'Anderson', 'liam.a@email.com', '555-1515', '1994-07-19', '2025-01-01', 'Mia Anderson', '555-1516'),
('Mia', 'Thomas', 'mia.t@email.com', '555-1717', '1991-11-30', '2025-01-10', 'Noah Thomas', '555-1718'),
('Noah', 'Roberts', 'noah.r@email.com', '555-1919', '1987-04-25', '2025-01-15', 'Olivia Roberts', '555-1920'),
('Olivia', 'Clark', 'olivia.c@email.com', '555-2121', '1993-09-08', '2025-01-20', 'Peter Clark', '555-2122');

--Staff
DROP TABLE IF EXISTS staff;

CREATE TABLE staff(
    staff_id                VARCHAR(10) PRIMARY KEY,
    first_name              VARCHAR(100),
    last_name               VARCHAR(100),
    email                   VARCHAR(100),
    phone_number            VARCHAR(20),
    position                VARCHAR(20), --CHECK IF TRAINER,MANAGER ETC. HERE
    hire_date               DATE,
    location_id             INTEGER,
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);

INSERT INTO staff (first_name, last_name, email, phone_number, position, hire_date, location_id)
VALUES 
('David', 'Brown', 'david.b@fittrackpro.com', '555-4444', 'Trainer', '2024-11-10', 1),
('Emma', 'Davis', 'emma.d@fittrackpro.com', '555-5555', 'Manager', '2024-11-15', 2),
('Frank', 'Evans', 'frank.e@fittrackpro.com', '555-6666', 'Receptionist', '2024-12-10', 1),
('Grace', 'Green', 'grace.g@fittrackpro.com', '555-7777', 'Trainer', '2024-12-20', 2),
('Henry', 'Harris', 'henry.h@fittrackpro.com', '555-8888', 'Maintenance', '2025-01-05', 1),
('Ivy', 'Irwin', 'ivy.i@fittrackpro.com', '555-9999', 'Trainer', '2025-01-01', 2),
('Jack', 'Johnson', 'jack.j@fittrackpro.com', '555-0000', 'Manager', '2024-11-15', 1),
('Karen', 'King', 'karen.k@fittrackpro.com', '555-1212', 'Trainer', '2024-12-01', 2);

--Equipment-----------------------------------------------------------
DROP TABLE IF EXISTS equipment;

CREATE TABLE equipment(
    equipment_id            VARCHAR(10) PRIMARY KEY,
    name                    VARCHAR(20),
    type                    VARCHAR(20), --CHECK IF CARDIO|STRENGTH
    purchase_date           DATE,
    last_maintenance_date   DATE,
    next_maintenance_date   DATE,
    location_id             INTEGER,
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);

INSERT INTO equipment (name, type, purchase_date, last_maintenance_date, next_maintenance_date, location_id)
VALUES 
('Treadmill 1', 'Cardio', '2024-11-01', '2024-11-15', '2025-02-15', 1),
('Treadmill 2', 'Cardio', '2024-11-02', '2024-11-20', '2025-02-20', 1),
('Treadmill 3', 'Cardio', '2024-11-03', '2024-11-25', '2025-02-25', 2),
('Treadmill 4', 'Cardio', '2024-11-04', '2024-11-30', '2025-02-28', 2),
('Bench Press 1', 'Strength', '2024-11-05', '2024-12-01', '2025-03-01', 1),
('Bench Press 2', 'Strength', '2024-11-06', '2024-12-05', '2025-03-05', 2),
('Elliptical 1', 'Cardio', '2024-11-07', '2024-12-10', '2025-03-10', 1),
('Elliptical 2', 'Cardio', '2024-11-08', '2024-12-15', '2025-03-15', 2),
('Squat Rack 1', 'Strength', '2024-11-09', '2024-12-20', '2025-03-20', 1),
('Squat Rack 2', 'Strength', '2024-11-10', '2024-12-25', '2025-03-25', 2),
('Rowing Machine 1', 'Cardio', '2024-11-11', '2024-12-30', '2025-03-30', 1),
('Rowing Machine 2', 'Cardio', '2024-11-12', '2025-01-01', '2025-04-01', 2),
('Leg Press 1', 'Strength', '2024-11-13', '2025-01-05', '2025-04-05', 1),
('Leg Press 2', 'Strength', '2024-11-14', '2025-01-10', '2025-04-10', 2),
('Stationary Bike 1', 'Cardio', '2024-11-15', '2025-01-15', '2025-04-15', 1),
('Stationary Bike 2', 'Cardio', '2024-11-16', '2025-01-20', '2025-04-20', 2);

--Classes---------------------------------------------------------------------
DROP TABLE IF EXISTS classes;

CREATE TABLE classes(
    class_id                VARCHAR(10) PRIMARY KEY,
    name                    VARCHAR(40),
    description             VARCHAR(100), --CHECK IF CARDIO|STRENGTH
    capacity                INTEGER,
    duration                INTEGER,
    location_id             INTEGER,
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);

INSERT INTO classes (name, description, capacity, duration, location_id)
VALUES 
('Yoga Basics', 'Introductory yoga class', 20, 60, 1),
('HIIT Workout', 'High-intensity interval training', 15, 45, 2),
('Spin Class', 'Indoor cycling workout', 20, 50, 1),
('Pilates', 'Core-strengthening exercises', 15, 55, 2),
('Zumba', 'Dance-based cardio workout', 25, 60, 1),
('Strength Training', 'Weight-based resistance training', 12, 45, 2);

--Class Schedule--------------------------------------------------------
DROP TABLE IF EXISTS class_schedule;

CREATE TABLE class_schedule(
    schedule_id             INTEGER PRIMARY KEY,
    start_time              VARCHAR(19),
    end_time                VARCHAR(19),
    class_id                INTEGER,
    staff_id                INTEGER,
    FOREIGN KEY(class_id) REFERENCES classes(class_id),
    FOREIGN KEY(staff_id) REFERENCES staff(staff_id)
);

INSERT INTO class_schedule (class_id, staff_id, start_time, end_time)
VALUES 
(1, 1, '2024-11-01 10:00:00', '2024-11-01 11:00:00'),
(2, 2, '2024-11-15 18:00:00', '2024-11-15 18:45:00'),
(3, 6, '2024-12-03 07:00:00', '2024-12-03 07:50:00'),
(4, 4, '2024-12-20 09:00:00', '2024-12-20 09:55:00'),
(5, 8, '2025-01-05 19:00:00', '2025-01-05 20:00:00'),
(6, 1, '2025-01-20 12:00:00', '2025-01-20 12:45:00'),
(3, 6, '2025-02-01 14:00:00', '2025-02-01 14:50:00'),
(5, 8, '2025-02-01 19:00:00', '2025-02-01 20:00:00'),
(5, 4, '2025-02-15 09:00:00', '2025-02-15 10:00:00');

--Memberships-----------------------------------------------------
DROP TABLE IF EXISTS memberships;

CREATE TABLE memberships(
    membership_id           INTEGER PRIMARY KEY,
    type                    VARCHAR(15),
    start_date              DATE,
    end_date                DATE,
    status                  VARCHAR(10), --CHECK IF ACTIVE/INACTIVE 
    member_id               INTEGER,
    FOREIGN KEY(member_id) REFERENCES members(member_id)
);

INSERT INTO memberships (member_id, type, start_date, end_date, status)
VALUES
(1, 'Premium', '2024-11-01', '2025-10-31', 'Active'),
(2, 'Basic', '2024-11-05', '2025-11-04', 'Active'),
(3, 'Premium', '2024-11-10', '2025-11-09', 'Active'),
(4, 'Basic', '2024-11-15', '2025-11-14', 'Active'),
(5, 'Premium', '2024-11-20', '2025-11-19', 'Active'),
(6, 'Basic', '2024-11-25', '2025-11-24', 'Inactive'),
(7, 'Premium', '2024-12-01', '2025-11-30', 'Active'),
(8, 'Basic', '2024-12-05', '2025-12-04', 'Active'),
(9, 'Premium', '2024-12-10', '2025-12-09', 'Active'),
(10, 'Basic', '2024-12-15', '2025-12-14', 'Inactive'),
(11, 'Premium', '2024-12-20', '2025-12-19', 'Active'),
(12, 'Basic', '2024-12-25', '2025-12-24', 'Active'),
(13, 'Premium', '2025-01-01', '2025-12-31', 'Active'),
(14, 'Basic', '2025-01-05', '2026-01-04', 'Inactive'),
(15, 'Premium', '2025-01-10', '2026-01-09', 'Active');

--Attendance--------------------------------------------------------
DROP TABLE IF EXISTS attendance;

CREATE TABLE attendance(
    attendance_id           INTEGER PRIMARY KEY,
    check_in_time           VARCHAR(19),
    check_out_time          VARCHAR(19),
    member_id               INTEGER,
    location_id             INTEGER,
    FOREIGN KEY(member_id) REFERENCES members(member_id)
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);

INSERT INTO attendance (member_id, location_id, check_in_time, check_out_time)
VALUES 
(1, 1, '2024-11-01 09:00:00', '2024-11-01 10:30:00'),
(2, 2, '2024-11-15 17:30:00', '2024-11-15 19:00:00'),
(3, 1, '2024-12-03 08:00:00', '2024-12-03 09:15:00'),
(4, 2, '2024-12-20 12:00:00', '2024-12-20 13:30:00'),
(5, 1, '2025-01-05 16:00:00', '2025-01-05 17:45:00'),
(6, 2, '2025-01-10 07:30:00', '2025-01-10 08:45:00'),
(7, 1, '2025-01-15 18:00:00', '2025-01-15 19:30:00'),
(8, 2, '2025-01-20 10:00:00', '2025-01-20 11:15:00'),
(9, 1, '2025-01-25 14:30:00', '2025-01-25 16:00:00'),
(10, 2, '2025-01-28 19:00:00', '2025-01-28 20:30:00');

--Class Attendance--------------------------------------------
DROP TABLE IF EXISTS class_attendance;

CREATE TABLE class_attendance(
    class_attendance_id     INTEGER PRIMARY KEY,
    attendance_status       VARCHAR(10), --CHECK IF REGISTERED|ATTENDED|UNATTENDED
    member_id               INTEGER,
    schedule_id             INTEGER,
    FOREIGN KEY(member_id) REFERENCES members(member_id)
    FOREIGN KEY(schedule_id) REFERENCES class_schedule(schedule_id)
);

INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES 
(1, 1, 'Attended'),
(2, 2, 'Attended'),
(3, 3, 'Attended'),
(4, 4, 'Attended'),
(5, 5, 'Attended'),
(6, 6, 'Registered'),
(7, 7, 'Registered'),
(8, 8, 'Registered'),
(1, 9, 'Attended'),
(2, 10, 'Unattended'),
(3, 11, 'Attended'),
(4, 12, 'Unattended'),
(5, 13, 'Attended'),
(6, 1, 'Registered'),
(7, 2, 'Registered'),
(8, 3, 'Registered');

--Payments---------------------------------------------------
DROP TABLE IF EXISTS payments;

CREATE TABLE payments(
    payment_id              INTEGER PRIMARY KEY,
    amount                  DECIMAL(10,2),
    payment_date            DATE,
    payment_method          VARCHAR(20), --CHECK IF CREDIT CARD ETC.
    payment_type            VARCHAR(30), --CHECK IF MONTHLY MEMBERSHIP FEE ETC.
    member_id               INTEGER,
    FOREIGN KEY(member_id) REFERENCES members(member_id)
);

INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES 
(1, 50.00, '2024-11-01 10:00:00', 'Credit Card', 'Monthly membership fee'),
(2, 30.00, '2024-11-05 14:30:00', 'Bank Transfer', 'Monthly membership fee'),
(3, 50.00, '2024-11-10 09:15:00', 'Credit Card', 'Monthly membership fee'),
(4, 30.00, '2024-11-15 16:45:00', 'PayPal', 'Monthly membership fee'),
(5, 50.00, '2024-11-20 11:30:00', 'Credit Card', 'Monthly membership fee'),
(6, 30.00, '2024-11-25 13:00:00', 'Bank Transfer', 'Monthly membership fee'),
(7, 50.00, '2024-12-01 10:30:00', 'Credit Card', 'Monthly membership fee'),
(8, 30.00, '2024-12-05 15:45:00', 'PayPal', 'Monthly membership fee'),
(9, 50.00, '2024-12-10 08:00:00', 'Credit Card', 'Monthly membership fee'),
(10, 30.00, '2024-12-15 17:30:00', 'Bank Transfer', 'Monthly membership fee'),
(11, 15.00, '2025-01-16 09:00:00', 'Cash', 'Day pass'),
(12, 15.00, '2025-01-16 10:30:00', 'Credit Card', 'Day pass'),
(13, 15.00, '2025-01-17 14:00:00', 'Cash', 'Day pass'),
(14, 15.00, '2025-01-18 11:15:00', 'Credit Card', 'Day pass');
