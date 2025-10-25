-- ==============================================
-- PURPOSE: SQL version of MongoDB Aggregation (for report visualization)
-- DATABASE: TimeAttendance


USE TimeAttendance;
GO
-- 1️⃣ Create a demo table to simulate fingerprint logs
IF OBJECT_ID('FingerprintLogs', 'U') IS NOT NULL
    DROP TABLE FingerprintLogs;
GO

CREATE TABLE FingerprintLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    DeviceID NVARCHAR(20),
    LogType NVARCHAR(20),
    Message NVARCHAR(200),
    Timestamp DATETIME
);
GO

-- 2️ Insert sample data (similar to your MongoDB data)
INSERT INTO FingerprintLogs (DeviceID, LogType, Message, Timestamp)
VALUES 
('FP01', 'INFO', 'Fingerprint scan success', '2025-09-01T08:15:00'),
('FP01', 'INFO', 'Fingerprint scan success', '2025-09-01T09:00:00'),
('FP01', 'ERROR', 'Scan failed - no match found', '2025-09-01T08:10:00'),
('FP02', 'INFO', 'Fingerprint scan success', '2025-09-01T08:30:00'),
('FP02', 'INFO', 'Fingerprint scan success', '2025-09-01T08:45:00');
GO

-- 3️ Aggregate results (to match MongoDB $group + $sort)
SELECT 
    CONVERT(date, Timestamp) AS [Date],
    LogType,
    COUNT(*) AS TotalScans
FROM FingerprintLogs
GROUP BY CONVERT(date, Timestamp), LogType
ORDER BY [Date];
GO

