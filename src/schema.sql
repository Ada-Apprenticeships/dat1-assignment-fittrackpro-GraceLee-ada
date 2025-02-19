-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support
PRAGMA foreign_key = ON;

--Locations-------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS locations;

CREATE TABLE locations (
    location_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name          VARCHAR(100) NOT NULL,
    address       VARCHAR(100) NOT NULL CHECK(address LIKE '%,%'), --includes at least a city/town after a comma, 
    phone_number  VARCHAR(20),                                     --VARCHAR as different countries have different formats
                                                                   --may not have a phone number
    email         VARCHAR(100)          CHECK(email GLOB '*@*.*'), --may not have an email
                                                                   --every email has at least an @ symbol and a . after
    opening_hours VARCHAR(11)  NOT NULL                            --maximum format is 00:00-00:00 therefore 11 chars (can be single digit)
                                        CHECK(opening_hours GLOB '[0-9][0-9]:[0-9][0-9]-[0-9][0-9]:[0-9][0-9]') --ensures digit format
);

--Members-----------------------------------------
DROP TABLE IF EXISTS members;

CREATE TABLE members (
    member_id               INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name              VARCHAR(100) NOT NULL,
    last_name               VARCHAR(100) NOT NULL,
    email                   VARCHAR(100)           CHECK(email GLOB '*@*.*'), --may not have an email
                                                                              --every email has at least an @ symbol and a . after
    phone_number            VARCHAR(20),                                      --VARCHAR as different countries have different formats
                                                                              --may not have a phone number
    date_of_birth           DATE         NOT NULL  CHECK(date_of_birth GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'), --ensures date format
    join_date               DATE         NOT NULL  CHECK(join_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    emergency_contact_name  VARCHAR(100) NOT NULL  CHECK(emergency_contact_name LIKE '% %'), --ensures first name and last name
    emergency_contact_phone VARCHAR(20)  NOT NULL
);

--Staff
DROP TABLE IF EXISTS staff;

CREATE TABLE staff(
    staff_id                INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name              VARCHAR(100) NOT NULL,
    last_name               VARCHAR(100) NOT NULL,
    email                   VARCHAR(100)           CHECK(email GLOB '*@*.*'), --may not have an email
    phone_number            VARCHAR(20),                                      --may not have a phone number
    position                VARCHAR(20)  NOT NULL  CHECK(position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance')),
    hire_date               DATE         NOT NULL  CHECK(hire_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'), --ensures date format
    location_id             INTEGER      NOT NULL,
    FOREIGN KEY(location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

--Equipment-----------------------------------------------------------
DROP TABLE IF EXISTS equipment;

CREATE TABLE equipment(
    equipment_id            INTEGER PRIMARY KEY AUTOINCREMENT,
    name                    VARCHAR(20) NOT NULL,
    type                    VARCHAR(20) NOT NULL  CHECK(type IN ('Cardio', 'Strength')),
    purchase_date           DATE        NOT NULL  CHECK(purchase_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),         --ensures date format
    last_maintenance_date   DATE        NOT NULL  CHECK(last_maintenance_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'), --ensures date format
    next_maintenance_date   DATE        NOT NULL  CHECK(next_maintenance_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'), --ensures date format
    location_id             INTEGER     NOT NULL,
    FOREIGN KEY(location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

--Classes---------------------------------------------------------------------
DROP TABLE IF EXISTS classes;

CREATE TABLE classes(
    class_id                INTEGER PRIMARY KEY AUTOINCREMENT,
    name                    VARCHAR(40)  NOT NULL,
    description             VARCHAR(100) NOT NULL,
    capacity                INTEGER      NOT NULL,
    duration                INTEGER      NOT NULL,
    location_id             INTEGER      NOT NULL,
    FOREIGN KEY(location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

--Class Schedule--------------------------------------------------------
DROP TABLE IF EXISTS class_schedule;

CREATE TABLE class_schedule(
    schedule_id             INTEGER PRIMARY KEY AUTOINCREMENT,
    start_time              VARCHAR(19) NOT NULL  CHECK(start_time GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]'), --ensures datetime format
    end_time                VARCHAR(19) NOT NULL  CHECK(end_time GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]'),   --ensures datetime format
    class_id                INTEGER     NOT NULL, 
    staff_id                INTEGER     NOT NULL,
    FOREIGN KEY(class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY(staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE
);

--Memberships-----------------------------------------------------
DROP TABLE IF EXISTS memberships;

CREATE TABLE memberships(
    membership_id           INTEGER PRIMARY KEY AUTOINCREMENT,
    type                    VARCHAR(15) NOT NULL,
    start_date              DATE        NOT NULL    CHECK(start_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'), --ensures date format
    end_date                DATE        NOT NULL    CHECK(end_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),   --ensures date format
    status                  VARCHAR(10) NOT NULL    CHECK(status IN ('Active','Inactive')),
    member_id               INTEGER     NOT NULL    CHECK(typeof(member_id) = 'integer'),
    FOREIGN KEY(member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

--Attendance--------------------------------------------------------
DROP TABLE IF EXISTS attendance;

CREATE TABLE attendance(
    attendance_id           INTEGER PRIMARY KEY AUTOINCREMENT,
    check_in_time           VARCHAR(19) NOT NULL CHECK(check_in_time GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]'), --ensures datetime format
    check_out_time          VARCHAR(19) NOT NULL CHECK(check_out_time GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]'),    --ensures datetime format
    member_id               INTEGER     NOT NULL,
    location_id             INTEGER     NOT NULL,
    FOREIGN KEY(member_id) REFERENCES members(member_id) ON DELETE CASCADE
    FOREIGN KEY(location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

--Class Attendance--------------------------------------------
DROP TABLE IF EXISTS class_attendance;

CREATE TABLE class_attendance(
    class_attendance_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    attendance_status       VARCHAR(10) NOT NULL CHECK(attendance_status IN ('Registered','Attended','Unattended')),
    member_id               INTEGER     NOT NULL,
    schedule_id             INTEGER     NOT NULL,
    FOREIGN KEY(member_id) REFERENCES members(member_id) ON DELETE CASCADE
    FOREIGN KEY(schedule_id) REFERENCES class_schedule(schedule_id) ON DELETE CASCADE
);

--Payments---------------------------------------------------
DROP TABLE IF EXISTS payments;

CREATE TABLE payments(
    payment_id              INTEGER PRIMARY KEY AUTOINCREMENT,
    amount                  REAL        NOT NULL    CHECK(amount=ROUND(amount,2)), --limits to 2 decimal places
    payment_date            DATE        NOT NULL    CHECK(payment_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]'), --ensures datetime format
    payment_method          VARCHAR(20) NOT NULL    CHECK(payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')),
    payment_type            VARCHAR(30) NOT NULL    CHECK(payment_type IN ('Monthly membership fee', 'Day pass')),
    member_id               INTEGER     NOT NULL,
    FOREIGN KEY(member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

--Personal Training Sessions---------------------------------------------------------
DROP TABLE IF EXISTS personal_training_sessions;

CREATE TABLE personal_training_sessions(
    session_id              INTEGER PRIMARY KEY AUTOINCREMENT,
    session_date            DATE        NOT NULL    CHECK(session_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'), --ensures date format
    start_time              VARCHAR(8)  NOT NULL    CHECK(start_time GLOB '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]'),           --ensures time format
    end_time                VARCHAR(8)  NOT NULL    CHECK(end_time GLOB '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]'),           --ensures time format
    notes                   VARCHAR(40) NOT NULL,
    member_id               INTEGER     NOT NULL,
    staff_id                INTEGER     NOT NULL,
    FOREIGN KEY(member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY(staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE
);

--Member health metrics--------------------------------------------------------
DROP TABLE IF EXISTS member_health_metrics;

CREATE TABLE member_health_metrics(
    metric_id               INTEGER PRIMARY KEY AUTOINCREMENT,
    measurement_date        DATE    NOT NULL,
    weight                  REAL    NOT NULL    CHECK(weight=ROUND(weight,1)),
    body_fat_percentage     REAL    NOT NULL    CHECK(body_fat_percentage=ROUND(body_fat_percentage,1)), --limits to 1 decimal place
    muscle_mass             REAL    NOT NULL    CHECK(muscle_mass=ROUND(muscle_mass,1)),                 --limits to 1 decimal place
    bmi                     REAL    NOT NULL    CHECK(bmi=ROUND(bmi,1)),                                 --limits to 1 decimal place
    member_id               INTEGER NOT NULL,
    FOREIGN KEY(member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

--Equipment Maintenance Log----------------------------------------------------------
DROP TABLE IF EXISTS equipment_maintenance_log;

CREATE TABLE equipment_maintenance_log(
    log_id                    INTEGER PRIMARY KEY AUTOINCREMENT,
    maintenance_date          DATE          NOT NULL CHECK(maintenance_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'), --ensures date format   
    description               VARCHAR(100)  NOT NULL,
    staff_id                  INTEGER       NOT NULL,
    equipment_id              INTEGER       NOT NULL,
    FOREIGN KEY(staff_id)     REFERENCES staff(staff_id) ON DELETE CASCADE,
    FOREIGN KEY(equipment_id) REFERENCES equipment(equipment_id) ON DELETE CASCADE
);

--imports sample data
.read ../scripts/sample_data.sql