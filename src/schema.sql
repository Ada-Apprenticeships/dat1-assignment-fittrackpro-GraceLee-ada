-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_key = ON;

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

--Staff
DROP TABLE IF EXISTS staff;

CREATE TABLE staff(
    staff_id                VARCHAR(10) PRIMARY KEY,
    first_name              VARCHAR(100),
    last_name               VARCHAR(100),
    email                   VARCHAR(100),
    phone_number            VARCHAR(20),
    position                VARCHAR(20)
    CHECK(position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance')),
    hire_date               DATE,
    location_id             INTEGER,
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);

--Equipment-----------------------------------------------------------
DROP TABLE IF EXISTS equipment;

CREATE TABLE equipment(
    equipment_id            VARCHAR(10) PRIMARY KEY,
    name                    VARCHAR(20),
    type                    VARCHAR(20)
    CHECK(type IN ('Cardio', 'Strength')),
    purchase_date           DATE,
    last_maintenance_date   DATE,
    next_maintenance_date   DATE,
    location_id             INTEGER,
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);

--Classes---------------------------------------------------------------------
DROP TABLE IF EXISTS classes;

CREATE TABLE classes(
    class_id                VARCHAR(10) PRIMARY KEY,
    name                    VARCHAR(40),
    description             VARCHAR(100),
    capacity                INTEGER,
    duration                INTEGER,
    location_id             INTEGER,
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);

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

--Memberships-----------------------------------------------------
DROP TABLE IF EXISTS memberships;

CREATE TABLE memberships(
    membership_id           INTEGER PRIMARY KEY,
    type                    VARCHAR(15),
    start_date              DATE,
    end_date                DATE,
    status                  VARCHAR(10)
    CHECK(status IN ('Active','Inactive')),
    member_id               INTEGER,
    FOREIGN KEY(member_id) REFERENCES members(member_id)
);

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

--Class Attendance--------------------------------------------
DROP TABLE IF EXISTS class_attendance;

CREATE TABLE class_attendance(
    class_attendance_id     INTEGER PRIMARY KEY,
    attendance_status       VARCHAR(10)
    CHECK(attendance_status IN ('Registered','Attended','Unattended')),
    member_id               INTEGER,
    schedule_id             INTEGER,
    FOREIGN KEY(member_id) REFERENCES members(member_id)
    FOREIGN KEY(schedule_id) REFERENCES class_schedule(schedule_id)
);

--Payments---------------------------------------------------
DROP TABLE IF EXISTS payments;

CREATE TABLE payments(
    payment_id              INTEGER PRIMARY KEY,
    amount                  DECIMAL(10,2),
    payment_date            DATE,
    payment_method          VARCHAR(20)
    CHECK(payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')),
    payment_type            VARCHAR(30)
    CHECK(payment_type IN ('Monthly membership fee', 'Day pass')),
    member_id               INTEGER,
    FOREIGN KEY(member_id) REFERENCES members(member_id)
);

--Personal Training Sessions---------------------------------------------------------
DROP TABLE IF EXISTS personal_training_sessions;

CREATE TABLE personal_training_sessions(
    session_id              INTEGER PRIMARY KEY,
    session_date            DATE,
    start_time              VARCHAR(8),
    end_time                VARCHAR(8),
    notes                   VARCHAR(40),
    member_id               INTEGER,
    staff_id                INTEGER,
    FOREIGN KEY(member_id) REFERENCES members(member_id),
    FOREIGN KEY(staff_id) REFERENCES staff(staff_id)
);

--Member health metrics--------------------------------------------------------
DROP TABLE IF EXISTS member_health_metrics;

CREATE TABLE member_health_metrics(
    metric_id               INTEGER PRIMARY KEY,
    measurement_date        DATE,
    weight                  DECIMAL(10,1),
    body_fat_percentage     DECIMAL(10,1),
    muscle_mass             DECIMAL(10,1),
    bmi                     DECIMAL(10,1),
    member_id               INTEGER,
    FOREIGN KEY(member_id) REFERENCES members(member_id)
);

--Equipment Maintenance Log----------------------------------------------------------
DROP TABLE IF EXISTS equipment_maintenance_log;

CREATE TABLE equipment_maintenance_log(
    log_id                    INTEGER PRIMARY KEY,
    maintenance_date              DATE,
    description               VARCHAR(100),
    staff_id                  INTEGER,
    equipment_id              INTEGER,
    FOREIGN KEY(staff_id)     REFERENCES staff(staff_id),
    FOREIGN KEY(equipment_id) REFERENCES equipment(equipment_id)
);

.read ../scripts/sample_data.sql