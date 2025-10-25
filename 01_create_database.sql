CREATE DATABASE TimeAttendance;
GO
USE TimeAttendance;
GO

-- Departments
CREATE TABLE Departments (
    DepartmentId INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL
);

-- Employees
CREATE TABLE Employees (
    EmployeeId INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeCode NVARCHAR(20) UNIQUE NOT NULL,
    FullName NVARCHAR(200) NOT NULL,
    DepartmentId INT FOREIGN KEY REFERENCES Departments(DepartmentId),
    HireDate DATE NOT NULL,
    BaseSalary DECIMAL(18,2) NOT NULL,
    IsActive BIT DEFAULT 1
);

-- Shifts
CREATE TABLE Shifts (
    ShiftId INT IDENTITY(1,1) PRIMARY KEY,
    ShiftName NVARCHAR(100),
    StartTime TIME,
    EndTime TIME,
    GraceMinutes INT DEFAULT 15
);

-- Attendance
CREATE TABLE Attendance (
    AttendanceId BIGINT IDENTITY(1,1) PRIMARY KEY,
    EmployeeId INT FOREIGN KEY REFERENCES Employees(EmployeeId),
    WorkDate DATE,
    ClockIn DATETIME,
    ClockOut DATETIME,
    ShiftId INT FOREIGN KEY REFERENCES Shifts(ShiftId),
    WorkHours DECIMAL(5,2),
    IsProcessed BIT DEFAULT 0
);

-- Payroll
CREATE TABLE Payroll (
    PayrollId BIGINT IDENTITY(1,1) PRIMARY KEY,
    EmployeeId INT FOREIGN KEY REFERENCES Employees(EmployeeId),
    PayrollMonth DATE,
    GrossPay DECIMAL(18,2),
    NetPay DECIMAL(18,2),
    CalculatedAt DATETIME DEFAULT GETDATE()
);
