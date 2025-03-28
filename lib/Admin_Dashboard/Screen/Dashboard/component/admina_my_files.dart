import 'package:Deprofiz/constants.dart';
import 'package:Deprofiz/controllers/audit_controller.dart';
import 'package:Deprofiz/controllers/dustbin_controller.dart';
import 'package:Deprofiz/controllers/employee_controller.dart';
import 'package:Deprofiz/controllers/logs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCloudStorageInfo {
  final String? svgSrc, title, total;
  final int? numrs, percentage;
  final Color? color;

  AdminCloudStorageInfo({
    this.svgSrc,
    this.title,
    this.total,
    this.numrs,
    this.percentage,
    this.color,
  });
}

final EmployeeController employeeController = Get.put(EmployeeController());
final DustbinController dustbinController = Get.put(DustbinController());
/*final LogsController logsController = Get.put(LogsController());
final AuditController auditController = Get.put(AuditController());*/

List admindemoMyFiles = [
  AdminCloudStorageInfo(
    title: "Employees",
    numrs: employeeController.employeeCount.value,
    svgSrc: "assets/icons/Documents.svg",
    total: employeeController.employeeCount.toString(),
    color: primaryColor,
    percentage: (employeeController.employeeCount.value / 100 * 100).toInt(),
  ),
  AdminCloudStorageInfo(
    title: "Dustbins",
    numrs: dustbinController.dustbinCount.value,
    svgSrc: "assets/icons/menu_store.svg",
    total: dustbinController.dustbinCount.toString(),//dustbinController.dustbinCount.toString(),
    color: Color(0xFFFFA113),
    percentage: (dustbinController.dustbinCount.value / 50 * 100)
        .toInt(), // Assuming 50 is the max capacity for percentage calculation
  ),
 /* AdminCloudStorageInfo(
    title: "Logs",
    numrs: logsController.allLogsCount.value, // logsController.logs.length,
    svgSrc: "assets/icons/menu_notification.svg",
    total: logsController.allLogsCount.toString(),
    color: Color(0xFFA4CDFF),
    percentage:(logsController.allLogsCount.value / 100 * 100).toInt(),
  ),
  AdminCloudStorageInfo(
    title: "Audit",
    numrs: auditController.auditListCount.value,
    svgSrc: "assets/icons/menu_doc.svg",
    total: auditController.auditListCount.toString(),
    color: Color(0xFF007EE5),
    percentage: (auditController.auditListCount.value / 1500 * 100).toInt(),
  )*/
];