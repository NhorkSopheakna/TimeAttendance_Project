db.fingerprint_scans.insertOne({
    deviceId: "FP01",
    logType: "INFO",
    message: "Fingerprint scan success",
    timestamp: ISODate("2025-09-01T08:15:00Z"),
    extra: { ip: "192.168.1.10", firmwareVersion: "1.2.3", attempts: 1 }
});
