/* 1.
import 'package:flutter/material.dart';

class EmployeeWiseScreen extends StatelessWidget {
  // Static employee logs data
  final List<Map<String, String>> employeeLogs = [
    {"Card ID": "C001", "Date & Time": "2023-10-01 10:00 AM"},
    {"Card ID": "C002", "Date & Time": "2023-10-02 11:30 AM"},
    {"Card ID": "C003", "Date & Time": "2023-10-03 12:45 PM"},
    {"Card ID": "C004", "Date & Time": "2023-10-04 02:15 PM"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Wise Logs"),
      ),
      body: Column(
        children: [
          // Fixed Headers
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
                  flex: 2,
                  child: Text(
                    "Date & Time",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Logs List
          Expanded(
            child: ListView.builder(
              itemCount: employeeLogs.length,
              itemBuilder: (context, index) {
                final log = employeeLogs[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(log["Card ID"]!),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(log["Date & Time"]!),
                        ),
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

/*

//previous one
import 'dart:developer';

import 'package:Deprofiz/models/api_models/export_emp_list_in_obj.dart';
import 'package:flutter/material.dart';

import '../../../network manager/rest_client.dart';

class EmployeeWiseScreen extends StatefulWidget {
  @override
  _EmployeeWiseScreenState createState() => _EmployeeWiseScreenState();
}

class _EmployeeWiseScreenState extends State<EmployeeWiseScreen> {
  bool isLoading = true;
  String errorMessage = " ";
  List<ExportEmpListInObj> exportempListInObj = [];
  // Search controller
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";


  void initState() {
    super.initState();
    EmpWiseList();
  }
  // Static employee logs data
 void EmpWiseList(){
   print("➡️ [START] userList: Fetching employee data...");

   RestClient.getEmpWiseListInObj().then((value) {
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
         exportempListInObj = value; // Directly assign the list
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

  // Filtered logs based on search query
  List<Map<String, String>> get filteredLogs {
    if (_searchQuery.isEmpty) {
      return e;
    } else {
      return dustbinLogs
          .where((log) => log["Dustbin ID"]!
          .toLowerCase()
          .contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Employee Wise Logs"),

        // Search bar in AppBar
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search by Card ID",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26.0)),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = "";
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Fixed Headers
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [

                Expanded(
                  flex: 2,
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
          // Logs List
          Expanded(
            child: ListView.builder(
              itemCount: exportempListInObj.length ?? 0,
              itemBuilder: (context, index) {
                final log = exportempListInObj[index].scanLogs![0];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(log.dustbinId ?? "UNKNOWN"),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(log.scanTime ?? "UNKNOWN"),
                        ),

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


/*
import 'dart:developer';

import 'package:Deprofiz/models/api_models/export_emp_list_in_obj.dart';
import 'package:flutter/material.dart';

import '../../../network manager/rest_client.dart';

class EmployeeWiseScreen extends StatefulWidget {
  @override
  _EmployeeWiseScreenState createState() => _EmployeeWiseScreenState();
}

class _EmployeeWiseScreenState extends State<EmployeeWiseScreen> {
  bool isLoading = false;
  String errorMessage = "Search the Card ID for which dustbin activity you want to see";
  List<ExportEmpListInObj> exportempListInObj = [];
  //ExportEmpListInObj exportempListInObj = ExportEmpListInObj();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  void initState() {
    super.initState();
    EmpWiseList();
  }

  void EmpWiseList() {

    print("➡️ [START] userList: Fetching employee data for Card ID");

    RestClient.getEmpWiseListInObj().then((value) {
      log("✅ API Response: $value");

      if (value == null || value.isEmpty) {
        log("⚠️ Warning: No data found for the given Card ID.");
        setState(() {
          errorMessage = "No data found for this Card ID";
          isLoading = false;
        });
      } else {
        log("📊 API returned data: ${value.length} items");
        setState(() {
          exportempListInObj = value ;
          isLoading = false;
        });
      }
    }).catchError((error) {
      log("❌ Error fetching API data: $error");
      setState(() {
        errorMessage = "Failed to load data. Please check your network or try again.";
        isLoading = false;
      });
    });
  }

  List<ScanLogs> get filteredLogs {
    if (_searchQuery.isEmpty) {
      return [];
    }

    List<ScanLogs> allLogs = exportempListInObj
        .expand((obj) => obj.scanLogs ?? [])
        .map((log) => ScanLogs.fromJson(log as Map<String, dynamic>)) // This will convert dynamic to ScanLogs
        .toList();

  return allLogs;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Employee Wise Logs"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by Card ID",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(26.0)),
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchQuery = "";
                      exportempListInObj;
                      errorMessage = "Search the Card ID for which dustbin activity you want to see";
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  EmpWiseList();
                }
              },
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : filteredLogs.isEmpty && _searchQuery.isNotEmpty
          ? Center(child: Text(errorMessage))
          : filteredLogs.isEmpty
          ? Center(child: Text(errorMessage))
          : Column(
        children: [
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Dustbin ID",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Scan Time",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLogs.length,
              itemBuilder: (context, index) {
                final log = filteredLogs[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(log.dustbinId ?? "UNKNOWN"),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(log.scanTime ?? "UNKNOWN"),
                        ),
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




//------------------------------previous with active searchbar -----------------------//
import 'dart:developer';
import 'package:Deprofiz/models/api_models/export_emp_list_in_obj.dart';
import 'package:flutter/material.dart';
import '../../../network manager/rest_client.dart';
import '../../Footer/footer.dart';

class EmployeeWiseScreen extends StatefulWidget {
  final Function(List<ExportEmpListInObj>) onDataChanged;

  EmployeeWiseScreen({required this.onDataChanged});

  @override
  _EmployeeWiseScreenState createState() => _EmployeeWiseScreenState();
}

class _EmployeeWiseScreenState extends State<EmployeeWiseScreen> {
  List<ExportEmpListInObj> exportempListInObj = [];
  bool isLoading = false;
  String errorMessage = "Search the Employee ID for which dustbin activity you want to see";

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      String cardId = _searchController.text.trim();
      if (cardId.isNotEmpty) {
        fetchEmpWiseList(cardId);
      } else {
        setState(() {
          exportempListInObj = [];
          errorMessage = "Search the Employee ID for which dustbin activity you want to see";
        });
      }
    });
  }

 /* Future<void> fetchEmpWiseList(String cardId) async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });
    try {
      print("Starting getEmpWiseListInObj with Card ID:$cardId ");
      List<ExportEmpListInObj> data = await RestClient.getEmpWiseListInObj(
          {"card_id": cardId});

      log("✅ API Response: $data");
      setState(() {
        exportempListInObj = data;
        isLoading = false;
        if (data.isEmpty) {
          errorMessage = "No data found for Card ID: $cardId";
        }
      });
    } catch (e) {
      log("❌ Error fetching API data: $e");
      setState(() {
        errorMessage = "Failed to load data. Please try again.";
        isLoading = false;
      });
    }
  }*/


  Future<void> fetchEmpWiseList(String cardId) async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });
    try {
      List<ExportEmpListInObj> data = await RestClient.getEmpWiseListInObj({"card_id": cardId});
      log("✅ API Response: $data");
      setState(() {
        exportempListInObj = data;
        isLoading = false;
        if (data.isEmpty) {
          errorMessage = "No data found for Card ID: $cardId";
        }
      });
      widget.onDataChanged(data); // Pass data back to ExportDataScreen
    } catch (e) {
      log("❌ Error fetching API data: $e");
      setState(() {
        errorMessage = "Failed to load data. Please try again.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Employee Wise Logs"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search By Employee ID",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(26.0)),
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(onPressed: (){
                  _searchController.clear();
                }, icon:Icon(Icons.clear)),
              ),
            ),
          ),
          if (isLoading) Center(child: CircularProgressIndicator()),
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(errorMessage, textAlign: TextAlign.center, style: TextStyle(color: Colors.red)),
            ),
          // Fix Header:
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
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
              itemCount: exportempListInObj.length,
              itemBuilder: (context, index) {
                final logs = exportempListInObj[index].scanLogs ?? [];
                return Column(
                  children: logs.map((log) {
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(flex: 2, child: Text(log.dustbinId ?? "UNKNOWN")),
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

         // FooterWidget(),
        ],
      ),


    );
  }
}



//-----------------------new ---------------------------------------------//

