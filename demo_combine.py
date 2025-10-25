import pyodbc
from pymongo import MongoClient

# --- Connect to SQL Server ---
sql_conn = pyodbc.connect(
    "DRIVER={SQL Server};SERVER=localhost\\SQLEXPRESS;DATABASE=TimeAttendance;Trusted_Connection=yes;"
)
cursor = sql_conn.cursor()

# Create a dictionary for quick lookup of employee salary info
cursor.execute("SELECT EmployeeCode, FullName, GrossPay, NetPay FROM Payroll p JOIN Employees e ON p.EmployeeId = e.EmployeeId")
employee_salary = {row.EmployeeCode: {"FullName": row.FullName, "GrossPay": row.GrossPay, "NetPay": row.NetPay} for row in cursor.fetchall()}

# --- Connect to MongoDB ---
mongo_client = MongoClient("mongodb://localhost:27017/")
mongo_db = mongo_client["TimeAttendanceDB"]

# Mapping deviceId to EmployeeCode
device_map = {"FP01": "E001", "FP02": "E002"}

print("=== MongoDB Fingerprint Logs (with Employee and Salary Info) ===")
for log in mongo_db.fingerprint_scans.find():
    device = log.get("deviceId")
    emp_code = device_map.get(device)
    if emp_code and emp_code in employee_salary:
        emp = employee_salary[emp_code]
        print(f"Employee: {emp['FullName']} ({emp_code}), Device: {device}, Time: {log.get('timestamp')}, GrossPay: {emp['GrossPay']}, NetPay: {emp['NetPay']}")
    else:
        print(f"Unknown employee for device {device}")

print("\nDemo Complete — MongoDB and SQL data linked successfully with salary info.")

