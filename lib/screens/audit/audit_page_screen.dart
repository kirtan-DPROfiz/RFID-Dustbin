/*
import 'package:flutter/material.dart';

class AuditPageScreen extends StatelessWidget {
  const AuditPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> auditData = [
      {
        'date': '2025-02-10',
        'timeStamp': '14:30:00',
        'event': 'Data Exported Successfully'
      },
      {
        'date': '2025-02-11',
        'timeStamp': '10:15:00',
        'event': 'Scheduled Backup Completed'
      },
      {
        'date': '2025-02-12',
        'timeStamp': '16:45:00',
        'event': 'Manual Export Initiated'
      },
      {
        'date': '2025-02-13',
        'timeStamp': '09:00:00',
        'event': 'Export Error - Retry Required'
      },
      {
        'date': '2025-02-14',
        'timeStamp': '12:20:00',
        'event': 'Data Exported Successfully'
      },
    ];

    return Scaffold(
      key: GlobalKey<ScaffoldState>(), // Ensure each Scaffold has a unique key
      appBar: AppBar(title: Text('Audit Data')),
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
                    child: Text('Date',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text('Time Stamp',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 5,
                    child: Text('Event',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),

          // Export Data List
          Expanded(
            child: ListView.builder(
              itemCount: auditData.length,
              itemBuilder: (context, index) {
                final data = auditData[index];
                return Card(
                  key: ValueKey(
                      '${data['date']}-${data['timeStamp']}'), // ✅ Unique Key
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(data['date']!)),
                        Expanded(flex: 3, child: Text(data['timeStamp']!)),
                        Expanded(flex: 5, child: Text(data['event']!)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/
//--------------//

/*

import 'package:Deprofiz/network%20manager/rest_client.dart';
import 'package:flutter/material.dart';

import '../../models/api_models/Audit_list_in_obj_array.dart';

class AuditPageScreen extends StatelessWidget {
  const AuditPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audit Data')),
      body: FutureBuilder<List<AuditLogs>>(
        future:  RestClient.getAuditListInArray(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No audit logs found.'));
          } else {
            final auditLogs = snapshot.data!;
            return Column(
              children: [
                // Fixed Headers
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey[300],
                  child: Row(
                    children: [
                    Expanded(
                    flex: 2,
                    child: Text('Event_Date', style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        flex: 3,
                        child: Text('Event', style: TextStyle(fontWeight: FontWeight.bold))
                    ),


                    ],
                  ),
                ),

                // Export Data List
                Expanded(
                  child: ListView.builder(
                    itemCount: auditLogs.length,
                    itemBuilder: (context, index) {
                      final log = auditLogs[index];
                      return Card(
                        key: ValueKey(log.eventDate),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: Text(log.eventDate?.split(' ')[0] ?? 'N/A')),
                              //Expanded(flex: 3, child: Text(log.eventDate?.split(' ')[1] ?? "N/A")),
                              Expanded(flex: 3, child: Text(log.event ?? "N/A")),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}*/
//--------new from here --------------//
//---------//
/*import 'package:Deprofiz/network%20manager/rest_client.dart';
import 'package:flutter/material.dart';
import '../../models/api_models/Audit_list_in_obj_array.dart';

class AuditPageScreen extends StatelessWidget {
  AuditPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audit Data')),
      body: FutureBuilder<List<AuditLogs>>(
        future: RestClient.getAuditListInObj(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No audit logs found.'));
          }

          final auditLogs = snapshot.data!;

          return Column(
            children: [
              // Fixed Headers
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.grey[300],
                child: const Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text('Event Date', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('Event', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),

              // Expanded ListView
              Expanded(
                child: ListView.builder(
                  itemCount: auditLogs.length,
                  itemBuilder: (context, index) {
                    final log = auditLogs[index];

                    return Card(
                      // 🔹 Ensure unique key using the index instead of eventDate
                      key: ValueKey(index),
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                log.eventDate?.split(' ')[0] ?? 'N/A',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                log.event ?? "N/A",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}*/

//-----------------------new-----------------------------//

import 'dart:developer';

import 'package:Deprofiz/models/api_models/Audit_list_in_obj_array.dart';
import 'package:flutter/material.dart';
import '../../network manager/rest_client.dart';
import '../Footer/footer.dart';

class AuditPageScreen extends StatefulWidget {
  const AuditPageScreen({super.key});

  @override
  State<AuditPageScreen> createState() => _AuditPageScreenState();
}

class _AuditPageScreenState extends State<AuditPageScreen> {
  bool isLoading = true;
  List<AuditListInObj> auditListInObj = [];
  String errorMessage = "";
  void initState(){
    super.initState();
    AuditList();
  }


  void AuditList() {
    print("➡️ [START] userList: Fetching employee data...");

    RestClient.getAuditListInObj().then((value) {
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
          auditListInObj = value.cast<AuditListInObj>(); // Directly assign the list
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
      appBar: AppBar(title: Text('Audit-List')),
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
                    child: Text('EventDate',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text('Event',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                              ],
            ),
          ),

          // Logs List
          Expanded(
            child: ListView.builder(
              itemCount: auditListInObj.length ?? 0,
              itemBuilder: (context, index) {
                final audit = auditListInObj[index].auditLogs![0];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(audit.eventDate?? "")),
                        Expanded(flex: 3, child: Text(audit.event ?? "unknown")),

                        //Expanded(flex: 3, child: Text(log['department']!)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          FooterWidget(),

        ],
      ),

    );
  }
}



