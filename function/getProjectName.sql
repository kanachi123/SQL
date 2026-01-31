USE Northwind;
GO

CREATE FUNCTION dbo.getProjectName(@uid INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
        p.ProjectID,
        p.ProjectName,
        p.Status,
        ep.Role,
        ep.HoursWorked
    FROM dbo.Projects p
    JOIN dbo.EmployeesProjects ep 
        ON p.ProjectID = ep.ProjectID
    WHERE ep.UserID = @uid
);
GO
