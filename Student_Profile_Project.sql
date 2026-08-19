/* =====================================================
   STUDENT PROFILE MANAGEMENT SYSTEM
   Database: SQL Server
   ===================================================== */


/* =====================================================
   1. CREATE DATABASE
   ===================================================== */

IF DB_ID('StudentProfileDB') IS NULL
BEGIN
    CREATE DATABASE StudentProfileDB;
END
GO


USE StudentProfileDB;
GO


/* =====================================================
   2. DELETE OLD TABLES IF THEY EXIST
   ===================================================== */

IF OBJECT_ID('StudentSkills', 'U') IS NOT NULL
    DROP TABLE StudentSkills;

IF OBJECT_ID('Skills', 'U') IS NOT NULL
    DROP TABLE Skills;

IF OBJECT_ID('StudentMarks', 'U') IS NOT NULL
    DROP TABLE StudentMarks;

IF OBJECT_ID('Courses', 'U') IS NOT NULL
    DROP TABLE Courses;

IF OBJECT_ID('Students', 'U') IS NOT NULL
    DROP TABLE Students;
GO


/* =====================================================
   3. STUDENTS TABLE
   ===================================================== */

CREATE TABLE Students
(
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    Department VARCHAR(50),
    YearOfStudy INT,
    CGPA DECIMAL(4,2),
    City VARCHAR(50)
);
GO


/* =====================================================
   4. COURSES TABLE
   ===================================================== */

CREATE TABLE Courses
(
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL
);
GO


/* =====================================================
   5. STUDENT MARKS TABLE
   ===================================================== */

CREATE TABLE StudentMarks
(
    MarkID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Marks INT,

    FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID),

    FOREIGN KEY (CourseID)
        REFERENCES Courses(CourseID)
);
GO


/* =====================================================
   6. SKILLS TABLE
   ===================================================== */

CREATE TABLE Skills
(
    SkillID INT PRIMARY KEY,
    SkillName VARCHAR(50) NOT NULL
);
GO


/* =====================================================
   7. STUDENT SKILLS TABLE
   ===================================================== */

CREATE TABLE StudentSkills
(
    StudentID INT,
    SkillID INT,
    SkillLevel VARCHAR(20),

    PRIMARY KEY (StudentID, SkillID),

    FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID),

    FOREIGN KEY (SkillID)
        REFERENCES Skills(SkillID)
);
GO


/* =====================================================
   8. INSERT STUDENT DATA
   ===================================================== */

INSERT INTO Students
(
    StudentID,
    StudentName,
    Email,
    Phone,
    DateOfBirth,
    Gender,
    Department,
    YearOfStudy,
    CGPA,
    City
)
VALUES
(101, 'Yeshwanth', 'yeshwanth@gmail.com',
 '9876543210', '2006-05-15',
 'Male', 'CSE', 2, 8.50, 'Anantapur'),

(102, 'Rahul', 'rahul@gmail.com',
 '9876543211', '2005-08-20',
 'Male', 'CSE', 3, 8.20, 'Bangalore'),

(103, 'Priya', 'priya@gmail.com',
 '9876543212', '2006-02-10',
 'Female', 'DS', 2, 9.10, 'Tirupati'),

(104, 'Manogna', 'manogna@gmail.com',
 '9876543213', '2006-11-25',
 'Female', 'CSE', 2, 8.60, 'Kadapa'),

(105, 'Arjun', 'arjun@gmail.com',
 '9876543214', '2005-07-12',
 'Male', 'ECE', 3, 7.90, 'Chennai');
GO


/* =====================================================
   9. INSERT COURSE DATA
   ===================================================== */

INSERT INTO Courses
(
    CourseID,
    CourseName,
    Credits
)
VALUES
(1, 'Database Management System', 4),
(2, 'Data Structures', 4),
(3, 'Java Programming', 3),
(4, 'Python Programming', 3),
(5, 'Computer Networks', 4);
GO


/* =====================================================
   10. INSERT MARKS
   ===================================================== */

INSERT INTO StudentMarks
(
    MarkID,
    StudentID,
    CourseID,
    Marks
)
VALUES
(1, 101, 1, 85),
(2, 101, 2, 90),
(3, 101, 3, 88),

(4, 102, 1, 78),
(5, 102, 2, 82),
(6, 102, 3, 80),

(7, 103, 1, 95),
(8, 103, 2, 92),
(9, 103, 4, 94),

(10, 104, 1, 87),
(11, 104, 2, 89),
(12, 104, 3, 91),

(13, 105, 1, 75),
(14, 105, 5, 79);
GO


/* =====================================================
   11. INSERT SKILLS
   ===================================================== */

INSERT INTO Skills
(
    SkillID,
    SkillName
)
VALUES
(1, 'Java'),
(2, 'Python'),
(3, 'SQL'),
(4, 'HTML'),
(5, 'CSS'),
(6, 'JavaScript'),
(7, 'Data Structures'),
(8, 'Machine Learning');
GO


/* =====================================================
   12. INSERT STUDENT SKILLS
   ===================================================== */

INSERT INTO StudentSkills
(
    StudentID,
    SkillID,
    SkillLevel
)
VALUES
(101, 1, 'Intermediate'),
(101, 3, 'Advanced'),
(101, 7, 'Intermediate'),

(102, 1, 'Advanced'),
(102, 2, 'Intermediate'),
(102, 3, 'Intermediate'),

(103, 2, 'Advanced'),
(103, 3, 'Advanced'),
(103, 8, 'Intermediate'),

(104, 1, 'Intermediate'),
(104, 3, 'Advanced'),
(104, 4, 'Intermediate'),

(105, 2, 'Intermediate'),
(105, 5, 'Advanced');
GO


/* =====================================================
   13. BASIC QUERIES
   ===================================================== */


/* Display all students */

SELECT *
FROM Students;


/* Display student names and CGPA */

SELECT
    StudentID,
    StudentName,
    Department,
    CGPA
FROM Students;


/* Students with CGPA greater than 8.5 */

SELECT *
FROM Students
WHERE CGPA > 8.5;


/* CSE students */

SELECT *
FROM Students
WHERE Department = 'CSE';


/* Students sorted by CGPA */

SELECT *
FROM Students
ORDER BY CGPA DESC;


/* =====================================================
   14. JOIN QUERY
   ===================================================== */


/* Student marks with course names */

SELECT
    S.StudentName,
    C.CourseName,
    SM.Marks
FROM StudentMarks SM

INNER JOIN Students S
    ON SM.StudentID = S.StudentID

INNER JOIN Courses C
    ON SM.CourseID = C.CourseID

ORDER BY S.StudentName;
GO


/* =====================================================
   15. STUDENT SKILLS
   ===================================================== */

SELECT
    S.StudentName,
    SK.SkillName,
    SS.SkillLevel

FROM StudentSkills SS

INNER JOIN Students S
    ON SS.StudentID = S.StudentID

INNER JOIN Skills SK
    ON SS.SkillID = SK.SkillID

ORDER BY S.StudentName;
GO


/* =====================================================
   16. AVERAGE MARKS
   ===================================================== */

SELECT
    S.StudentName,
    AVG(SM.Marks) AS AverageMarks

FROM Students S

INNER JOIN StudentMarks SM
    ON S.StudentID = SM.StudentID

GROUP BY
    S.StudentName;
GO


/* =====================================================
   17. HIGHEST MARK
   ===================================================== */

SELECT TOP 1

    S.StudentName,
    C.CourseName,
    SM.Marks

FROM StudentMarks SM

INNER JOIN Students S
    ON SM.StudentID = S.StudentID

INNER JOIN Courses C
    ON SM.CourseID = C.CourseID

ORDER BY SM.Marks DESC;
GO


/* =====================================================
   18. DEPARTMENT-WISE STUDENT COUNT
   ===================================================== */

SELECT
    Department,
    COUNT(*) AS TotalStudents

FROM Students

GROUP BY Department;
GO


/* =====================================================
   19. TOP STUDENTS
   ===================================================== */

SELECT
    StudentID,
    StudentName,
    Department,
    CGPA

FROM Students

WHERE CGPA >= 8.5

ORDER BY CGPA DESC;
GO


/* =====================================================
   20. CREATE VIEW
   ===================================================== */

IF OBJECT_ID('StudentProfileView', 'V') IS NOT NULL
    DROP VIEW StudentProfileView;
GO

CREATE VIEW StudentProfileView
AS

SELECT
    StudentID,
    StudentName,
    Email,
    Phone,
    Department,
    YearOfStudy,
    CGPA,
    City

FROM Students;
GO


/* Display View */

SELECT *
FROM StudentProfileView;
GO


/* =====================================================
   21. STORED PROCEDURE
   ===================================================== */

IF OBJECT_ID('GetStudentProfile', 'P') IS NOT NULL
    DROP PROCEDURE GetStudentProfile;
GO

CREATE PROCEDURE GetStudentProfile
    @StudentID INT
AS
BEGIN

    SELECT
        StudentID,
        StudentName,
        Email,
        Phone,
        DateOfBirth,
        Gender,
        Department,
        YearOfStudy,
        CGPA,
        City

    FROM Students

    WHERE StudentID = @StudentID;

END
GO


/* Execute Procedure */

EXEC GetStudentProfile 101;
GO


/* =====================================================
   22. UPDATE STUDENT
   ===================================================== */

UPDATE Students

SET CGPA = 8.75

WHERE StudentID = 101;
GO


/* Check updated student */

SELECT *
FROM Students
WHERE StudentID = 101;
GO


/* =====================================================
   23. FINAL STUDENT PROFILE
   ===================================================== */

SELECT

    S.StudentID,
    S.StudentName,
    S.Email,
    S.Phone,
    S.Department,
    S.YearOfStudy,
    S.CGPA,
    S.City,
    COUNT(SS.SkillID) AS NumberOfSkills

FROM Students S

LEFT JOIN StudentSkills SS
    ON S.StudentID = SS.StudentID

GROUP BY

    S.StudentID,
    S.StudentName,
    S.Email,
    S.Phone,
    S.Department,
    S.YearOfStudy,
    S.CGPA,
    S.City

ORDER BY S.CGPA DESC;
GO