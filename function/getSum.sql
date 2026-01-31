use Northwind;
GO
CREATE FUNCTION dbo.AvgDepartmentValue
(
    @DepartmentName NVARCHAR(100)-- Name of the department to calculate the average salary for
)
RETURNS NUMERIC(10,2)-- Average salary of the specified department
AS
BEGIN
    DECLARE @Value NUMERIC(10,2);

    SELECT @Value = dept_total
    FROM (
        SELECT SUM(e.salary) AS dept_total-- Total salary per department
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id-- Join employees with departments for filtering by department name
        WHERE d.department_name = @DepartmentName
        GROUP BY e.department_id-- Group by department to get total salary per department
    ) AS totals;

    RETURN @Value;
END;
GO