class EmployeeLog {
  final String cardId;
  final String employeeName;
  final String department;
  final String action; // e.g., "Updated" or "Deleted"
  final String updatedBy; // e.g., "Admin" or "Super Admin"
  final DateTime dateTime;

  EmployeeLog({
    required this.cardId,
    required this.employeeName,
    required this.department,
    required this.action,
    required this.updatedBy,
    required this.dateTime,
  });
}

class DustbinLog {
  final String dustbinId;
  final String action; // e.g., "Updated" or "Deleted"
  final String updatedBy; // e.g., "Admin" or "Super Admin"
  final DateTime dateTime;

  DustbinLog({
    required this.dustbinId,
    required this.action,
    required this.updatedBy,
    required this.dateTime,
  });
}
