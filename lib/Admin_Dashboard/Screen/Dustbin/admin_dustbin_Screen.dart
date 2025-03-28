import 'dart:developer';
import 'package:Deprofiz/models/api_models/All_Access_Block_List_In_Obj.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/api_models/dustbin_list_in_array.dart';
import '../../../network manager/rest_client.dart';


class AdminDustbinPageScreen extends StatefulWidget {
  @override
  _AdminDustbinPageScreenState createState() => _AdminDustbinPageScreenState();
}

class _AdminDustbinPageScreenState extends State<AdminDustbinPageScreen> {
  bool isLoading = true;
  String errorMessage = "";
  List<DustBinListInArray> dustbinListInObj = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    print("➡️ [DustbinPage] initState called.");
    fetchDustbins();
  }

  // Fetch dustbin data from the API
  void fetchDustbins() async {
    print("➡️ [DustbinPage] Starting fetchDustbins...");

    try {
      final value = await RestClient.getDustbinListInArray();
      log("✅ [DustbinPage] API Response: $value");

      if (value.isEmpty) {
        log("⚠️ [DustbinPage] Warning: API returned an empty list.");
        setState(() {
          errorMessage = "No data found.";
          isLoading = false;
        });
      } else {
        log("📊 [DustbinPage] API returned data: ${value.length} items");
        setState(() {
          dustbinListInObj = value ?? [];
          //dustbinListInObj = value.cast<DustBinListInObj>();
          isLoading = false;
        });
      }
    } catch (error) {
      log("❌ [DustbinPage] Error fetching API data: $error");
      setState(() {
        errorMessage =
        "Failed to load data. Please check your network or try again.";
        isLoading = false;
      });
    } finally {
      print("➡️ [DustbinPage] fetchDustbins execution completed.");
    }
  }

  // Method to add a new dustbin using API
  void addNewDustbin() {
    print("addNewDustbin() called"); // Log for method invocation
    String newDustbinID = '';
    String newLocation = '';

    // Show dialog to input dustbin details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextField for entering Dustbin ID
            TextField(
              decoration: InputDecoration(labelText: 'Dustbin ID'),
              onChanged: (value) {
                newDustbinID = value.trim();
                print("✏️ Dustbin ID entered: $newDustbinID"); // Log user input
              },
            ),
            // TextField for entering Location
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
              onChanged: (value) {
                newLocation = value.trim();
                print("📍 Location entered: $newLocation"); // Log user input
              },
            ),
          ],
        ),
        actions: [
          // Cancel button to close the dialog
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          // Add button to submit dustbin details
          TextButton(
            onPressed: () async {
              if (newDustbinID.isNotEmpty && newLocation.isNotEmpty) {
                print(
                    "🚀 [DustbinPage] Attempting to add new dustbin: ID=$newDustbinID, Location=$newLocation");

                try {
                  await RestClient.addNewDustbin({
                    "dustbin_id": newDustbinID,
                    "location": newLocation,
                  });
                  Get.snackbar("Success", "Dustbin added successfully!",
                      backgroundColor: Colors.black,
                      colorText: Colors.greenAccent,
                      snackPosition: SnackPosition.TOP);
                  fetchDustbins(); // Refresh the list
                  Get.back();
                } catch (e) {
                  Get.snackbar("Error", "Failed to add dustbin: $e",
                      backgroundColor: Colors.black,
                      colorText: Colors.redAccent,
                      snackPosition: SnackPosition.TOP);
                }
              } else {
                print("⚠️ [DustbinPage] Both fields are required!");
                Get.snackbar("Warning", "Please fill all fields",
                    backgroundColor: Colors.black,
                    colorText: Colors.redAccent,
                    snackPosition: SnackPosition.TOP);
              }
            },

/* async {
              if (newDustbinID.isNotEmpty && newLocation.isNotEmpty) {
                print(
                    "🚀 Sending new dustbin details to API: ID=$newDustbinID, Location=$newLocation");

                // Prepare the request body
                Map<String, dynamic> requestBody = {
                  "dustbin_id": newDustbinID,
                  "location": newLocation,
                };

                // Call the API to add the dustbin
                final restclien = RestClient();
                var response = await RestClient.AddNewDustbin(requestBody);

                print("🔄 API Response Received: $response");

                // Check if API call was successful
                if (response != null && response['status'] == "success") {
                  print("✅ Dustbin added successfully!");
                  Get.snackbar("Success", "Dustbin added successfully!",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.black,
                      colorText: Colors.greenAccent);
                  Get.back(); // Close the dialog
                } else {
                  print("❌ Failed to add dustbin. Response: $response");
                  Get.snackbar("Error", "Failed to add dustbin. Try again!",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.black,
                      colorText: Colors.redAccent);
                }
              } else {
                print("⚠️ Both fields are required!");
                Get.snackbar("Warning", "Please fill all fields",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.black,
                    colorText: Colors.redAccent);
              }
            },*/

            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  // Method to edit an existing dustbin
  void editDustbin(Map<String, String> dustbin) {
    print("editDustbin() called with dustbin: $dustbin"); // Log method call
    TextEditingController idController =
    TextEditingController(text: dustbin['id']);
    TextEditingController locationController =
    TextEditingController(text: dustbin['location']);

    // Show dialog for editing dustbin details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextField for editing Dustbin ID
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'Dustbin ID'),
            ),
            // TextField for editing Location
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
          ],
        ),
        actions: [
          // Cancel button to close the dialog
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          // Update button to save changes
          TextButton(
            onPressed: () async {
              print(
                  "✏️ [DustbinPage] Attempting to update dustbin: ID=${idController.text}, Location=${locationController.text}");

              try {
                await RestClient.updateDustbin({
                  "dustbin_id": idController.text.trim(),
                  "location": locationController.text.trim(),
                });
                Get.snackbar("Success", "Dustbin updated successfully!",
                    backgroundColor: Colors.black,
                    colorText: Colors.greenAccent,
                    snackPosition: SnackPosition.TOP);
                fetchDustbins(); // Refresh the list
                Get.back();
              } catch (e) {
                Get.snackbar("Error", "Failed to update dustbin: $e",
                    backgroundColor: Colors.black,
                    colorText: Colors.redAccent,
                    snackPosition: SnackPosition.TOP);
              }
              setState(() {
                dustbin['id'] = idController.text.trim();
                dustbin['location'] = locationController.text.trim();
                print("Updated dustbin: $dustbin"); // Log updated data
              });
              Get.back(); // Close the dialog
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  // Method to Grant a dustbin
  void grantAccessDustbin(String dustbinId) {
    print(
        "grantAccessDustbin() called for dustbin ID: $dustbinId"); // Log method call

    TextEditingController cardIdController = TextEditingController();
    TextEditingController dustbinIdController =
    TextEditingController(text: dustbinId);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Grant Access  Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter Card ID and Dustbin ID to Grant access'),
            TextFormField(
              controller: cardIdController,
              decoration: InputDecoration(labelText: 'Card ID'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: dustbinIdController,
              decoration: InputDecoration(labelText: 'Dustbin ID'),
              enabled: false, // Dustbin ID should not be editable
            ),
          ],
        ),
        actions: [
          // Cancel button to close the dialog
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          // Remove Access button to confirm removal
          TextButton(
            onPressed: () async {
              String cardId = cardIdController.text.trim();
              String dustbinId = dustbinIdController.text.trim();

              if (cardId.isEmpty) {
                print("Card ID cannot be empty");
                Get.snackbar("Error", "Card ID cannot be empty");
                return;
              }

              print(
                  "🗑️ [DustbinPage] Attempting to granting Access of dustbin: ID=$dustbinId for Card ID=$cardId");

              try {
                await RestClient.grantAccessDB(
                    { "card_id": cardId, "dustbin_id" : dustbinId});
                print("Dustbin Access Grant successfully!");
                // Get.snackbar("Success", "Dustbin Access grant successfully!");
                // fetchDustbins(); // Refresh the list
                Get.back();
              } catch (e) {
                print("Failed to grant access: $e");
                Get.snackbar("Error", "Failed to grant access: $e");
              }

              print(
                  "Access removed for dustbin: $dustbinId with Card ID: $cardId"); // Log removal
            },
            child: Text('Grant Access'),
          ),
        ],
      ),
    );
  }

  // Method to remove a dustbin
  void removeAccessDustbin(String dustbinId) {
    print("removeAccessDustbin() called for dustbin ID: $dustbinId"); // Log method call

    TextEditingController cardIdController = TextEditingController();
    TextEditingController dustbinIdController =
    TextEditingController(text: dustbinId);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Access Remove Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter Card ID and Dustbin ID to remove access'),
            TextFormField(
              controller: cardIdController,
              decoration: InputDecoration(labelText: 'Card ID'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: dustbinIdController,
              decoration: InputDecoration(labelText: 'Dustbin ID'),
              enabled: false, // Dustbin ID should not be editable
            ),
          ],
        ),
        actions: [
          // Cancel button to close the dialog
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          // Remove Access button to confirm removal
          TextButton(
            onPressed: () async {
              String cardId = cardIdController.text.trim();
              String dustbinId = dustbinIdController.text.trim();

              if (cardId.isEmpty) {
                print("Card ID cannot be empty");
                //Get.snackbar("Error", "Card ID cannot be empty");
                return;
              }

              print(
                  "🗑️ [DustbinPage] Attempting to Remove Access of dustbin: ID=$dustbinId for Card ID=$cardId");

              try {
                await RestClient.removeAccessDB(
                    {"card_id": cardId, "dustbin_id": dustbinId});
                print("Dustbin Access removed successfully! For CardId:$cardId");
                //Get.snackbar("Success", "Dustbin Access removed successfully!",snackPosition: SnackPosition.TOP);
                Get.back();
              } catch (e) {
                print("Failed to remove access: $e");
                Get.snackbar("Error", "Failed to remove access: $e");
              }

              print("Access removed for dustbin: $dustbinId with Card ID: $cardId");
              Get.back();// Log removal
            },
            child: Text('Remove Access'),
          ),
        ],
      ),
    );
  }

  //Method to Manage Access a dustbin:
  /* void manageAccessDustbin(String dustbinId) async {
    List<ExportDustbinListInObj> employeeList = [];
    TextEditingController dustbinIdController = TextEditingController(text: dustbinId);

    // Fetch employees related to the selected dustbinId
    try {
      employeeList = await RestClient.getDustbinWiseListInObj({"dustbin_id": dustbinId});
      print("Fetched Employees: ${employeeList.length}");
    } catch (e) {
      print("Error fetching employees: $e");
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Manage Access for Dustbin ID: $dustbinId'),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (employeeList.isEmpty)
                Text('No Employees Found'),
              if (employeeList.isNotEmpty)
              // Fixed Headers:
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
              //List of Data:
              Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: employeeList.length,
                    itemBuilder: (context, index) {
                      final emp = employeeList[index].scanLogs ?? [];
                      return Column(
                        children: emp.map((log) {
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
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {




              print("Block All Access Triggered");
              // Call your Block All API here
              Get.back();
            },
            child: Text('Block All Access'),
          ),
          TextButton(
            onPressed: () {
              print("Allow All Access Triggered");
              // Call your Allow All API here
              Get.back();
            },
            child: Text('Allow All Access'),
          ),
        ],
      ),
    );
  }*/

//-------------------------------------------//
  /*void manageAccessDustbin(String dustbinId) async {
    List<ExportDustbinListInObj> employeeList = [];
    TextEditingController dustbinIdController = TextEditingController(text: dustbinId);
    Map<String, bool> selectedEmployees = {};

    try {
      employeeList = await RestClient.getDustbinWiseListInObj({"dustbin_id": dustbinId});
      print("Fetched Employees: ${employeeList.length}");
    } catch (e) {
      print("Error fetching employees: $e");
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Manage Access for Dustbin ID: $dustbinId'),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (employeeList.isEmpty)
                Text('No Employees Found'),
              if (employeeList.isNotEmpty)
                Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    children: [

                      Expanded(flex: 2, child: Text("Card ID", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 3, child: Text("Employee Name", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 3, child: Text("Department", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 2, child: Text("Scan Time", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text("Select", style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: employeeList.length,
                  itemBuilder: (context, index) {
                    final emp = employeeList[index].scanLogs ?? [];
                    return Column(
                      children: emp.map((log) {
                        selectedEmployees[log.cardId ?? "UNKNOWN"] = false;
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: CheckboxListTile(
                            title: Row(
                              children: [
                                Expanded(flex: 2, child: Text(log.cardId ?? "UNKNOWN")),
                                Expanded(flex: 3, child: Text(log.empName ?? "UNKNOWN")),
                                Expanded(flex: 3, child: Text(log.department ?? "UNKNOWN")),
                                Expanded(flex: 2, child: Text(log.scanTime ?? "UNKNOWN")),
                              ],
                            ),
                            value: selectedEmployees[log.cardId ?? "UNKNOWN"],
                            onChanged: (bool? value) {
                              selectedEmployees[log.cardId ?? "UNKNOWN"] = value ?? false;
                            },
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () async {
              List<String> selectedCardIds = selectedEmployees.entries
                  .where((entry) => entry.value)
                  .map((entry) => entry.key)
                  .toList();

              if (selectedCardIds.isNotEmpty) {
                for (var cardId in selectedCardIds) {
                  try {
                    Map<String, dynamic> response = await RestClient.getManageAccessListInObj({
                      "card_id":cardId,
                      "action": "block",
                    });
                    print("Response for Card ID $cardId: ${response["msg"]}");
                    Get.snackbar("Access Management", response["msg"], snackPosition: SnackPosition.BOTTOM);
                  } catch (e) {
                    print("Error blocking access for Card ID $cardId: $e");
                  }
                }
              } else {
                Get.snackbar("Access Management", "No Employee Selected", snackPosition: SnackPosition.BOTTOM);
              }
              Get.back();
            },
            child: Text('Block All Access'),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Allow All Access'),
          ),
        ],
      ),
    );
  }*/
  //--------------------------------------------//
  void manageAccessDustbin(String dustbinId) async {
    List<AllAccessBlockListInObj> employeeList = [];
    TextEditingController dustbinIdController = TextEditingController(text: dustbinId);
    Map<String, bool> selectedEmployees = {};

    try {
      employeeList = await RestClient.getFetchDustbinListInObj({"dustbin_id": dustbinId});
      print("Fetched Employees: ${employeeList.length}");
    } catch (e) {
      print("Error fetching employees: $e");
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text('Manage Access for Dustbin ID: $dustbinId'),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (employeeList.isEmpty) Text('No Employees Found'),
                  if (employeeList.isNotEmpty)
                    Container(
                      color: Colors.grey[300],
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: Text("Card_ID", style: TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 3, child: Text("Employee_Name", style: TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 3, child: Text("Department", style: TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 3, child: Text("Designation", style: TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 3, child: Text("Dustbin_Id", style: TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 2, child: Text("Location", style: TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 1, child: Text("Select", style: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: employeeList.length,
                      itemBuilder: (context, index) {
                        final emp = employeeList[index].dustbinAssignments ?? [];
                        return Column(
                          children: emp.map((log) {
                            selectedEmployees[log.cardId ?? "UNKNOWN"] = selectedEmployees[log.cardId ?? "UNKNOWN"] ?? false;
                            return Card(
                              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: CheckboxListTile(
                                checkColor: Colors.black,
                                title: Row(
                                  children: [
                                    Expanded(flex: 2, child: Text(log.cardId ?? "UNKNOWN")),
                                    Expanded(flex: 3, child: Text(log.empName ?? "UNKNOWN")),
                                    Expanded(flex: 3, child: Text(log.department ?? "UNKNOWN")),
                                    Expanded(flex: 3, child: Text(log.designation ?? "UNKNOWN")),
                                    Expanded(flex: 3, child: Text(log.dustbinId ?? "UNKNOWN")),
                                    Expanded(flex: 2, child: Text(log.location ?? "UNKNOWN")),
                                  ],
                                ),
                                value: selectedEmployees[log.cardId ?? "UNKNOWN"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    selectedEmployees[log.cardId ?? "UNKNOWN"] = value ?? false;
                                  });
                                },

                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              // All buttons:

              //Close button:
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70
                  ),
                  onPressed: () => Get.back(),
                  child: Text('Close',style: TextStyle(color: Colors.deepPurpleAccent),),
                ),
              ),
              // block All Access Button:
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70),
                  onPressed: () async {
                    List<String> selectedCardIds = selectedEmployees.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();

                    if (selectedCardIds.isNotEmpty) {
                      for (var cardId in selectedCardIds) {
                        try {
                          Map<String, dynamic> response = await RestClient.getManageAccessListInObj({
                            "card_id": cardId,
                            "action": "block",
                          });
                          print("Response for Card ID $cardId: ${response["msg"]}");
                          Get.snackbar("Access Management", response["msg"], snackPosition: SnackPosition.TOP);
                        } catch (e) {
                          print("Error blocking access for Card ID $cardId: $e");
                        }
                      }
                    } else {
                      Get.snackbar("Access Management", "No Employee Selected", snackPosition: SnackPosition.TOP);
                    }
                    Get.back();
                    //refresh the list Data
                    employeeList;

                  },
                  child: Text('Block All Access',style: TextStyle(color: Colors.deepPurpleAccent),),
                ),
              ),
              // Allow All Access Button:
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70
                  ),
                  onPressed: () async {
                    List<String> selectedCardIds = selectedEmployees.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();

                    if (selectedCardIds.isNotEmpty) {
                      for (var cardId in selectedCardIds) {
                        try {
                          Map<String, dynamic> response = await RestClient.getManageAccessListInObj({
                            "card_id": cardId,
                            "action": "allow",
                          });
                          print("Response for Card ID $cardId: ${response["msg"]}");
                          Get.snackbar("Access Management", response["msg"], snackPosition: SnackPosition.TOP);
                        } catch (e) {
                          print("Error allowing all  access for Card ID $cardId: $e");
                        }
                      }
                    } else {
                      Get.snackbar("Access Management", "No Employee Selected", snackPosition: SnackPosition.TOP);
                    }
                    Get.back();
                    //refresh the list Data
                    employeeList;
                  },
                  child: Text('Allow All Access',style: TextStyle(color: Colors.deepPurpleAccent),),
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  // Filter dustbins based on search query
  List<DustBinListInArray> getFilteredDustbins() {
    if (searchQuery.isEmpty) {
      return dustbinListInObj;
    } else {
      return dustbinListInObj
          .where((dustbin) =>
      dustbin.dustbinId!
          .toLowerCase()
          .contains(searchQuery.toLowerCase()) ||
          dustbin.location!
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Search and Add Button
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            expandedHeight: 20.0,
            flexibleSpace: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  // Search Bar
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 36.0,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          hintText: 'Search Dustbin by ID or Location...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[300],
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value.trim();
                            print("Search query updated: $searchQuery");
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  // Add New Dustbin Button
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 36.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () {
                          // Add new dustbin functionality
                          addNewDustbin();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(width: 8),
                            Text("Add New",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Display Total Dustbins
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Total Dustbins: ${dustbinListInObj.length}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Fixed header for dustbin table
          SliverPersistentHeader(
            pinned: true,
            delegate: _HeaderDelegate(dustbins: dustbinListInObj),
          ),

          // List of Dustbins
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final filteredDustbins = getFilteredDustbins();
                final dustbin = filteredDustbins[index];
                print("Rendering dustbin: ${dustbin.dustbinId}");

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Display Dustbin ID
                        Expanded(
                          flex: 2,
                          child: Text(
                            dustbin.dustbinId.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Display Location
                        Expanded(
                          flex: 2,
                          child: Text(
                            dustbin.location.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Three-dot Menu for Actions
                        Expanded(
                          flex: 1,
                          child: PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert, color: Colors.black),
                            onSelected: (value) {
                              if (value == 'edit') {
                                print(
                                    "Edit option selected for dustbin: ${dustbin.dustbinId}");
                                // Call the editDustbin() function with the selected dustbin details
                                editDustbin({
                                  "id": dustbin.dustbinId.toString(),
                                  "location": dustbin.location.toString(),
                                });
                              } else if (value == 'manage Access') {
                                print("Access Manage Access for dustbin: ${dustbin.dustbinId}");
                                manageAccessDustbin(
                                    dustbin.dustbinId.toString());
                                // Handle remove access action
                              } else if (value == 'remove Access') {
                                print(
                                    "Access removed for dustbin: ${dustbin.dustbinId}");
                                // Handle remove access action
                                removeAccessDustbin(
                                    dustbin.dustbinId.toString());
                              } else if (value == 'grant Access') {
                                print(
                                    "Grant Access for dustbin: ${dustbin.dustbinId}");
                                // Handle remove access action

                                grantAccessDustbin(
                                    dustbin.dustbinId.toString());
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'manage Access',
                                child: Text('Manage Access'),
                              ),
                              PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit Details'),
                              ),
                              PopupMenuItem(
                                value: 'grant Access',
                                child: Text('Grant Access'),
                              ),
                              PopupMenuItem(
                                value: 'remove Access',
                                child: Text('Remove Access'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: getFilteredDustbins().length,
            ),
          ),
        ],
      ),
    );
  }
}
// SliverPersistentHeader Delegate for Fixed Header

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<DustBinListInArray> dustbins;

  _HeaderDelegate({required this.dustbins});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Column(
        children: [
          // Header Row
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text('Dustbin ID',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 2,
                  child: Text('Location',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 1,
                  child: Text('Action',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          // List of Dustbins
          /* Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: dustbins.length,
              itemBuilder: (context, index) {
                final dustbin = dustbins[index];
                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(dustbin.dustbinId.toString(),
                          style: TextStyle(fontSize: 14)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(dustbin.location.toString(),
                          style: TextStyle(fontSize: 14)),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.black),
                        onPressed: () {
                          // Handle actions (edit, delete, etc.)
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),*/
        ],
      ),
    );
  }

  @override
  double get maxExtent => 36.0; // Adjust height as needed

  @override
  double get minExtent => 36.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}