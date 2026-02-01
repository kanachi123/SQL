CREATE FUNCTION dbo.GetStudentBestGradeByPeriod
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
        CONCAT(s.FirstName, ' ', s.LastName) AS FullName,
        s.Email,
        g.Semester,
        g.Year,
        MAX(g.Grade) AS BestGrade
    FROM dbo.Students AS s
    JOIN dbo.Grades   AS g
        ON s.StudentID = g.StudentID
    WHERE s.FirstName = @FirstName
      AND s.LastName  = @LastName
      AND s.Email     = @Email
    GROUP BY
        s.FirstName,
        s.LastName,
        s.Email,
        g.Semester,
        g.Year
);
