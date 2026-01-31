use Northwind;
GO
CREATE FUNCTION getSallary(@emlpoyee_id INT)
RETURNS TABLE 
AS
RETURN(
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        Salary
    FROM dbo.Employees
    WHERE EmployeeID = @emlpoyee_id
);