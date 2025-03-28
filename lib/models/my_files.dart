import 'package:Deprofiz/constants.dart';
import 'package:Deprofiz/controllers/audit_controller.dart';
import 'package:Deprofiz/controllers/dustbin_controller.dart';
import 'package:Deprofiz/controllers/employee_controller.dart';
import 'package:Deprofiz/controllers/logs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CloudStorageInfo {
  final String? svgSrc, title, total;
  final int? numrs, percentage;
  final Color? color;

  CloudStorageInfo({
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
final LogsController logsController = Get.put(LogsController());
final AuditController auditController = Get.put(AuditController());

List demoMyFiles = [
  CloudStorageInfo(
    title: "Employees",
    numrs: employeeController.employeeCount.value,
    svgSrc: "assets/icons/Documents.svg",
    total: employeeController.employeeCount.toString(),
    color: primaryColor,
    percentage: (employeeController.employeeCount.value / 100 * 100).toInt(),
  ),
  CloudStorageInfo(
    title: "Dustbins",
    numrs: dustbinController.dustbinCount.value,
    svgSrc: "assets/icons/menu_store.svg",
    total: dustbinController.dustbinCount.toString(),//dustbinController.dustbinCount.toString(),
    color: Color(0xFFFFA113),
    percentage: (dustbinController.dustbinCount.value / 50 * 100)
        .toInt(), // Assuming 50 is the max capacity for percentage calculation
  ),
  CloudStorageInfo(
    title: "Logs",
    numrs: logsController.allLogsCount.value, // logsController.logs.length,
    svgSrc: "assets/icons/menu_notification.svg",
    total: logsController.allLogsCount.toString(),
    color: Color(0xFFA4CDFF),
    percentage:(logsController.allLogsCount.value / 100 * 100).toInt(),
  ),
  CloudStorageInfo(
    title: "Audit",
    numrs: auditController.auditListCount.value,
    svgSrc: "assets/icons/menu_doc.svg",
    total: auditController.auditListCount.toString(),
    color: Color(0xFF007EE5),
    percentage: (auditController.auditListCount.value / 1500 * 100).toInt(),
  ),
];

/*

import 'package:Deprofiz/controllers/storage_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CloudStorageInfo {
  final String? svgSrc, title, total;
  final int? numrs, percentage;
  //final double? percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.total,
    this.numrs,
    this.percentage,
    this.color,
  });
}

List<CloudStorageInfo> demoMyFiles = [
  CloudStorageInfo(
    title: "Employees",
    svgSrc: "assets/icons/Documents.svg",
    color: Colors.blue,
    numrs: null, // <-- This is a potential cause
    percentage: null,
  ),
  CloudStorageInfo(
    title: "Dustbins",
    svgSrc: "assets/icons/Documents.svg",
    color: Colors.yellowAccent,
    numrs: null, // <-- This is a potential cause
    percentage: null,
  ),
  CloudStorageInfo(
    title: "Logs",
    svgSrc: "assets/icons/Documents.svg",
    color: Colors.black,
    numrs: null, // <-- This is a potential cause
    percentage: null,
  ),
  CloudStorageInfo(
    title: "Audit",
    svgSrc: "assets/icons/Documents.svg",
    color: Colors.purpleAccent,
    numrs: null, // <-- This is a potential cause
    percentage: null,
  ),
];

class StorageInfoCard extends StatelessWidget {
  final StorageController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Card(
        child: ListTile(
          leading: Icon(Icons.people, color: Colors.blue),
          title: Text("Employees"),
          subtitle: Text("Total: ${controller.totalEmployees}"),
          trailing: Text(
            "${controller.employeePercentage.toStringAsFixed(1)}%",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      );
    });
  }
}
*/
