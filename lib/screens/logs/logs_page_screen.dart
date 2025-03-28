import 'dart:developer';

import 'package:Deprofiz/models/api_models/export_alllogs_list_in_obj.dart';
import 'package:Deprofiz/models/api_models/log_List_in_obj.dart';
import 'package:Deprofiz/models/my_files.dart';
import 'package:flutter/material.dart';

import '../../network manager/rest_client.dart';
import '../Footer/footer.dart';

class LogsPageScreen extends StatefulWidget {
  const LogsPageScreen({super.key});

  @override
  State<LogsPageScreen> createState() => _LogsPageScreenState();
}

class _LogsPageScreenState extends State<LogsPageScreen> {
  bool isLoading = true;
  List<ExportAllLogsListInObj> logListInObj = [];
  String errorMessage = "";
  void initState(){
    AllLogList();
    super.initState();

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
          logListInObj = value; // Directly assign the list
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
      key: GlobalKey<ScaffoldState>(), //  Ensure each Scaffold has a unique key
      appBar: AppBar(title: Text('Logs')),
      body: Column(
        children: [
          // Fixed Headers
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.grey[300],
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text('Card ID',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text('Employee Name',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text('Department',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text('Dustbin ID',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 2,
                    child: Text('Date/Time',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),

          // Logs List
          Expanded(
            child: ListView.builder(
              itemCount: logListInObj.length ?? 0,
              itemBuilder: (context, index) {
                final log = logListInObj[index].scanLogs![0];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(log.cardId ?? "")),
                        Expanded(flex: 3, child: Text(log.empName ?? "unknown")),
                        Expanded(flex: 3, child: Text(log.department ?? "unknown")),
                        Expanded(flex: 3, child: Text(log.dustbinId ?? "unknown")),
                        Expanded(flex: 2, child: Text(log.scanTime ?? "unknown")),
                        //Expanded(flex: 3, child: Text(log['department']!)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
           FooterWidget(), // Add the FooterWidget here
        ],
      ),

    );
  }
}
