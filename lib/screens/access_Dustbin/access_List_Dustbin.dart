/*
import 'dart:developer';

import 'package:Deprofiz/models/api_models/dustbin_access_list_in_obj.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../network manager/rest_client.dart';

class AccessListDustbin extends StatefulWidget {
  const AccessListDustbin({super.key});

  @override
  State<AccessListDustbin> createState() => _AccessListDustbinState();
}

class _AccessListDustbinState extends State<AccessListDustbin> {

  bool isLoading = true;
  List<DustbinAccessListInObj> dustbinAccessListInObj = [];

  //DustbinAccessListInObj dustbinAccessListInObj = DustbinAccessListInObj();
  String errorMessage = "";

  void initState() {
    super.initState();
 AccessList();
  }

  void AccessList() {
    print("➡️ [START] userList: Fetching employee data...");

    RestClient.getDustbinAccessListInObj().then((value) {
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
          dustbinAccessListInObj = value; // Directly assign the list
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
    return  Scaffold(
      body: isLoading
          ? const Center(
          child: CircularProgressIndicator()) // Show loading indicator
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage)) // Show error message
          : Column(
        children: [
          // Fixed Headers
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey[300],
            child: Row(
              children: const [
                Expanded(
                    flex: 2,
                    child: Text('Card ID',
                        style:
                        TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text('Employee Name',
                        style:
                        TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text('Department',
                        style:
                        TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text('Designation',
                        style:
                        TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text('DustBinId',
                        style:
                        TextStyle(fontWeight: FontWeight.bold))),    Expanded(
                    flex: 2,
                    child: Text('Location',
                        style:
                        TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),

          // Data in List
          Expanded(
            child: ListView.builder(
              itemCount:  dustbinAccessListInObj.length ?? 0,
              itemBuilder: (context, index) {
                var data = dustbinAccessListInObj[index].assignments![0];
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2, child: Text(data.cardId ??  "")),
                      Expanded(
                          flex: 3,
                          child: Text(data.empName ?? "Unknown")),
                      Expanded(
                          flex: 3,
                          child: Text(data.department ?? "Unknown")),
                      Expanded(
                          flex: 3,
                          child: Text(data.designation ?? "Unknown")),
                      Expanded(
                          flex: 3,
                          child: Text(data.dustbinId ?? "Unknown")),
                      Expanded(
                          flex: 2,
                          child: Text(data.location ?? "Unknown")),

                    ],
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
//-----------new --------------------//
import 'dart:async';
import 'dart:developer';

import 'package:Deprofiz/models/api_models/dustbin_access_list_in_obj.dart';
import 'package:flutter/material.dart';

import '../../network manager/rest_client.dart';
import '../Footer/footer.dart';

class AccessListDustbin extends StatefulWidget {
  const AccessListDustbin({super.key});

  @override
  State<AccessListDustbin> createState() => _AccessListDustbinState();
}

class _AccessListDustbinState extends State<AccessListDustbin> {
  bool isLoading = true;
  List<DustbinAccessListInObj> dustbinAccessListInObj = [];
  List<DustbinAccessListInObj> filteredList = [];
  String errorMessage = "";
  TextEditingController searchController = TextEditingController();
  String searchHint = "Search by CardId";
  int hintIndex = 0; // To toggle between hints

  @override
  void initState() {
    super.initState();
    AccessList();
    startHintAnimation();
    searchController.addListener(() => filterList());
  }

  // Fetch Data
  void AccessList() {
    RestClient.getDustbinAccessListInObj().then((value) {
      log("✅ API Response: $value");

      if (value == null) {
        log("⚠️ Warning: API returned null or an empty list.");
        setState(() {
          errorMessage = "No data found.";
          isLoading = false;
        });
      } else {
        log("📊 API returned data: ${value.length} items");
        setState(() {
          dustbinAccessListInObj = value;
          filteredList = value; // Set initial filtered list
          isLoading = false;
        });
      }
    }).catchError((error) {
      log("❌ Error fetching API data: $error");
      setState(() {
        errorMessage = "Failed to load data. Please check your network.";
        isLoading = false;
      });
    });
  }

  // Animate search hint text
  void startHintAnimation() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;
      setState(() {
        searchHint = hintIndex == 0 ? "Search by  Dustbin-Id  " : "Search by CardId";
        hintIndex = 1 - hintIndex;
      });
    });
  }

  // Filter list based on search input
  void filterList() {
    String query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredList = dustbinAccessListInObj;
      } else {
        filteredList = dustbinAccessListInObj.where((item) {
          var assignment = item.assignments![0];
          return (assignment.cardId?.toLowerCase().contains(query) ?? false) ||
              (assignment.dustbinId?.toLowerCase().contains(query) ?? false);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: searchHint,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          // Table Header
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey[300],
            child: Row(
              children: const [
                Expanded(flex: 3, child: Text('Card ID', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text('Employee Name', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text('Department', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text('Designation', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text('DustBinId', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Location', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),

          // Data List
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                var data = filteredList[index].assignments![0];
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: Text(data.cardId ?? "")),
                      Expanded(flex: 3, child: Text(data.empName ?? "Unknown")),
                      Expanded(flex: 3, child: Text(data.department ?? "Unknown")),
                      Expanded(flex: 3, child: Text(data.designation ?? "Unknown")),
                      Expanded(flex: 3, child: Text(data.dustbinId ?? "Unknown")),
                      Expanded(flex: 2, child: Text(data.location ?? "Unknown")),
                    ],
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
