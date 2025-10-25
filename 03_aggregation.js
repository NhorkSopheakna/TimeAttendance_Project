db.fingerprint_scans.aggregate([
  { $match: { logType: "INFO" } },
  { $group: {
      _id: { date: { $dateToString: { format: "%Y-%m-%d", date: "$timestamp" } } },
      total_scans: { $sum: 1 }
    }
  },
  { $sort: { "_id.date": 1 } }
]);
