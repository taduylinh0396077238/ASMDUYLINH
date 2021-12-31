CREATE DATABASE Exp6-1
GO
USE Exp6-1
GO
CREATE TABLE CLASS(
	ClassID INT IDENTITY PRIMARY KEY,
	ClassName NVARCHAR(200) NOT NULL

)
GO
CREATE TABLE Students(
		StudentID INT PRIMARY KEY,
		StudentName NVARCHAR(200),
		Class_CurrentID INT FOREIGN KEY REFERENCES dbo.CLASS(ClassID)
)
GO 
CREATE TABLE Inf_Class(
		StudentID INT FOREIGN KEY REFERENCES dbo.Students(StudentID),
		ClassID INT FOREIGN KEY REFERENCES dbo.CLASS(ClassID),
		Status INT NOT NULL,
		Admission DATE NOT NULL,
		Finish DATE DEFAULT(NULL)
)
GO
CREATE TABLE Subjects(
	SubjectID INT PRIMARY KEY,
	SubjectName NVARCHAR(100) NOT NULL
)
GO
CREATE TABLE Inf_Subject(
	StudentID INT FOREIGN KEY REFERENCES dbo.Students(StudentID),
	SubjectID INT FOREIGN KEY REFERENCES dbo.Subjects(SubjectID),
	Admission DATE NOT NULL,
	Finish DATE DEFAULT(NULL),
	Status INT NOT NULL

)
GO 
INSERT INTO dbo.CLASS
(
    ClassID,
    ClassName
)
VALUES
(   0,  -- ClassID - int
    N'T2109M' -- ClassName - nvarchar(200)
    ),
(   1,  -- ClassID - int
    N'T2108M' -- ClassName - nvarchar(200)
    ),
(   2,  -- ClassID - int
    N'T21010M' -- ClassName - nvarchar(200)
    )
INSERT INTO dbo.Students
(
    StudentID,
    StudentName,
    Class_CurrentID
)
VALUES
(   0,    -- StudentID - int
    N'Tạ Duy Linh ', -- StudentName - nvarchar(200)
    0-- Class_CurrentID - int
    ),
(   1,    -- StudentID - int
    N'Vũ Viết Qúy ', -- StudentName - nvarchar(200)
    1  -- Class_CurrentID - int
    ),
(   2,    -- StudentID - int
    N'Đinh Quang Anh ', -- StudentName - nvarchar(200)
    2  -- Class_CurrentID - int
    )

INSERT INTO dbo.Inf_Class
(
    StudentID,
    ClassID,
    Status,
    Admission,
    Finish
)
VALUES
(   0,      -- StudentID - int
    0,      -- ClassID - int
    0,         -- Status - int
    '2109010', -- Admission - date
    NULL    -- Finish - date
    ),
(   1,      -- StudentID - int
    1,      -- ClassID - int
    0,         -- Status - int
    '2109011', -- Admission - date
    NULL    -- Finish - date
    ),
(   2,      -- StudentID - int
    2,      -- ClassID - int
    0,         -- Status - int
    '2109012', -- Admission - date
    NULL   -- Finish - date
    )
INSERT INTO dbo.Subjects
(
    SubjectName
)
VALUES
(N'C/C++' -- SubjectName - nvarchar(500)
    ),
(N'HTML' -- SubjectName - nvarchar(500)
    ),
(N'JS' -- SubjectName - nvarchar(500)
    ),
(N'SQL' -- SubjectName - nvarchar(500)
    )
INSERT INTO dbo.Inf_Subject
(
    StudentID,
    SubjectID,
    Admission,
    Finish,
    Status
)
VALUES
(   0,      -- StudentID - int
    1,      -- SubjectID - int
    '20211230', -- Admission - date
    '20210101',   -- Finish - date
    0          -- Status - int
    ),
(   0,      -- StudentID - int
    2,      -- SubjectID - int
    '20211230', -- Admission - date
    '20220101',   -- Finish - date
    0          -- Status - int
    ),
(   0,      -- StudentID - int
    3,      -- SubjectID - int
    '20220101', -- Admission - date
    '20220102',   -- Finish - date
    0          -- Status - int
    ),
(   0,      -- StudentID - int
    4,      -- SubjectID - int
    '20220103', -- Admission - date
    '20220109',   -- Finish - date
    0          -- Status - int
    )

SELECT*FROM dbo.CLASS
SELECT*FROM dbo.Students
SELECT*FROM dbo.Inf_Class
SELECT*FROM dbo.Subjects
SELECT*FROM dbo.Inf_Subject
-- TRuy Vấn 
--Truy vấn môn học 
SELECT *FROM dbo.Students
SELECT * FROM dbo.Subjects
SELECT * FROM dbo.Inf_Subject
SELECT dbo.Students.StudentName,Subjects.SubjectName,Inf_Subject.Status
FROM dbo.Inf_Subject
JOIN dbo.Students
ON Students.StudentID = Inf_Subject.StudentID
JOIN Subjects
ON Subjects.SubjectID = Inf_Subject.SubjectID
WHERE Subjects.SubjectName LIKE 'HTML%'
	--Truy vấn lớp học
SELECT dbo.Students.StudentName,Class.ClassName
FROM dbo.Students
JOIN dbo.Class 
ON Class.ClassId = dbo.Students.Class_CurrentID
WHERE Class.ClassName LIKE 'T%'