CREATE TRIGGER trg_CalculateWorkHours
ON Attendance
AFTER INSERT
AS
BEGIN
    UPDATE Attendance
    SET WorkHours = DATEDIFF(MINUTE, i.ClockIn, i.ClockOut) / 60.0
    FROM Attendance a
    INNER JOIN inserted i ON a.AttendanceId = i.AttendanceId;
END;
