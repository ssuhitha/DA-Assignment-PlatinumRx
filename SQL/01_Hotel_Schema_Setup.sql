-- =============================================
-- Hotel Management System - Schema & Sample Data
-- =============================================

CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(20),
    mail_id VARCHAR(100),
    billing_address TEXT
);

CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Sample Data
INSERT INTO users VALUES
('21wrcxuy-67erfn', 'John Doe',   '9700000001', 'john.doe@example.com',   '10, Street A, City X'),
('usr-abc123-xyz1', 'Jane Smith', '9700000002', 'jane.smith@example.com', '20, Street B, City Y'),
('usr-def456-uvw2', 'Bob Ray',    '9700000003', 'bob.ray@example.com',    '30, Street C, City Z'),
('usr-ghi789-rst3', 'Alice Tay',  '9700000004', 'alice.t@example.com',    '40, Street D, City W');

INSERT INTO items VALUES
('itm-a9e8-q8fu',  'Tawa Paratha', 18),
('itm-a07vh-aer8', 'Mix Veg',      89),
('itm-w978-23u4',  'Dal Fry',      120),
('itm-x123-bcde',  'Paneer Tikka', 250),
('itm-y456-fghi',  'Cold Coffee',  80),
('itm-z789-jklm',  'Veg Biryani',  180);

INSERT INTO bookings VALUES
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-q034-q4o',   '2021-10-05 09:00:00', 'rm-c123-xyzab', 'usr-abc123-xyz1'),
('bk-r567-mnop',  '2021-10-15 11:00:00', 'rm-d456-pqrst', 'usr-def456-uvw2'),
('bk-s890-qrst',  '2021-11-03 14:00:00', 'rm-e789-uvwxy', 'usr-ghi789-rst3'),
('bk-t111-uvwx',  '2021-11-20 16:00:00', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-u222-yzab',  '2021-11-25 10:00:00', 'rm-c123-xyzab', 'usr-abc123-xyz1'),
('bk-v333-cdef',  '2021-12-01 08:00:00', 'rm-f000-abcde', 'usr-def456-uvw2');

INSERT INTO booking_commercials VALUES
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu',  3),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('134lr-oyfo8-3qk4','bk-q034-q4o',   'bl-34qhd-r7h8', '2021-10-05 12:05:37', 'itm-w978-23u4',  2),
('bc001-oct1',      'bk-q034-q4o',   'bl-34qhd-r7h8', '2021-10-05 12:05:37', 'itm-x123-bcde',  1),
('bc002-oct2',      'bk-r567-mnop',  'bl-oct2-bill1', '2021-10-15 13:00:00', 'itm-a9e8-q8fu',  5),
('bc003-oct3',      'bk-r567-mnop',  'bl-oct2-bill1', '2021-10-15 13:00:00', 'itm-y456-fghi',  3),
('bc004-oct4',      'bk-r567-mnop',  'bl-oct2-bill1', '2021-10-15 13:00:00', 'itm-z789-jklm',  4),
('bc005-nov1',      'bk-s890-qrst',  'bl-nov1-bill1', '2021-11-03 15:00:00', 'itm-x123-bcde',  3),
('bc006-nov1b',     'bk-s890-qrst',  'bl-nov1-bill1', '2021-11-03 15:00:00', 'itm-z789-jklm',  2),
('bc007-nov2',      'bk-t111-uvwx',  'bl-nov2-bill1', '2021-11-20 17:00:00', 'itm-a07vh-aer8', 4),
('bc008-nov2b',     'bk-t111-uvwx',  'bl-nov2-bill1', '2021-11-20 17:00:00', 'itm-w978-23u4',  2),
('bc009-nov3',      'bk-u222-yzab',  'bl-nov3-bill1', '2021-11-25 11:00:00', 'itm-y456-fghi',  6),
('bc010-dec1',      'bk-v333-cdef',  'bl-dec1-bill1', '2021-12-01 09:00:00', 'itm-a9e8-q8fu',  2);
