-- =============================================
-- Clinic Management System - Schema & Sample Data
-- =============================================

CREATE TABLE clinics (
    cid          VARCHAR(50) PRIMARY KEY,
    clinic_name  VARCHAR(100),
    city         VARCHAR(100),
    state        VARCHAR(100),
    country      VARCHAR(100)
);

CREATE TABLE customer (
    uid    VARCHAR(50) PRIMARY KEY,
    name   VARCHAR(100),
    mobile VARCHAR(20)
);

CREATE TABLE clinic_sales (
    oid          VARCHAR(50) PRIMARY KEY,
    uid          VARCHAR(50),
    cid          VARCHAR(50),
    amount       DECIMAL(10,2),
    datetime     DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
    eid         VARCHAR(50) PRIMARY KEY,
    cid         VARCHAR(50),
    description VARCHAR(200),
    amount      DECIMAL(10,2),
    datetime    DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- Sample Data
INSERT INTO clinics VALUES
('cnc-0100001', 'HealthPlus Clinic',  'Mumbai',    'Maharashtra', 'India'),
('cnc-0100002', 'CareFirst Clinic',   'Pune',      'Maharashtra', 'India'),
('cnc-0100003', 'MediCure Clinic',    'Bangalore', 'Karnataka',   'India'),
('cnc-0100004', 'WellLife Clinic',    'Mysore',    'Karnataka',   'India'),
('cnc-0100005', 'QuickHeal Clinic',   'Chennai',   'Tamil Nadu',  'India');

INSERT INTO customer VALUES
('bk-09f3e-95hj', 'Jon Doe',    '9700000001'),
('cust-abc-001',  'Priya M',    '9700000002'),
('cust-def-002',  'Ravi S',     '9700000003'),
('cust-ghi-003',  'Anita K',    '9700000004'),
('cust-jkl-004',  'Suresh P',   '9700000005');

INSERT INTO clinic_sales VALUES
('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'online'),
('ord-00100-00101', 'cust-abc-001',  'cnc-0100001', 15000, '2021-10-10 09:00:00', 'walkin'),
('ord-00100-00102', 'cust-def-002',  'cnc-0100002', 8000,  '2021-10-15 11:00:00', 'online'),
('ord-00100-00103', 'cust-ghi-003',  'cnc-0100003', 32000, '2021-11-05 14:00:00', 'referral'),
('ord-00100-00104', 'cust-jkl-004',  'cnc-0100004', 5000,  '2021-11-20 16:00:00', 'walkin'),
('ord-00100-00105', 'bk-09f3e-95hj', 'cnc-0100002', 12000, '2021-11-25 10:00:00', 'online'),
('ord-00100-00106', 'cust-abc-001',  'cnc-0100003', 45000, '2021-12-01 08:00:00', 'referral'),
('ord-00100-00107', 'cust-def-002',  'cnc-0100005', 9500,  '2021-12-15 13:00:00', 'walkin'),
('ord-00100-00108', 'cust-ghi-003',  'cnc-0100001', 18000, '2021-12-20 15:00:00', 'online'),
('ord-00100-00109', 'cust-jkl-004',  'cnc-0100004', 22000, '2021-12-28 09:30:00', 'referral');

INSERT INTO expenses VALUES
('exp-0100-00100', 'cnc-0100001', 'first-aid supplies', 557,  '2021-09-23 07:36:48'),
('exp-0100-00101', 'cnc-0100001', 'staff salary',       8000, '2021-10-01 09:00:00'),
('exp-0100-00102', 'cnc-0100002', 'medicines',          3000, '2021-10-15 10:00:00'),
('exp-0100-00103', 'cnc-0100003', 'equipment repair',   5000, '2021-11-05 08:00:00'),
('exp-0100-00104', 'cnc-0100004', 'utilities',          1500, '2021-11-20 12:00:00'),
('exp-0100-00105', 'cnc-0100002', 'cleaning supplies',  800,  '2021-11-25 09:00:00'),
('exp-0100-00106', 'cnc-0100003', 'staff salary',       12000,'2021-12-01 07:00:00'),
('exp-0100-00107', 'cnc-0100005', 'medicines',          2500, '2021-12-15 10:00:00'),
('exp-0100-00108', 'cnc-0100001', 'rent',               10000,'2021-12-20 08:00:00'),
('exp-0100-00109', 'cnc-0100004', 'staff salary',       7000, '2021-12-28 08:00:00');
