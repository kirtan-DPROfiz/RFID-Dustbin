/* 1.
import 'package:flutter/material.dart';

class DustbinWiseScreen extends StatelessWidget {
  // Static dustbin logs data
  final List<Map<String, String>> dustbinLogs = [
    {
      "Card ID": "C001",
      "Employee Name": "John Doe",
      "Department": "IT",
      "Date & Time": "2023-10-01 10:00 AM"
    },
    {
      "Card ID": "C002",
      "Employee Name": "Jane Smith",
      "Department": "HR",
      "Date & Time": "2023-10-02 11:30 AM"
    },
    {
      "Card ID": "C003",
      "Employee Name": "Alice Johnson",
      "Department": "Finance",
      "Date & Time": "2023-10-03 12:45 PM"
    },
    {
      "Card ID": "C004",
      "Employee Name": "Bob Brown",
      "Department": "Operations",
      "Date & Time": "2023-10-04 02:15 PM"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dustbin Wise Logs"),
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
                    "Employee Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Department",
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
              itemCount: dustbinLogs.length,
              itemBuilder: (context, index) {
                final log = dustbinLogs[index];
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
                          child: Text(log["Employee Name"]!),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(log["Department"]!),
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

// this is static data running Screen:
/*
import 'package:flutter/material.dart';

class DustbinWiseScreen extends StatefulWidget {
  @override
  _DustbinWiseScreenState createState() => _DustbinWiseScreenState();
}

class _DustbinWiseScreenState extends State<DustbinWiseScreen> {
  // Static dustbin logs data
  final List<Map<String, String>> dustbinLogs = [
    {
      "Dustbin ID": "D001",
      "Card ID": "C001",
      "Employee Name": "John Doe",
      "Department": "IT",
      "Date & Time": "2023-10-01 10:00 AM"
    },
    {
      "Dustbin ID": "D002",
      "Card ID": "C002",
      "Employee Name": "Jane Smith",
      "Department": "HR",
      "Date & Time": "2023-10-02 11:30 AM"
    },
    {
      "Dustbin ID": "D003",
      "Card ID": "C003",
      "Employee Name": "Alice Johnson",
      "Department": "Finance",
      "Date & Time": "2023-10-03 12:45 PM"
    },
    {
      "Dustbin ID": "D004",
      "Card ID": "C004",
      "Employee Name": "Bob Brown",
      "Department": "Operations",
      "Date & Time": "2023-10-04 02:15 PM"
    },
  ];

  // Search controller
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  // Filtered logs based on search query
  List<Map<String, String>> get filteredLogs {
    if (_searchQuery.isEmpty) {
      return dustbinLogs;
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
        title: Text("Dustbin Wise Logs"),
        // Search bar in AppBar
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search by Dustbin ID",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26.0)),
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.black,
                  fillColor: Colors.white54,
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
                    "Employee Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Department",
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
                          child: Text(log["Dustbin ID"]!),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(log["Card ID"]!),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(log["Employee Name"]!),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(log["Department"]!),
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





import 'dart:developer';
import 'package:Deprofiz/models/api_models/export_dustbin_list_in_obj.dart';
import 'package:Deprofiz/models/api_models/export_emp_list_in_obj.dart';
import 'package:flutter/material.dart';
import '../../../network manager/rest_client.dart';
import '../../Footer/footer.dart';

class DustbinWiseScreen extends StatefulWidget {
  final Function(List<ExportDustbinListInObj>) onDataChanged;

  DustbinWiseScreen({required this.onDataChanged});
  @override
  _DustbinWiseScreenState createState() => _DustbinWiseScreenState();
}

class _DustbinWiseScreenState extends State<DustbinWiseScreen> {
  List<ExportDustbinListInObj> exportDustListInObj = [];
  bool isLoading = false;
  String errorMessage = "Search the Dustbin ID for which dustbin activity you want to see";
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      String dustbinId = _searchController.text.trim();
      if (dustbinId.isNotEmpty) {
        fetchDustbinWiseList(dustbinId);
      } else {
        setState(() {
          exportDustListInObj = [];
          errorMessage = "Search the Dustbin ID for which dustbin activity you want to see";
        });
      }
    });
  }

/*  Future<void> fetchDustbinWiseList(String dustbinId) async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });
    try {
      print("Starting getEmpWiseListInObj with Card ID:$dustbinId ");
      List<ExportDustbinListInObj> data = await RestClient.getDustbinWiseListInObj({"dustbin_id":dustbinId});

      log("✅ API Response: $data");
      setState(() {
        exportDustListInObj = data.cast<ExportDustbinListInObj>();
        isLoading = false;
        if (data.isEmpty) {
          errorMessage = "No data found for Dustbin ID: $dustbinId";
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
  //-----------------//
  Future<void> fetchDustbinWiseList(String dustbinId) async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });
    try {
      List<ExportDustbinListInObj> data = await RestClient.getDustbinWiseListInObj({"dustbin_id": dustbinId});
      log("✅ API Response: $data");
      setState(() {
        exportDustListInObj = data.cast<ExportDustbinListInObj>();
        isLoading = false;
        if (data.isEmpty) {
          errorMessage = "No data found for Dustbin ID: $dustbinId";
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
        title: Text("Dustbin Wise Logs"),
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search By Dustbin ID",
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
          // List of Data
          Expanded(
            child: ListView.builder(
              itemCount: exportDustListInObj.length,
              itemBuilder: (context, index) {
                final logs = exportDustListInObj[index].scanLogs ?? [];
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
                            Expanded(flex: 2, child: Text(log.scanTime ?? "UNKNOWN")),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),  //FooterWidget()
        ],
      ),
    );
  }
}















































// this is EmpWise Function:
/*void EmpWiseList() {
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
        exportEmpListInObj = value; // Directly assign the list
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
}*/
