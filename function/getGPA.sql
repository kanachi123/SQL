USE Northwind;
GO
CREATE FUNCTION dbo.AvgDepartmentValue
(
    @FirstName NVARCHAR(100),
    @LastName  NVARCHAR(100),
    @Email     NVARCHAR(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        students.StudentID,
        students.FirstName,
        students.LastName,
        AVG(grades.Grade) AS GPA
    FROM dbo.Students AS students
    JOIN dbo.Grades   AS grades
        ON students.StudentID = grades.StudentID
    WHERE students.FirstName = @FirstName
      AND students.LastName  = @LastName
      AND students.Email     = @Email
    GROUP BY 
        students.StudentID,
        students.FirstName,
        students.LastName
);
GO
