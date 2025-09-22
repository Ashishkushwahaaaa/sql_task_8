CREATE DATABASE task8_db;
USE task8_db;

-- Students
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Books
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    publisher VARCHAR(100)
);

-- Loans
CREATE TABLE loans (
    loan_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    book_id INT NOT NULL,
    loan_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Dummy Data Generated through chatgpt
INSERT INTO students (student_name, email) VALUES
('Student_1', 'student1@mail.com'),
('Student_2', 'student2@mail.com'),
('Student_3', 'student3@mail.com'),
('Student_4', 'student4@mail.com'),
('Student_5', 'student5@mail.com'),
('Student_6', 'student6@mail.com'),
('Student_7', 'student7@mail.com'),
('Student_8', 'student8@mail.com'),
('Student_9', 'student9@mail.com'),
('Student_10', 'student10@mail.com'),
('Student_11', 'student11@mail.com'),
('Student_12', 'student12@mail.com'),
('Student_13', 'student13@mail.com'),
('Student_14', 'student14@mail.com'),
('Student_15', 'student15@mail.com'),
('Student_16', 'student16@mail.com'),
('Student_17', 'student17@mail.com'),
('Student_18', 'student18@mail.com'),
('Student_19', 'student19@mail.com'),
('Student_20', 'student20@mail.com'),
('Student_21', 'student21@mail.com'),
('Student_22', 'student22@mail.com'),
('Student_23', 'student23@mail.com'),
('Student_24', 'student24@mail.com'),
('Student_25', 'student25@mail.com'),
('Student_26', 'student26@mail.com'),
('Student_27', 'student27@mail.com'),
('Student_28', 'student28@mail.com'),
('Student_29', 'student29@mail.com'),
('Student_30', 'student30@mail.com'),
('Student_31', 'student31@mail.com'),
('Student_32', 'student32@mail.com'),
('Student_33', 'student33@mail.com'),
('Student_34', 'student34@mail.com'),
('Student_35', 'student35@mail.com'),
('Student_36', 'student36@mail.com'),
('Student_37', 'student37@mail.com'),
('Student_38', 'student38@mail.com'),
('Student_39', 'student39@mail.com'),
('Student_40', 'student40@mail.com'),
('Student_41', 'student41@mail.com'),
('Student_42', 'student42@mail.com'),
('Student_43', 'student43@mail.com'),
('Student_44', 'student44@mail.com'),
('Student_45', 'student45@mail.com'),
('Student_46', 'student46@mail.com'),
('Student_47', 'student47@mail.com'),
('Student_48', 'student48@mail.com'),
('Student_49', 'student49@mail.com'),
('Student_50', 'student50@mail.com');

-- Dummy data generated through chatgpt
INSERT INTO books (title, publisher) VALUES
('Book_1', 'Publisher_1'),
('Book_2', 'Publisher_2'),
('Book_3', 'Publisher_3'),
('Book_4', 'Publisher_4'),
('Book_5', 'Publisher_5'),
('Book_6', 'Publisher_1'),
('Book_7', 'Publisher_2'),
('Book_8', 'Publisher_3'),
('Book_9', 'Publisher_4'),
('Book_10', 'Publisher_5'),
('Book_11', 'Publisher_1'),
('Book_12', 'Publisher_2'),
('Book_13', 'Publisher_3'),
('Book_14', 'Publisher_4'),
('Book_15', 'Publisher_5'),
('Book_16', 'Publisher_1'),
('Book_17', 'Publisher_2'),
('Book_18', 'Publisher_3'),
('Book_19', 'Publisher_4'),
('Book_20', 'Publisher_5');

-- Method to insert large data sets (help via chatgpt) for real valid test
INSERT INTO loans (student_id, book_id, loan_date, return_date)
SELECT
    FLOOR(1 + RAND()*50),   -- student_id
    FLOOR(1 + RAND()*20),   -- book_id
    loan_date,
    DATE_ADD(loan_date, INTERVAL FLOOR(RAND()*30) DAY)  -- return_date after loan_date
FROM (
    SELECT DATE_ADD('2025-01-01', INTERVAL FLOOR(RAND()*200) DAY) AS loan_date
    FROM information_schema.tables t1
    CROSS JOIN information_schema.tables t2
    LIMIT 50000
) AS derived;

Select count(*) from loans;

-- Select query before indexes
EXPLAIN
SELECT l.loan_id, s.student_name, b.title, l.loan_date, l.return_date
FROM loans l
JOIN students s ON l.student_id = s.student_id
JOIN books b ON l.book_id = b.book_id
WHERE s.student_name = 'Student_25' AND b.title = 'Book_10';


-- Index on student_name for filtering
CREATE INDEX idx_students_name ON students(student_name);

-- Index on book title
CREATE INDEX idx_books_title ON books(title);

-- Index on loans foreign keys (helps JOIN)
CREATE INDEX idx_loans_student ON loans(student_id);
CREATE INDEX idx_loans_book ON loans(book_id);


-- Select query before indexes
EXPLAIN
SELECT l.loan_id, s.student_name, b.title, l.loan_date, l.return_date
FROM loans l
JOIN students s ON l.student_id = s.student_id
JOIN books b ON l.book_id = b.book_id
WHERE s.student_name = 'Student_25' AND b.title = 'Book_10';