-- 1. List all databases (to show TimeAttendance exists)
SELECT name AS DatabaseName 
FROM sys.databases
WHERE name = 'TimeAttendance';
GO


--2 Insert sample data
-- Departments
INSERT INTO Departments (DepartmentName)
VALUES ('HR'), ('IT'), ('Finance');

-- Employees
INSERT INTO Employees (EmployeeCode, FullName, DepartmentId, HireDate, BaseSalary)
VALUES
('E001','Alice Nguyen',1,'2024-05-01',1000),
('E002','Bob Tran',2,'2024-06-15',1200);

-- Shifts
INSERT INTO Shifts (ShiftName, StartTime, EndTime, GraceMinutes)
VALUES
('Morning','08:00','17:00',15);

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';


-- Show sample data
SELECT * FROM Employees;

-- Trigger test
-- Insert attendance with clock-in/out times
INSERT INTO Attendance (EmployeeId, WorkDate, ClockIn, ClockOut, ShiftId)
VALUES
(1, '2025-09-28', '2025-09-28 08:05', '2025-09-28 17:05', 1),
(2, '2025-09-28', '2025-09-28 08:15', '2025-09-28 16:45', 1);

-- View result to verify WorkHours was calculated by the trigger
SELECT AttendanceId, EmployeeId, WorkDate,
       ClockIn, ClockOut, WorkHours
FROM Attendance;



-- Payroll procedure test
-- Calculate payroll for September 2025
EXEC sp_CalculateSalary @Month = 9, @Year = 2025;
GO

-- View Payroll results
SELECT p.PayrollId, e.FullName, p.PayrollMonth,
       p.GrossPay, p.NetPay, p.CalculatedAt
FROM Payroll p
JOIN Employees e ON p.EmployeeId = e.EmployeeId;



