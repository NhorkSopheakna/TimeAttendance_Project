session = db.getMongo().startSession();
session.startTransaction();
try {
    session.getDatabase("TimeAttendanceDB").fingerprint_scans.insertOne({
        deviceId: "FP02",
        logType: "INFO",
        message: "Scan success",
        timestamp: new Date()
    });
    session.getDatabase("TimeAttendanceDB").gps_events.insertOne({
        deviceId: "GPS01",
        employeeCode: "E001",
        timestamp: new Date(),
        lat: 10.762622,
        lon: 106.660172,
        speed: 0.5,
        accuracy: 5
    });
    session.commitTransaction();
} catch (e) {
    session.abortTransaction();
}
session.endSession();
