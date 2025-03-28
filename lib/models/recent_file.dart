// class RecentFile {
//   final String? icon, title, date, size;
//
//   RecentFile({this.icon, this.title, this.date, this.size});
// }
//
// List demoRecentFiles = [
//   RecentFile(
//     icon: "assets/icons/xd_file.svg",
//     title: "XD File",
//     date: "01-03-2021",
//     size: "3.5mb",
//   ),
//   RecentFile(
//     icon: "assets/icons/Figma_file.svg",
//     title: "Figma File",
//     date: "27-02-2021",
//     size: "19.0mb",
//   ),
//   RecentFile(
//     icon: "assets/icons/doc_file.svg",
//     title: "Document",
//     date: "23-02-2021",
//     size: "32.5mb",
//   ),
//   RecentFile(
//     icon: "assets/icons/sound_file.svg",
//     title: "Sound File",
//     date: "21-02-2021",
//     size: "3.5mb",
//   ),
//   RecentFile(
//     icon: "assets/icons/media_file.svg",
//     title: "Media File",
//     date: "23-02-2021",
//     size: "2.5gb",
//   ),
//   RecentFile(
//     icon: "assets/icons/pdf_file.svg",
//     title: "Sales PDF",
//     date: "25-02-2021",
//     size: "3.5mb",
//   ),
//   RecentFile(
//     icon: "assets/icons/excel_file.svg",
//     title: "Excel File",
//     date: "25-02-2021",
//     size: "34.5mb",
//   ),
// ];

import 'package:Deprofiz/controllers/employee_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import the intl package

class RecentLog {
  final String EmployeeName;
  //final String cardId;
  final String dustbinId;
  final DateTime date;

  RecentLog({
    //required this.cardId,
    required this.dustbinId,
    required this.EmployeeName,
    required this.date,
  });

  // Method to format the date
  String getFormattedDate() {
    return DateFormat('dd-MM-yyyy').format(this.date);
  }
}

final EmployeeController employeeController = Get.put(EmployeeController());
List<RecentLog> demoRecentLogs = [
  RecentLog(
    EmployeeName: employeeController.employeeCount.string,
    // cardId: "C12345",
    dustbinId: "D001",
    date: DateTime(2024, 12, 1),
  ),
  RecentLog(
    EmployeeName: employeeController.employeeCount.string,
    //cardId: "C12346",
    dustbinId: "D002",
    date: DateTime(2024, 12, 2),
  ),
  RecentLog(
    EmployeeName: employeeController.employeeCount.string, //cardId: "C12347",
    dustbinId: "D003",
    date: DateTime(2024, 12, 3),
  ),
  RecentLog(
    EmployeeName: employeeController.employeeCount.string, //cardId: "C12348",
    dustbinId: "D004",
    date: DateTime(2024, 12, 4),
  ),
  RecentLog(
    EmployeeName: employeeController.employeeCount.string, //cardId: "C12349",
    dustbinId: "D005",
    date: DateTime(2024, 12, 5),
  ),
  RecentLog(
    EmployeeName: employeeController.employeeCount.string, //cardId: "C12350",
    dustbinId: "D006",
    date: DateTime(2024, 12, 6),
  ),
  RecentLog(
    EmployeeName: employeeController.employeeCount.string, //cardId: "C12351",
    dustbinId: "D007",
    date: DateTime(2024, 12, 7),
  ),
];
