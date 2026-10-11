USE SIMS;

START TRANSACTION;

INSERT INTO users (name, email, password, role)
VALUES
    ('nepaladmin', 'admin@sims.test', 'Kathmandu@123', 'admin'),
    ('sita_kc', 'sita.kc@sims.test', 'Himalaya@123', 'student'),
    ('ram_thapa', 'ram.thapa@sims.test', 'Pokhara@123', 'student'),
    ('anil_gurung', 'anil.gurung@sims.test', 'Lumbini@123', 'student')
ON DUPLICATE KEY UPDATE
    email = VALUES(email),
    password = VALUES(password),
    role = VALUES(role);

SET @sita_uid = (SELECT uid FROM users WHERE name = 'sita_kc');
SET @ram_uid = (SELECT uid FROM users WHERE name = 'ram_thapa');
SET @anil_uid = (SELECT uid FROM users WHERE name = 'anil_gurung');

INSERT INTO students (uid, sname, age, address, p_phoneno, s_phoneno)
SELECT @sita_uid, 'Sita KC', 20, 'Lalitpur, Nepal', '9800000001', '9810000001'
WHERE NOT EXISTS (SELECT 1 FROM students WHERE uid = @sita_uid);

INSERT INTO students (uid, sname, age, address, p_phoneno, s_phoneno)
SELECT @ram_uid, 'Ram Thapa', 21, 'Pokhara, Nepal', '9800000002', '9810000002'
WHERE NOT EXISTS (SELECT 1 FROM students WHERE uid = @ram_uid);

INSERT INTO students (uid, sname, age, address, p_phoneno, s_phoneno)
SELECT @anil_uid, 'Anil Gurung', 19, 'Dharan, Nepal', '9800000003', '9810000003'
WHERE NOT EXISTS (SELECT 1 FROM students WHERE uid = @anil_uid);

INSERT INTO subjects (subject_name, scode, theory, practical)
VALUES
    ('Nepali Language', 'NEP101', 70, 30),
    ('Database Systems', 'DBMS201', 60, 40),
    ('Web Technology', 'WEB202', 50, 50),
    ('Software Engineering', 'SE203', 70, 30)
ON DUPLICATE KEY UPDATE
    theory = VALUES(theory),
    practical = VALUES(practical);

SET @nepali_id = (SELECT subjectid FROM subjects WHERE scode = 'NEP101');
SET @dbms_id = (SELECT subjectid FROM subjects WHERE scode = 'DBMS201');
SET @web_id = (SELECT subjectid FROM subjects WHERE scode = 'WEB202');
SET @se_id = (SELECT subjectid FROM subjects WHERE scode = 'SE203');

SET @sita_sid = (SELECT sid FROM students WHERE uid = @sita_uid);
SET @ram_sid = (SELECT sid FROM students WHERE uid = @ram_uid);
SET @anil_sid = (SELECT sid FROM students WHERE uid = @anil_uid);

INSERT INTO learns (sid, subjectid)
SELECT @sita_sid, @nepali_id WHERE NOT EXISTS (SELECT 1 FROM learns WHERE sid = @sita_sid AND subjectid = @nepali_id);
INSERT INTO learns (sid, subjectid)
SELECT @sita_sid, @dbms_id WHERE NOT EXISTS (SELECT 1 FROM learns WHERE sid = @sita_sid AND subjectid = @dbms_id);
INSERT INTO learns (sid, subjectid)
SELECT @sita_sid, @web_id WHERE NOT EXISTS (SELECT 1 FROM learns WHERE sid = @sita_sid AND subjectid = @web_id);
INSERT INTO learns (sid, subjectid)
SELECT @ram_sid, @dbms_id WHERE NOT EXISTS (SELECT 1 FROM learns WHERE sid = @ram_sid AND subjectid = @dbms_id);
INSERT INTO learns (sid, subjectid)
SELECT @ram_sid, @web_id WHERE NOT EXISTS (SELECT 1 FROM learns WHERE sid = @ram_sid AND subjectid = @web_id);
INSERT INTO learns (sid, subjectid)
SELECT @ram_sid, @se_id WHERE NOT EXISTS (SELECT 1 FROM learns WHERE sid = @ram_sid AND subjectid = @se_id);
INSERT INTO learns (sid, subjectid)
SELECT @anil_sid, @nepali_id WHERE NOT EXISTS (SELECT 1 FROM learns WHERE sid = @anil_sid AND subjectid = @nepali_id);
INSERT INTO learns (sid, subjectid)
SELECT @anil_sid, @se_id WHERE NOT EXISTS (SELECT 1 FROM learns WHERE sid = @anil_sid AND subjectid = @se_id);

INSERT INTO attendance (id, sid, subject_name, attendance)
SELECT l.id, l.sid, s.subject_name, 88.00
FROM learns l JOIN subjects s ON s.subjectid = l.subjectid
WHERE l.sid = @sita_sid AND l.subjectid = @nepali_id
  AND NOT EXISTS (SELECT 1 FROM attendance a WHERE a.sid = l.sid AND a.subject_name = s.subject_name);

INSERT INTO attendance (id, sid, subject_name, attendance)
SELECT l.id, l.sid, s.subject_name, 76.00
FROM learns l JOIN subjects s ON s.subjectid = l.subjectid
WHERE l.sid = @sita_sid AND l.subjectid = @dbms_id
  AND NOT EXISTS (SELECT 1 FROM attendance a WHERE a.sid = l.sid AND a.subject_name = s.subject_name);

INSERT INTO attendance (id, sid, subject_name, attendance)
SELECT l.id, l.sid, s.subject_name, 92.00
FROM learns l JOIN subjects s ON s.subjectid = l.subjectid
WHERE l.sid = @sita_sid AND l.subjectid = @web_id
  AND NOT EXISTS (SELECT 1 FROM attendance a WHERE a.sid = l.sid AND a.subject_name = s.subject_name);

INSERT INTO attendance (id, sid, subject_name, attendance)
SELECT l.id, l.sid, s.subject_name, 81.00
FROM learns l JOIN subjects s ON s.subjectid = l.subjectid
WHERE l.sid = @ram_sid AND l.subjectid = @dbms_id
  AND NOT EXISTS (SELECT 1 FROM attendance a WHERE a.sid = l.sid AND a.subject_name = s.subject_name);

INSERT INTO attendance (id, sid, subject_name, attendance)
SELECT l.id, l.sid, s.subject_name, 69.00
FROM learns l JOIN subjects s ON s.subjectid = l.subjectid
WHERE l.sid = @ram_sid AND l.subjectid = @web_id
  AND NOT EXISTS (SELECT 1 FROM attendance a WHERE a.sid = l.sid AND a.subject_name = s.subject_name);

INSERT INTO attendance (id, sid, subject_name, attendance)
SELECT l.id, l.sid, s.subject_name, 85.00
FROM learns l JOIN subjects s ON s.subjectid = l.subjectid
WHERE l.sid = @ram_sid AND l.subjectid = @se_id
  AND NOT EXISTS (SELECT 1 FROM attendance a WHERE a.sid = l.sid AND a.subject_name = s.subject_name);

INSERT INTO attendance (id, sid, subject_name, attendance)
SELECT l.id, l.sid, s.subject_name, 95.00
FROM learns l JOIN subjects s ON s.subjectid = l.subjectid
WHERE l.sid = @anil_sid AND l.subjectid = @nepali_id
  AND NOT EXISTS (SELECT 1 FROM attendance a WHERE a.sid = l.sid AND a.subject_name = s.subject_name);

INSERT INTO attendance (id, sid, subject_name, attendance)
SELECT l.id, l.sid, s.subject_name, 73.00
FROM learns l JOIN subjects s ON s.subjectid = l.subjectid
WHERE l.sid = @anil_sid AND l.subjectid = @se_id
  AND NOT EXISTS (SELECT 1 FROM attendance a WHERE a.sid = l.sid AND a.subject_name = s.subject_name);

INSERT INTO notice (title, description, date)
SELECT 'Dashain Holiday Notice', 'The campus will remain closed during the Dashain holiday. Classes resume after the holiday.', '2026-10-15'
WHERE NOT EXISTS (SELECT 1 FROM notice WHERE title = 'Dashain Holiday Notice');

COMMIT;
