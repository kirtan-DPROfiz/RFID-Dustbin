/*
import 'package:Deprofiz/models/ExportData/log_models.dart';
import 'package:get/get.dart';

class LogController extends GetxController {
  // Observable lists for logs
  var employeeLogs = <EmployeeLog>[].obs;
  var dustbinLogs = <DustbinLog>[].obs;

  // Add employee log
  void addEmployeeLog(EmployeeLog log) {
    employeeLogs.add(log);
  }

  // Add dustbin log
  void addDustbinLog(DustbinLog log) {
    dustbinLogs.add(log);
  }

  // Get all logs (combined)
  List<Map<String, String>> getAllLogs() {
    List<Map<String, String>> allLogs = [];

    // Add employee logs
    for (var log in employeeLogs) {
      allLogs.add({
        "Type": "Employee",
        "Card ID": log.cardId,
        "Employee Name": log.employeeName,
        "Department": log.department,
        "Action": log.action,
        "Updated By": log.updatedBy,
        "Date & Time": log.dateTime.toString(),
      });
    }

    // Add dustbin logs
    for (var log in dustbinLogs) {
      allLogs.add({
        "Type": "Dustbin",
        "Dustbin ID": log.dustbinId,
        "Action": log.action,
        "Updated By": log.updatedBy,
        "Date & Time": log.dateTime.toString(),
      });
    }

    return allLogs;
  }
}
*/
