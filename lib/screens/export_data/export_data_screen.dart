/*
import 'dart:developer';

import 'package:Deprofiz/screens/export_data/Screen/dustbin_wise_screen.dart';
import 'package:Deprofiz/screens/export_data/Screen/employee_wise_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/api_models/export_alllogs_list_in_obj.dart';
import '../../network manager/rest_client.dart';

class ExportDataScreen extends StatefulWidget {
  @override
  _ExportDataScreenState createState() => _ExportDataScreenState();
}

class _ExportDataScreenState extends State<ExportDataScreen> {
  String selectedHeader = "All Logs"; // Default selected header
  List<ExportAllLogsListInObj> exportAllLogsListInObj = [];
  bool isLoading = true;
  String errorMessage = " ";

  @override
  void initState() {
    super.initState();
    if (selectedHeader == "All Logs") {
      AllLogList(); // Fetch data on screen load
    }
  }

  void AllLogList() {
    print("➡️ [START] userList: Fetching employee data...");

    RestClient.getAllLogsListInObj().then((value) {
      log("✅ API Response: $value");
      print("✅ API Response: $value");

      // Step 1: Check if the response is null or empty
      if (value == null) {
        log("⚠️ Warning: API returned null or an empty list.");
        print("⚠️ Warning: API returned null or an empty list.");

        setState(() {
          errorMessage = "No data found.";
          isLoading = false;
        });
      } else {
        // Step 2: Log the number of items returned
        log("📊 API returned data: ${value} items");

        // Step 3: Update the state with the fetched data
        setState(() {
          exportAllLogsListInObj = value; // Directly assign the list
          isLoading = false;
        });
      }
    }).catchError((error) {
      // Step 4: Log any errors encountered
      log("❌ Error fetching API data: $error");
      setState(() {
        errorMessage =
        "Failed to load data. Please check your network or try again.";
        isLoading = false;
      });
    }).whenComplete(() {
      // Step 5: Log the completion of the process
      print("➡️ [END] AccessList: Execution completed.");
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Export Data"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.purpleAccent], // Two-color gradient
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Make button background transparent
                    shadowColor: Colors.transparent, // Remove shadow to keep gradient effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: (){}, // Call the function when button is clicked
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.download, color: Colors.white), // Download icon
                      SizedBox(width: 8), // Space between icon and text
                      Text(
                        "Export",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


        ],

      ),
      body: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildHeader("All Logs"),
              buildHeader("Employee Wise"),
              buildHeader("Dustbin Wise"),
            ],
          ),
          Divider(thickness: 2),
          // Logs List
          Expanded(
            child: buildLogsList(),
          ),
        ],
      ),
    );
  }

  // Build Header Widget
  Widget buildHeader(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedHeader = title;
        });

        if (title == "All Logs") {
          buildAllLogsList(); // Fetch data when "All Logs" is selected
        }
        // Navigate to the respective screen based on the selected header
        // if (title == "Employee Wise") {
        //   Get.to(()=> EmployeeWiseScreen());
        // } else if (title == "Dustbin Wise") {}
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selectedHeader == title ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selectedHeader == title ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Build Logs List
  Widget buildLogsList() {
    if (selectedHeader == "All Logs") {
      return buildAllLogsList();
    } else if (selectedHeader == "Employee Wise") {
      return EmployeeWiseScreen();
    } else if (selectedHeader == "Dustbin Wise") {
      return DustbinWiseScreen();
    } else {
      return Center(
        child: Text(
          "Select a header to view logs",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
  }

  // Build All Logs List
  Widget buildAllLogsList() {
    return Column(
      children: [
        // Fix Header:
        Container(
          color: Colors.grey[300],
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [

              Expanded(
                flex: 2,
                child: Text(
                  "Card ID",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Employee Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Department",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Dustbin ID",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Scan Time",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: exportAllLogsListInObj.length ?? 0,
            itemBuilder: (context, index) {
              final logs = exportAllLogsListInObj[index].scanLogs ?? [];
              return Column(
                children: logs.map((log){
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(flex: 2, child: Text(log.cardId ?? "UNKNOWN")),
                          Expanded(flex: 3, child: Text(log.empName ?? "UNKNOWN")),
                          Expanded(flex: 3, child: Text(log.department ?? "UNKNOWN")),
                          Expanded(flex: 3, child: Text(log.dustbinId ?? "UNKNOWN")),
                          Expanded(flex: 2, child: Text(log.scanTime ?? "UNKNOWN")),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
*/

//-------------new 1 ------------------------//

/*

import 'dart:io';
import 'dart:typed_data';
import 'package:Deprofiz/screens/export_data/Screen/dustbin_wise_screen.dart';
import 'package:Deprofiz/screens/export_data/Screen/employee_wise_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import '../../models/api_models/export_alllogs_list_in_obj.dart';
import '../../network manager/rest_client.dart';

class ExportDataScreen extends StatefulWidget {
  @override
  _ExportDataScreenState createState() => _ExportDataScreenState();
}

class _ExportDataScreenState extends State<ExportDataScreen> {
  String selectedHeader = "All Logs"; // Default selected header
  List<ExportAllLogsListInObj> exportAllLogsListInObj = [];
  bool isLoading = true;
  String errorMessage = " ";

  @override
  void initState() {
    super.initState();
    if (selectedHeader == "All Logs") {
      AllLogList(); // Fetch data on screen load
    }
  }

  void AllLogList() {
    RestClient.getAllLogsListInObj().then((value) {
      if (value == null) {
        setState(() {
          errorMessage = "No data found.";
          isLoading = false;
        });
      } else {
        setState(() {
          exportAllLogsListInObj = value;
          isLoading = false;
        });
      }
    }).catchError((error) {
      setState(() {
        errorMessage = "Failed to load data. Please try again.";
        isLoading = false;
      });
    });
  }

  /// **Function to Generate and Save PDF**
  Future<void> generatePDF() async {
    final pdf = pw.Document();

    List<List<dynamic>> tableData = exportAllLogsListInObj
        .map((obj) => obj.scanLogs?.map((log) => [
      log.cardId ?? "N/A",
      log.empName ?? "N/A",
      log.department ?? "N/A",
      log.dustbinId ?? "N/A",
      log.scanTime ?? "N/A",
    ]).toList() ?? [])
        .expand((element) => element)
        .toList();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text("All Logs Report", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: ["Card ID", "Employee Name", "Department", "Dustbin ID", "Scan Time"],
                data: tableData,
                border: pw.TableBorder.all(),
                cellAlignment: pw.Alignment.center,
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    try {
      final bytes = await pdf.save();

      // Convert the bytes into a Blob
      final blob = html.Blob([bytes], 'application/pdf');

      // Create a download link
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "All_Logs_Report.pdf")
        ..click();

      // Clean up
      html.Url.revokeObjectUrl(url);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("PDF downloaded successfully!")),
      );

      //-------------------App------------------//
      WidgetsFlutterBinding.ensureInitialized(); // Ensures plugins are initialized
      final directory = await getApplicationDocumentsDirectory();
      final file = File("${directory.path}/All_Logs_Report.pdf");
      await file.writeAsBytes(await pdf.save());
      print("PDF saved successfully at ${file.path}");

    } catch (e) {
      print("Error saving PDF: $e");
      print("Failed to save PDF");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save PDF")),
      );
    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Export Data"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.purpleAccent], // Two-color gradient
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Make button background transparent
                    shadowColor: Colors.transparent, // Remove shadow to keep gradient effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: generatePDF, // Call the function when button is clicked
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.download, color: Colors.white), // Download icon
                      SizedBox(width: 8), // Space between icon and text
                      Text(
                        "Export",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildHeader("All Logs"),
              buildHeader("Employee Wise"),
              buildHeader("Dustbin Wise"),
            ],
          ),
          Divider(thickness: 2),
          Expanded(child: buildLogsList()),
        ],
      ),
    );
  }

  Widget buildHeader(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedHeader = title;
        });

        if (title == "All Logs") {
          buildAllLogsList();
        }
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selectedHeader == title ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selectedHeader == title ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildLogsList() {
    if (selectedHeader == "All Logs") {
      return buildAllLogList();
    } else if (selectedHeader == "Employee Wise") {
      return EmployeeWiseScreen();
    } else if (selectedHeader == "Dustbin Wise") {
      return DustbinWiseScreen();
    } else {
      return Center(child: Text("Select a header to view logs"));
    }
  }

  Widget buildAllLogsList(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[300],
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text("Card ID", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 3, child: Text("Employee Name", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 3, child: Text("Department", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 3, child: Text("Dustbin ID", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 2, child: Text("Scan Time", style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: exportAllLogsListInObj.length,
            itemBuilder: (context, index) {
              final logs = exportAllLogsListInObj[index].scanLogs ?? [];
              return Column(
                children: logs.map((log) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(flex: 2, child: Text(log.cardId ?? "UNKNOWN")),
                          Expanded(flex: 3, child: Text(log.empName ?? "UNKNOWN")),
                          Expanded(flex: 3, child: Text(log.department ?? "UNKNOWN")),
                          Expanded(flex: 3, child: Text(log.dustbinId ?? "UNKNOWN")),
                          Expanded(flex: 2, child: Text(log.scanTime ?? "UNKNOWN")),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
*/

//-------------new 2------------------------//
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'dart:developer';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:printing/printing.dart' ;

import '../../models/api_models/export_alllogs_list_in_obj.dart';
import '../../models/api_models/export_dustbin_list_in_obj.dart';
import '../../models/api_models/export_emp_list_in_obj.dart';
import '../../network manager/rest_client.dart';
import '../Footer/footer.dart';
import 'Screen/dustbin_wise_screen.dart';
import 'Screen/employee_wise_Screen.dart';
import 'package:flutter/services.dart' show rootBundle;

class ExportDataScreen extends StatefulWidget {
  @override
  _ExportDataScreenState createState() => _ExportDataScreenState();
}

class _ExportDataScreenState extends State<ExportDataScreen> {
  String selectedHeader = "All Logs";
  List<ExportAllLogsListInObj> exportAllLogsListInObj = [];
  List<ExportDustbinListInObj> exportDustListInObj = [];
  List<ExportEmpListInObj> exportempListInObj = [];

  bool isLoading = true;
  String errorMessage = " ";

  @override
  void initState() {
    super.initState();
    if (selectedHeader == "All Logs") {
      AllLogList();
    }
  }

  void AllLogList() {
    RestClient.getAllLogsListInObj().then((value) {
      log("✅ API Response: $value");
      if (value == null) {
        setState(() {
          errorMessage = "No data found.";
          isLoading = false;
        });
      } else {
        setState(() {
          exportAllLogsListInObj = value;
          isLoading = false;
        });
      }
    }).catchError((error) {
      log("❌ Error fetching API data: $error");
      setState(() {
        errorMessage = "Failed to load data. Please try again.";
        isLoading = false;
      });
    });
  }

/*  Future<void> generatePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
          pw.Text("Exported Data - $selectedHeader", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {
          0: pw.FlexColumnWidth(2),
          1: pw.FlexColumnWidth(3),
          2: pw.FlexColumnWidth(3),
          3: pw.FlexColumnWidth(3),
          4: pw.FlexColumnWidth(2),
          },
          children: [
          pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColors.grey300),
          children: [
          pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Card ID")),
          pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Employee Name")),
          pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Department")),
          pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Dustbin ID")),
          pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Scan Time")),
          ],
          ),
          ...exportAllLogsListInObj.expand((logObj) => logObj.scanLogs?.map((log) => pw.TableRow(
          children: [
          pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.cardId ?? "-")),
          pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.empName ?? "-")),
          pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.department ?? "-")),
          pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.dustbinId ?? "-")),
          pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.scanTime ?? "-")),
          ],
          )) ?? [],
          ),],
          ),
          ],
          );
        },
      ),
    );

    Uint8List pdfBytes = await pdf.save();
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)..setAttribute("download", "Exported_$selectedHeader.pdf");
    anchor.click();
    html.Url.revokeObjectUrl(url);
  }*/
  //------------new -------------------------//
 /* Future<void> generatePdf() async {
    final pdf = pw.Document();

    if (selectedHeader == "All Logs") {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Exported Data - $selectedHeader", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(3),
                    2: pw.FlexColumnWidth(3),
                    3: pw.FlexColumnWidth(3),
                    4: pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Card ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Employee Name")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Department")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Dustbin ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Scan Time")),
                      ],
                    ),
                    ...exportAllLogsListInObj.expand((logObj) => logObj.scanLogs?.map((log) => pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.cardId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.empName ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.department ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.dustbinId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.scanTime ?? "-")),
                      ],
                    )) ?? [],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    } else if (selectedHeader == "Employee Wise") {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Exported Data - $selectedHeader", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Dustbin ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Scan Time")),
                      ],
                    ),
                    ...exportempListInObj.expand((logObj) => logObj.scanLogs?.map((log) => pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.dustbinId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.scanTime ?? "-")),
                      ],
                    )) ?? [],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    } else if (selectedHeader == "Dustbin Wise") {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Exported Data - $selectedHeader", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(3),
                    2: pw.FlexColumnWidth(3),
                    3: pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Card ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Employee Name")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Department")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Scan Time")),
                      ],
                    ),
                    ...exportDustListInObj.expand((logObj) => logObj.scanLogs?.map((log) => pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.cardId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.empName ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.department ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.scanTime ?? "-")),
                      ],
                    )) ?? [],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    }

    Uint8List pdfBytes = await pdf.save();
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)..setAttribute("download", "Exported_$selectedHeader.pdf");
    anchor.click();
    html.Url.revokeObjectUrl(url);
  }

  void downloadPdfWeb(Uint8List pdfData, String fileName) {
    final blob = html.Blob([pdfData]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }*/
  //-------------------------------------------print and logs new code -----------------//


 /* Future<void> generatePdf() async {
    print("Starting PDF generation...");
    final pdf = pw.Document();

    if (selectedHeader == "All Logs") {
      print("Generating PDF for 'All Logs'...");
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Exported Data - $selectedHeader", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(3),
                    2: pw.FlexColumnWidth(3),
                    3: pw.FlexColumnWidth(3),
                    4: pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Card ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Employee Name")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Department")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Dustbin ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Scan Time")),
                      ],
                    ),
                    ...exportAllLogsListInObj.expand((logObj) => logObj.scanLogs?.map((log) => pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.cardId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.empName ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.department ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.dustbinId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.scanTime ?? "-")),
                      ],
                    )) ?? [],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
      print("PDF page for 'All Logs' added.");
    } else if (selectedHeader == "Employee Wise") {
      print("Generating PDF for 'Employee Wise'...");
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Exported Data - $selectedHeader", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Dustbin ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Scan Time")),
                      ],
                    ),
                    ...exportempListInObj.expand((logObj) => logObj.scanLogs?.map((log) => pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.dustbinId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.scanTime ?? "-")),
                      ],
                    )) ?? [],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
      print("PDF page for 'Employee Wise' added.");
    } else if (selectedHeader == "Dustbin Wise") {
      print("Generating PDF for 'Dustbin Wise'...");
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Exported Data - $selectedHeader", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(3),
                    2: pw.FlexColumnWidth(3),
                    3: pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Card ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Employee Name")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Department")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Scan Time")),
                      ],
                    ),
                    ...exportDustListInObj.expand((logObj) => logObj.scanLogs?.map((log) => pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.cardId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.empName ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.department ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.scanTime ?? "-")),
                      ],
                    )) ?? [],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
      print("PDF page for 'Dustbin Wise' added.");
    }

    print("Saving PDF...");
    Uint8List pdfBytes = await pdf.save();
    print("PDF saved successfully.");

    print("Creating Blob and triggering download...");
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)..setAttribute("download", "Exported_$selectedHeader.pdf");
    anchor.click();
    html.Url.revokeObjectUrl(url);
    print("PDF download triggered.");
  }

  void downloadPdfWeb(Uint8List pdfData, String fileName) {
    print("Starting PDF download for file: $fileName");
    final blob = html.Blob([pdfData]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
    print("PDF download completed for file: $fileName");
  }*/
//---------------------------------------------new pdf format -------------------------//

  //----------------image load before generation of pdf --------------------//
  Future<Uint8List> _loadImage() async {
    final ByteData imageData = await rootBundle.load("assets/images/DprofizLogo.png");
    return imageData.buffer.asUint8List();
  }
  //------------------header of the company-----------------------//
  pw.Widget _buildCompanyHeader(Uint8List imageData) {
    return pw.Container(
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Image(
            pw.MemoryImage(imageData), // Use the preloaded image data
            height: 80, // Adjusted size
          ),
          pw.SizedBox(width: 10),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                "Dprofiz.PVT.LTD",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black,
                ),
              ),
              pw.Text(
                "Company Name: ",
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black,
                ),
              ),
              pw.Text(
                "Company Address: ",
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black,
                ),
              ),
              pw.Divider(),
            ],
          ),
        ],
      ),
    );
  }
// -- generating pdf --
  Future<void> generatePdf() async {
    print("Starting PDF generation...");
    final pdf = pw.Document();

    // You can replace this with actual username or get it from your app state
    final String downloadedBy = "Super-Admin";

    // Get current timestamp
    final DateTime now = DateTime.now();
    final String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);


    // Load the image data
    final Uint8List imageData = await _loadImage();

    // Determine ID to show based on selected header
    String idLabel = "";
    String idValue = "";

    if (selectedHeader == "Employee Wise" && exportempListInObj.isNotEmpty) {
      idLabel = "Employee ID";
      idValue =exportDustListInObj.first.scanLogs?.first.cardId ?? "N/A";
    } else if (selectedHeader == "Dustbin Wise" && exportDustListInObj.isNotEmpty) {
      idLabel = "Dustbin ID";
      idValue =  exportempListInObj.first.scanLogs?.first.dustbinId ?? "N/A";
    }


    if (selectedHeader == "All Logs") {
      print("Generating PDF for 'All Logs'...");
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildCompanyHeader(imageData), // Pass the image data
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.SizedBox(height: 10),
                // Add metadata section
                pw.Padding(
                  padding: pw.EdgeInsets.only(top: 10, bottom: 10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Downloaded by: $downloadedBy"),
                      pw.Text("Timestamp: $timestamp"),
                    ],
                  ),
                ),
                pw.Divider(),
                pw.Text("Exported Data - $selectedHeader", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(3),
                    2: pw.FlexColumnWidth(3),
                    3: pw.FlexColumnWidth(3),
                    4: pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Card ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Employee Name")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Department")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Dustbin ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Scan Time")),
                      ],
                    ),
                    ...exportAllLogsListInObj.expand((logObj) => logObj.scanLogs?.map((log) => pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.cardId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.empName ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.department ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.dustbinId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.scanTime ?? "-")),
                      ],
                    )) ?? [],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
      print("PDF page for 'All Logs' added.");
    } else if (selectedHeader == "Employee Wise") {
      print("Generating PDF for 'Employee Wise'...");
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildCompanyHeader(imageData), // Pass the image data
                pw.SizedBox(height: 10),
                pw.Text("Exported Data - $selectedHeader", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Dustbin ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Scan Time")),
                      ],
                    ),
                    ...exportempListInObj.expand((logObj) => logObj.scanLogs?.map((log) => pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.dustbinId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.scanTime ?? "-")),
                      ],
                    )) ?? [],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
      print("PDF page for 'Employee Wise' added.");
    } else if (selectedHeader == "Dustbin Wise") {
      print("Generating PDF for 'Dustbin Wise'...");
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildCompanyHeader(imageData), // Pass the image data
                pw.SizedBox(height: 10),
                pw.Text("Exported Data - $selectedHeader", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(3),
                    2: pw.FlexColumnWidth(3),
                    3: pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Card ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Employee Name")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Department")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Scan Time")),
                      ],
                    ),
                    ...exportDustListInObj.expand((logObj) => logObj.scanLogs?.map((log) => pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.cardId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.empName ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.department ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.scanTime ?? "-")),
                      ],
                    )) ?? [],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
      print("PDF page for 'Dustbin Wise' added.");
    }

    print("Saving PDF...");
    Uint8List pdfBytes = await pdf.save();


    print("PDF saved successfully.");

    print("Creating Blob and triggering download...");
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)..setAttribute("download", "Exported_$selectedHeader.pdf");
    anchor.click();
    html.Url.revokeObjectUrl(url);
    print("PDF download triggered.");
  }

  //-------------------------new------------------------------//

 /* Future<void> generatePdf() async {
    print("Starting PDF generation...");
    final pdf = pw.Document();

    // Load the image from assets
    final image = await rootBundle.load("assets/images/DprofizLogo.png");
    final imageBytes = image.buffer.asUint8List();

    // Function to add header with image and text
    pw.Widget _buildHeader() {
      return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
      pw.Row(
      children: [
      pw.Image(pw.MemoryImage(imageBytes)), // Add the image
      pw.SizedBox(width: 20), // Add some space between image and text
      pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
      pw.Text("Dprofiz.PVT.LTD", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
      pw.Text("Company Name : Your Company Name", style: pw.TextStyle(fontSize: 14)),
      pw.Text("Company Address : Your Company Address", style: pw.TextStyle(fontSize: 14)),
      ],
      ),
       ],
      ),
      pw.SizedBox(height: 10), // Add some space before the divider
      pw.Divider(), // Add a divider
      pw.SizedBox(height: 10), // Add some space after the divider
      ],
      );
    }

    if (selectedHeader == "All Logs") {
      print("Generating PDF for 'All Logs'...");
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildHeader(), // Add the header with image and text
                pw.Text("Exported Data - $selectedHeader", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(3),
                    2: pw.FlexColumnWidth(3),
                    3: pw.FlexColumnWidth(3),
                    4: pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Card ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Employee Name")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Department")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Dustbin ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Scan Time")),
                      ],
                    ),
                    ...exportAllLogsListInObj.expand((logObj) => logObj.scanLogs?.map((log) => pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.cardId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.empName ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.department ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.dustbinId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.scanTime ?? "-")),
                      ],
                    )) ?? [],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
      print("PDF page for 'All Logs' added.");
    } else if (selectedHeader == "Employee Wise") {
      print("Generating PDF for 'Employee Wise'...");
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildHeader(), // Add the header with image and text
                pw.Text("Exported Data - $selectedHeader", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Dustbin ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Scan Time")),
                      ],
                    ),
                    ...exportempListInObj.expand((logObj) => logObj.scanLogs?.map((log) => pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.dustbinId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.scanTime ?? "-")),
                      ],
                    )) ?? [],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
      print("PDF page for 'Employee Wise' added.");
    } else if (selectedHeader == "Dustbin Wise") {
      print("Generating PDF for 'Dustbin Wise'...");
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildHeader(), // Add the header with image and text
                pw.Text("Exported Data - $selectedHeader", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(3),
                    2: pw.FlexColumnWidth(3),
                    3: pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Card ID")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Employee Name")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Department")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text("Scan Time")),
                      ],
                    ),
                    ...exportDustListInObj.expand((logObj) => logObj.scanLogs?.map((log) => pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.cardId ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.empName ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.department ?? "-")),
                        pw.Padding(padding: pw.EdgeInsets.all(8), child: pw.Text(log.scanTime ?? "-")),
                      ],
                    )) ?? [],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
      print("PDF page for 'Dustbin Wise' added.");
    }

    print("Saving PDF...");
    Uint8List pdfBytes = await pdf.save();
    print("PDF saved successfully.");

    print("Creating Blob and triggering download...");
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)..setAttribute("download", "Exported_$selectedHeader.pdf");
    anchor.click();
    html.Url.revokeObjectUrl(url);
    print("PDF download triggered.");
  }

  void downloadPdfWeb(Uint8List pdfData, String fileName) {
    print("Starting PDF download for file: $fileName");
    final blob = html.Blob([pdfData]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
    print("PDF download completed for file: $fileName");
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Export Data"),
        actions: [          Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.purpleAccent], // Two-color gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Make button background transparent
                  shadowColor: Colors.transparent, // Remove shadow to keep gradient effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: generatePdf, // Call the function when button is clicked
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.download, color: Colors.white), // Download icon
                    SizedBox(width: 8), // Space between icon and text
                    Text(
                      "Export",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildHeader("All Logs"),
              buildHeader("Employee Wise"),
              buildHeader("Dustbin Wise"),
            ],
          ),
          Divider(thickness: 2),

          Expanded(child: buildLogsList()),
          FooterWidget()
        ],

      ),

    );
  }
  // Build Logs List
  Widget buildLogsList() {
    return Expanded(
      child: selectedHeader == "All Logs"
          ? buildAllLogsList()
          : selectedHeader == "Employee Wise"
          ? EmployeeWiseScreen(
        onDataChanged: (data) {
          setState(() {
            exportempListInObj = data;
          });
        },
      )
          : DustbinWiseScreen(
        onDataChanged: (data) {
          setState(() {
            exportDustListInObj = data;
          });
        },
      ),
    );

  }

/*  Widget buildLogsList() {
    if (selectedHeader == "All Logs") {
      return buildAllLogsList();
    } else if (selectedHeader == "Employee Wise") {
      return EmployeeWiseScreen();
    } else if (selectedHeader == "Dustbin Wise") {
      return DustbinWiseScreen();
    } else {
      return Center(
        child: Text(
          "Select a header to view logs",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
  }*/

  Widget buildHeader(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedHeader = title;
        });
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selectedHeader == title ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selectedHeader == title ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


  // Build All Logs List
  Widget buildAllLogsList() {
    return Column(
      children: [
        // Fix Header:
        Container(
          color: Colors.grey[300],
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [

              Expanded(
                flex: 2,
                child: Text(
                  "Card ID",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Employee Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Department",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Dustbin ID",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Scan Time",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: exportAllLogsListInObj.length ?? 0,
            itemBuilder: (context, index) {
              final logs = exportAllLogsListInObj[index].scanLogs ?? [];
              return Column(
                children: logs.map((log){
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(flex: 2, child: Text(log.cardId ?? "UNKNOWN")),
                          Expanded(flex: 3, child: Text(log.empName ?? "UNKNOWN")),
                          Expanded(flex: 3, child: Text(log.department ?? "UNKNOWN")),
                          Expanded(flex: 3, child: Text(log.dustbinId ?? "UNKNOWN")),
                          Expanded(flex: 2, child: Text(log.scanTime ?? "UNKNOWN")),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),

      ],
    );
  }


}






