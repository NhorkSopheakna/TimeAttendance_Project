CREATE PROCEDURE sp_CalculateSalary
    @Month INT,
    @Year INT
AS
BEGIN
    INSERT INTO Payroll(EmployeeId, PayrollMonth, GrossPay, NetPay)
    SELECT e.EmployeeId,
           DATEFROMPARTS(@Year, @Month, 1),
           SUM(a.WorkHours) * e.BaseSalary / 22 / 8,
           SUM(a.WorkHours) * e.BaseSalary / 22 / 8
    FROM Employees e
    JOIN Attendance a ON e.EmployeeId = a.EmployeeId
    WHERE MONTH(a.WorkDate) = @Month AND YEAR(a.WorkDate) = @Year
    GROUP BY e.EmployeeId, e.BaseSalary;
END;
