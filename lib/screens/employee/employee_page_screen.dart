/*

// employee_page.dart
import 'dart:async';
import 'dart:developer';

import 'package:Deprofiz/screens/dashboard/components/storage_info_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeePage extends StatefulWidget {
  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  List<String> employees = [
    "Employee 1",
    "Employee 2",
    "Employee 3",
    "Employee 4",
    "Employee 5"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employees')),
      body: ListView(
        children: employees.map((employee) {
          return BuildEmployeeTile(context, employee);
        }).toList(),
        /* [
          BuildEmployeeTile(context, " Employee 1 "),
          BuildEmployeeTile(context, " Employee 2 "),
          BuildEmployeeTile(context, " Employee 3 "),
          BuildEmployeeTile(context, " Employee 4 "),
          BuildEmployeeTile(context, " Employee 5 "),
        ],*/
      ),
// previous one :
      //  ListView(
      //   children: [
      //     ListTile(
      //       title: Text('Employee 1'),
      //       trailing: Icon(Icons.update_outlined),
      //     ),
      //     ListTile(title: Text('Employee 2')),
      //     ListTile(title: Text('Employee 3')),
      //   ],
      // ),
    );
  }

// widget of BUildEmployeeTile :
  Widget BuildEmployeeTile(BuildContext context, String employeeName) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(employeeName),
        trailing: Container(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // IconButton 1 -  update :
              IconButton(
                onPressed: () => showUpdateDialog(context, employeeName),
                icon: Icon(
                  Icons.edit,
                  color: Colors.greenAccent,
                ),
              ),
              // Iconbutton 2 - Delete :
              IconButton(
                onPressed: () {
                  showDeleteDialog(context, employeeName);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//showDialogBOx of Update:
  void showUpdateDialog(BuildContext context, String employeeName) {
    final scaffoldContext = context; // Save the original context
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update $employeeName'),
            content: Text('What would you like to update for $employeeName?'),
            actions: [
              TextButton(
                onPressed: () {
                  //Navigator.pop(context);
                  Get.back();
                },
                child: Text("cancel"),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Update successfully ",
                        style: TextStyle(color: Colors.greenAccent),
                      ),
                      backgroundColor: Colors.black,
                    ),
                  );
                  log(" ");
                },
                child: Text("Update"),
              ),
            ],
          );
        });
  }

//showDialogBOx of Delete:
  void showDeleteDialog(BuildContext context, String employeeName) {
    final scaffoldContext = context; // Save the original context
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Deleted $employeeName"),
            content: Text("Are you Sure you Want to Delete $employeeName ? "),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("cancel"),
                  ),
                  SizedBox(
                    width: 26,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          employees.remove(employeeName);
                        });
                        //Navigator.pop(context);
                        Get.back();
                        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                          SnackBar(
                            content: Text(
                              " Deleted Successfully",
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                            backgroundColor: Colors.black,
                          ),
                        );
                      },
                      child: Text("Delete"))
                ],
              ),
            ],
          );
        });
  }
}
*/

// 1. Api fetch data :

// API integration

import 'dart:async';
import 'dart:developer';
import 'package:Deprofiz/network%20manager/rest_client.dart';
import 'package:Deprofiz/screens/Footer/footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:js' as js;
import 'dart:html' as html;

import '../../main.dart';
import '../../models/api_models/All_Access_Block_List_In_Obj.dart';
import '../../models/api_models/dustbin_list_in_array.dart';
import '../../models/api_models/user_list_in_Array_emp.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  bool isLoading = true;
  List<UserListInArrayEmp> userListInArray = [];
  String errorMessage = "";

  void userList() {
    print("➡️ [START] userList: Fetching employee data...");

    RestClient.getUserListInArray().then((value) {
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
        log("📊 API returned data: ${value.length} items");

        // Step 3: Update the state with the fetched data
        setState(() {
          userListInArray = value; // Assign the list of employees
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
      print("➡️ [END] userList: Execution completed.");
    });
  }

  void RFIDEmployee(){
    print("calling RFIDEmployee.....");
    
  }



  void addNewEmployee() {
    final TextEditingController cardIDController = TextEditingController();
    print("addNewEmployee() called"); // Log for method invocation
    String newCardID = '';
    String newEmployeeName = '';
    String newDepartment = '';
    String newDesignation = '';
    String newEmail = '';
    //final TextEditingController cardIdController = TextEditingController();
    StreamSubscription? nfcSubscription;
    // Initialize NFC reader immediately
    js.context.callMethod('initNFCReader');

    // Start NFC session and update the text field
    startNFCReader((cardId) {
      cardIDController.text = cardId;
      newCardID = cardId;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: cardIDController,
              decoration: InputDecoration(
                labelText: 'Card ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0), // Square corners
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(0.0), // Square corners when focused
                  borderSide: BorderSide(
                    color: Colors.blue, // Customize the color if needed
                    width: 2.0, // Customize the border width
                  ),
                ),
              ),
              onChanged: (value) => newCardID = value.trim(),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Employee Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0), // Square corners
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(0.0), // Square corners when focused
                  borderSide: BorderSide(
                    color: Colors.blue, // Customize the color if needed
                    width: 2.0, // Customize the border width
                  ),
                ),
              ),
              onChanged: (value) => newEmployeeName = value.trim(),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Department',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0), // Square corners
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(0.0), // Square corners when focused
                  borderSide: BorderSide(
                    color: Colors.blue, // Customize the color if needed
                    width: 2.0, // Customize the border width
                  ),
                ),
              ),
              onChanged: (value) => newDepartment = value.trim(),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Designation',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0), // Square corners
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(0.0), // Square corners when focused
                  borderSide: BorderSide(
                    color: Colors.blue, // Customize the color if needed
                    width: 2.0, // Customize the border width
                  ),
                ),
              ),
              onChanged: (value) => newDesignation = value.trim(),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0), // Square corners
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(0.0), // Square corners when focused
                  borderSide: BorderSide(
                    color: Colors.blue, // Customize the color if needed
                    width: 2.0, // Customize the border width
                  ),
                ),
              ),
              onChanged: (value) => newEmail = value.trim(),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              SizedBox(
                width: 100,
              ),
              TextButton(
                onPressed: () async {
                  if (newEmail.isNotEmpty &&
                      newDesignation.isNotEmpty &&
                      newDepartment.isNotEmpty &&
                      newEmployeeName.isNotEmpty &&
                      newCardID.isNotEmpty) {
                    print(
                        "🚀 [DustbinPage] Attempting to add new Employee: Email=$newEmail, Designation = $newDesignation, Department = $newDepartment, EmployeeName = $newEmployeeName,CardId = $newCardID");

                    try {
                      await RestClient.addNewEmployee({
                        "Rfid_scanTag_id": newCardID,
                        "emp_name": newEmployeeName,
                        "department": newDepartment,
                        "designation": newDesignation,
                        "email": newEmail,
                      });
                      Get.snackbar("Success", "Employee added successfully!",
                          backgroundColor: Colors.black,
                          colorText: Colors.greenAccent,
                          snackPosition: SnackPosition.TOP);
                      UserListInArrayEmp; // Refresh the list
                      Get.back();
                    } catch (e) {
                      Get.snackbar("Error", "Failed to add Employee: $e",
                          backgroundColor: Colors.black,
                          colorText: Colors.redAccent,
                          snackPosition: SnackPosition.TOP);
                    }
                  } else {
                    print("⚠️ [EmployeePage] All the fields are required!");
                    Get.snackbar("Warning", "Please fill all fields",
                        backgroundColor: Colors.black,
                        colorText: Colors.redAccent,
                        snackPosition: SnackPosition.TOP);
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        ],
      ),
    ).then((_) {
      // Clean up when dialog is closed
      nfcSubscription?.cancel();
      cardIDController.dispose();
    });
    // Start listening after dialog is shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      nfcSubscription = html.window.on['nfc-card-read'].listen((event) {
        final customEvent = event as html.CustomEvent;
        final cardId = customEvent.detail;

        startNFCReader(cardId);
      });
      js.context.callMethod('initNFCReader');
    });

  }

  // manageAccess to update the role of  Employee
  /*void manageRole(String email, String new_role) {
    print("manageRole() called for EmailID: $email"); // Log method call

    //TextEditingController cardIdController = TextEditingController();
    TextEditingController emailController = TextEditingController(text: email);


    showDialog(
        context: context,
        builder: (context) {
          // Use StatefulBuilder to manage state within the dialog
          return StatefulBuilder(
              builder: (context, setState) {
                String selectedRole = "employee"; // Default role

                return AlertDialog(
                  title: Text('Manage Access Role'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Manage the Role for  Employee'),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Email ID'),
                        enabled: false, // Dustbin ID should not be editable
                      ),
                      SizedBox(height: 20),
                      DropdownButton<String>(
                        value: selectedRole,
                        hint: Text("Selected the New Role"),
                        onChanged: (String? newValue) {
                          // Update the selectedRole and trigger a rebuild
                          setState(() {
                            selectedRole = newValue!;
                            print("Selected Role: $selectedRole"); // Debugging
                          });
                        },
                        items: <String>['super_admin', 'admin', 'employee']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    // Cancel button to close the dialog
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text('Cancel'),
                    ),
                    // Remove Access button to confirm removal
                    TextButton(
                      onPressed: () async {
                        // String cardId = cardIdController.text.trim();
                        String email = emailController.text.trim();
                        String new_Role = selectedRole.toString();

                        print(
                            " Attempting to Assign the role Employee : EmailID=$email to new_role : $new_Role");

                        try {
                          await RestClient.getManageAccessRole(
                              {"email": email, "new_role": new_Role});
                          print(
                              "New Role Assing to the Employee successfully! For EmailId:$email");
                          //Get.snackbar("Success", "Dustbin Access removed successfully!",snackPosition: SnackPosition.TOP);
                          Get.back();
                        } catch (e) {
                          print("Failed to Assign New role : $e");
                          Get.snackbar(
                              "Error", "Failed to  Assign New role : $e");
                        }

                        print(
                            "Role Assign for EmailId: $email with New role: $new_role");
                        // Get.back();// Log removal
                      },
                      child: Text('Assign Role'),
                    ),
                  ],
                );
              }
              );
        }
        );
  }*/
  //----------------------------------------------------///
  void manageRole(String email, String role) {
    print("manageRole() called for EmailID: $email with Current Role: $role");

    TextEditingController emailController = TextEditingController(text: email);
    String selectedRole = role; // Move this outside to persist the value correctly

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Manage Access Role'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Manage the Role for Employee'),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email ID'),
                    enabled: false, // Email should not be editable
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    value: selectedRole, // Ensure the selected role is correctly assigned
                    hint: Text("Select the New Role"),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedRole = newValue; // Update selected role properly
                        });
                        print("Dropdown Updated: Selected Role = $selectedRole");
                      }
                    },
                    items: ['super_admin', 'admin', 'employee']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: <Widget>[
                // Cancel button to close the dialog
                TextButton(
                  onPressed: () {
                    print("User Cancelled Role Assignment");
                    Get.back();
                  },
                  child: Text('Cancel'),
                ),
                // Assign Role button to confirm the new role
                TextButton(
                  onPressed: () async {
                    String email = emailController.text.trim();
                    print("Assign Role Button Pressed");
                    print("🔹 Final Selected Role: $selectedRole for Email: $email");

                    try {
                      // Ensure selectedRole is updated correctly before sending
                      await RestClient.getManageAccessRole(
                          {"email": email, "new_role": selectedRole});
                      print("✅ New Role Assigned Successfully: $selectedRole for Email: $email");
                      Get.back(); // Close the dialog
                    } catch (e) {
                      print("❌ Error Assigning Role: $e");
                      Get.snackbar("Error", "Failed to Assign New Role: $e");
                    }
                  },
                  child: Text('Assign Role'),
                ),
              ],
            );
          },
        );
      },
    );
  }
  // Method to edit an existing dustbin:
  void editDustbin(Map<String, String> cardId) {
    print("editDustbin() called with dustbin: $cardId"); // Log method call
    TextEditingController idController =
        TextEditingController(text: cardId["card_id"]);
    TextEditingController emailController =
        TextEditingController(text: cardId["email"]);
    TextEditingController empNameController =
        TextEditingController(text: cardId["emp_name"]);
    TextEditingController departmentController =
        TextEditingController(text: cardId["department"]);
    TextEditingController designationController =
        TextEditingController(text: cardId["designation"]);

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
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: empNameController,
              decoration: InputDecoration(labelText: 'Employee Name'),
            ),
            TextField(
              controller: departmentController,
              decoration: InputDecoration(labelText: 'Department'),
            ),
            TextField(
              controller: designationController,
              decoration: InputDecoration(labelText: 'Designation'),
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
              //print("✏️ [DustbinPage] Attempting to update dustbin: ID=${idController.text}, Location=${locationController.text}");

              try {
                await RestClient.updateEmployee({
                  "Card_ID": idController,
                  "Employee_Name": empNameController,
                  "Department": departmentController,
                  "Designation": departmentController,
                  "Email_ID": emailController,
                });
                Get.snackbar("Success", "Dustbin updated successfully!",
                    backgroundColor: Colors.black,
                    colorText: Colors.greenAccent,
                    snackPosition: SnackPosition.TOP);
                userList();
                //UserListInArrayEmp(); // Refresh the list
                Get.back();
              } catch (e) {
                Get.snackbar("Error", "Failed to update dustbin: $e",
                    backgroundColor: Colors.black,
                    colorText: Colors.redAccent,
                    snackPosition: SnackPosition.TOP);
              }
              setState(() {
                cardId["card_id"] = idController.text.trim();
                cardId["email"] = emailController.text.trim();
                cardId["emp_name"] = empNameController.text.trim();
                cardId["department"] = departmentController.text.trim();
                cardId["designation"] = designationController.text.trim();

                print("Updated cardId: $cardId"); // Log updated data
              });
              Get.back(); // Close the dialog
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
//manage Dusbtbin Access :
  void manageAccessDustbin(String dustbinId) async {
    List<AllAccessBlockListInObj> employeeList = [];
    TextEditingController dustbinIdController =
    TextEditingController(text: dustbinId);
    Map<String, bool> selectedEmployees = {};

    try {
      employeeList =
      await RestClient.getFetchDustbinListInObj({"dustbin_id": dustbinId});
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
                      padding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("Card_ID",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text("Employee_Name",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text("Department",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text("Designation",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text("Dustbin_Id",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 2,
                              child: Text("Location",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 1,
                              child: Text("Select",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: employeeList.length,
                      itemBuilder: (context, index) {
                        final emp =
                            employeeList[index].dustbinAssignments ?? [];
                        return Column(
                          children: emp.map((log) {
                            selectedEmployees[log.cardId ?? "UNKNOWN"] =
                                selectedEmployees[log.cardId ?? "UNKNOWN"] ??
                                    false;
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: CheckboxListTile(
                                checkColor: Colors.black,
                                title: Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text(log.cardId ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 3,
                                        child: Text(log.empName ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 3,
                                        child:
                                        Text(log.department ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 3,
                                        child:
                                        Text(log.designation ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 3,
                                        child:
                                        Text(log.dustbinId ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 2,
                                        child: Text(log.location ?? "UNKNOWN")),
                                  ],
                                ),
                                value:
                                selectedEmployees[log.cardId ?? "UNKNOWN"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    selectedEmployees[log.cardId ?? "UNKNOWN"] =
                                        value ?? false;
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
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                  onPressed: () => Get.back(),
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
              // block All Access Button:
              SizedBox(
                child: ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                  onPressed: () async {
                    List<String> selectedCardIds = selectedEmployees.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();

                    if (selectedCardIds.isNotEmpty) {
                      for (var cardId in selectedCardIds) {
                        try {
                          Map<String, dynamic> response =
                          await RestClient.getManageAccessListInObj({
                            "card_id": cardId,
                            "action": "block",
                          });
                          print(
                              "Response for Card ID $cardId: ${response["msg"]}");
                          Get.snackbar("Access Management", response["msg"],
                              snackPosition: SnackPosition.TOP);
                        } catch (e) {
                          print(
                              "Error blocking access for Card ID $cardId: $e");
                        }
                      }
                    } else {
                      Get.snackbar("Access Management", "No Employee Selected",
                          snackPosition: SnackPosition.TOP);
                    }
                    Get.back();
                    //refresh the list Data
                    employeeList;
                  },
                  child: Text(
                    'Block All Access',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
              // Allow All Access Button:
              SizedBox(
                child: ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                  onPressed: () async {
                    List<String> selectedCardIds = selectedEmployees.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();

                    if (selectedCardIds.isNotEmpty) {
                      for (var cardId in selectedCardIds) {
                        try {
                          Map<String, dynamic> response =
                          await RestClient.getManageAccessListInObj({
                            "card_id": cardId,
                            "action": "allow",
                          });
                          print(
                              "Response for Card ID $cardId: ${response["msg"]}");
                          Get.snackbar("Access Management", response["msg"],
                              snackPosition: SnackPosition.TOP);
                        } catch (e) {
                          print(
                              "Error allowing all  access for Card ID $cardId: $e");
                        }
                      }
                    } else {
                      Get.snackbar("Access Management", "No Employee Selected",
                          snackPosition: SnackPosition.TOP);
                    }
                    Get.back();
                    //refresh the list Data
                    employeeList;
                  },
                  child: Text(
                    'Allow All Access',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
// remove Dustbin Access :
  void removeAccessDustbin(String dustbinId) async {
    List<AllAccessBlockListInObj> employeeList = [];
    TextEditingController dustbinIdController =
    TextEditingController(text: dustbinId);
    Map<String, bool> selectedEmployees = {};

    try {
      employeeList =
      await RestClient.getFetchDustbinListInObj({"dustbin_id": dustbinId});
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
                      padding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("Card_ID",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text("Employee_Name",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold))),
                          /*Expanded(flex: 3, child: Text("Department", style: TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 3, child: Text("Designation", style: TextStyle(fontWeight: FontWeight.bold))),*/
                          Expanded(
                              flex: 3,
                              child: Text("Dustbin_Id",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 2,
                              child: Text("Location",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 1,
                              child: Text("Select",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: employeeList.length,
                      itemBuilder: (context, index) {
                        final emp =
                            employeeList[index].dustbinAssignments ?? [];
                        return Column(
                          children: emp.map((log) {
                            selectedEmployees[log.cardId ?? "UNKNOWN"] =
                                selectedEmployees[log.cardId ?? "UNKNOWN"] ??
                                    false;
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: CheckboxListTile(
                                checkColor: Colors.black,
                                title: Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text(log.cardId ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 3,
                                        child: Text(log.empName ?? "UNKNOWN")),
                                    /*        Expanded(flex: 3, child: Text(log.department ?? "UNKNOWN")),
                                    Expanded(flex: 3, child: Text(log.designation ?? "UNKNOWN")),*/
                                    Expanded(
                                        flex: 3,
                                        child:
                                        Text(log.dustbinId ?? "UNKNOWN")),
                                    Expanded(
                                        flex: 2,
                                        child: Text(log.location ?? "UNKNOWN")),
                                  ],
                                ),
                                value:
                                selectedEmployees[log.cardId ?? "UNKNOWN"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    selectedEmployees[log.cardId ?? "UNKNOWN"] =
                                        value ?? false;
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
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                  onPressed: () => Get.back(),
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
              // block All Access Button:
              SizedBox(
                child: ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                  onPressed: () async {
                    List<String> selectedCardIds = selectedEmployees.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();

                    if (selectedCardIds.isNotEmpty) {
                      for (var cardId in selectedCardIds) {
                        try {
                          Map<String, dynamic> response =
                          await RestClient.removeAccessDB({
                            "card_id": cardId,
                            "dustbin_id": dustbinId,
                          });
                          print("Response for Card ID $cardId: ${response}");
                          Get.snackbar("Access Management", response["msg"],
                              snackPosition: SnackPosition.TOP);
                        } catch (e) {
                          print(
                              "Error removing access for Card ID $cardId: $e");
                        }
                      }
                    } else {
                      Get.snackbar("Access Management", "No Employee Selected",
                          snackPosition: SnackPosition.TOP);
                    }
                    Get.back();
                    //refresh the list Data
                    employeeList;
                  },
                  child: Text(
                    'Remove Access',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  // Method to Grant a dustbin
/*  void grantAccessDustbin(String cardId) {
    print(
        "grantAccessDustbin() called for dustbin ID: $cardId"); // Log method call

    TextEditingController cardIdController = TextEditingController();
    TextEditingController dustbinIdController =
    TextEditingController(text: cardId);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Grant Access  Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.max,
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
                    {"card_id": cardId, "dustbin_id": dustbinId});
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
  }*/
  //--------------new---------------------//
  Future<void> grantAccessDustbin(String cardId) async {
    print("grantAccessDustbin() called for card ID: $cardId");

    List<DustBinListInArray> dustbinList = [];
    String? selectedDustbinId; // Stores the selected Dustbin ID

    try {
      dustbinList = await RestClient.getDustbinListInArray();
      print("Fetched Dustbins: ${dustbinList.length}");
    } catch (e) {
      print("❌ Error fetching dustbins: $e");
      Get.snackbar("Error", "Failed to fetch dustbins.");
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Grant Access to Dustbin'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Select a Dustbin grant access for Employee: $cardId'),
                  SizedBox(height: 10),

                  Container(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Table Headers
                        Container(
                          color: Colors.grey[300],
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text("Dustbin ID", style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(
                                  flex: 3,
                                  child: Text("Location", style: TextStyle(fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),

                        // Dustbin List with Checkboxes
                        Container(
                          height: 300, // Set max height for scrollability
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: dustbinList.length,
                            itemBuilder: (context, index) {
                              final dustbin = dustbinList[index];
                              return Card(
                                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: CheckboxListTile(
                                  checkColor: Colors.black,
                                  title: Row(
                                    children: [
                                      Expanded(flex: 2, child: Text(dustbin.dustbinId ?? "UNKNOWN")),
                                      Expanded(flex: 3, child: Text(dustbin.location ?? "UNKNOWN")),
                                    ],
                                  ),
                                  value: selectedDustbinId == dustbin.dustbinId,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      selectedDustbinId = value == true ? dustbin.dustbinId : null;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (selectedDustbinId == null) {
                      print("❌ Please select a dustbin.");
                      Get.snackbar("Error", "Please select a dustbin.");
                      return;
                    }

                    print("✅ Granting Access: Card ID=$cardId, Dustbin ID=$selectedDustbinId");

                    try {
                      await RestClient.grantAccessDB({
                        "card_id": cardId,
                        "dustbin_id": selectedDustbinId
                      });
                      print("✅ Dustbin Access Granted Successfully!");
                      Get.snackbar("Success", "Dustbin Access Granted Successfully!");
                      Get.back(); // Close dialog
                    } catch (e) {
                      print("❌ Failed to grant access: $e");
                      Get.snackbar("Error", "Failed to grant access: $e");
                    }
                  },
                  child: Text('Grant Access'),
                ),
              ],
            );
          },
        );
      },
    );
  }



  void initState() {
    super.initState();
    userList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2697FF),
        title: Text("Employees",style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [

        ],
      ),
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
                              child: Text('Dustbin Id',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text('Email',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 2,
                              child: Text('Role',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 2,
                              child: Text('Action',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),

                    // Data in List
                    Expanded(
                      child: ListView.builder(
                        itemCount: userListInArray.length,
                        itemBuilder: (context, index) {
                          var data = userListInArray[index];
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
                                    flex: 2, child: Text(data.cardId ?? "")),
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
                                    flex: 3,
                                    child: Text(data.email ?? "Unknown")),
                                Expanded(
                                    flex: 2,
                                    child: Text(data.role ?? "Unknown")),
                                Expanded(
                                  flex: 2,
                                  child: PopupMenuButton<String>(
                                    icon: const Icon(Icons.more_vert,
                                        color: Colors.black),
                                    onSelected: (value) {
                                      if (value == 'manage Dustbin') {
                                        log("Edit option selected for: ${data.empName}");
                                        manageAccessDustbin(data.dustbinId.toString());
                                        //editDustbin();
                                      } else if (value == 'manage') {
                                        log("manage Assign  option selected for: ${data.empName}");
                                        manageRole(data.email.toString(),
                                            data.role.toString());
                                      } else if (value == 'remove Dustbin') {
                                        log("manage Assign  option selected for: ${data.empName}");
                                  removeAccessDustbin(data.dustbinId.toString());
                                      } else if (value == 'Access Dustbin') {
                                        log("manage Assign  option selected for: ${data.empName}");
                                 grantAccessDustbin(data.cardId.toString());
                                      }
                                    },
                                    itemBuilder: (context) => const [
                                      /* PopupMenuItem(
                                          value: 'edit',
                                          child: Text('Edit Details')),*/
                                      PopupMenuItem(
                                          value: 'manage',
                                          child: Text('Manage Access')),
                                      PopupMenuItem(
                                          value: 'manage Dustbin',
                                          child: Text('Manage Dustbin')),
                                      PopupMenuItem(
                                          value: 'Access Dustbin',
                                          child: Text('Access Dustbin')),
                                      PopupMenuItem(
                                          value: 'remove Dustbin',
                                          child: Text('Remove Dustbin')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Add new button:
                    FloatingActionButton(

                      onPressed: () => addNewEmployee(),
                      backgroundColor: Colors.deepPurpleAccent,
                      hoverColor: Colors.greenAccent,
                      elevation: 10,
                      splashColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Custom Rounded Shape
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30, // Icon Size
                      ),
                      tooltip: 'Add New Employee',
                    ),
                      FooterWidget(),                  ],
                ),
    );

  }
}

/* 2.
import 'package:Deprofiz/controllers/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeePage extends StatefulWidget {
  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final EmployeeController employeeController = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employees')),
      body: Obx(() => ListView(
            children: employeeController.employees.map((employees) {
              return BuildEmployeeTile(context, employees as String);
            }).toList(),
          )),
    );
  }

  Widget BuildEmployeeTile(BuildContext context, String employeeName) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(employeeName),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => showUpdateDialog(context, employeeName),
              icon: Icon(Icons.edit, color: Colors.greenAccent),
            ),
            IconButton(
              onPressed: () => showDeleteDialog(context, employeeName),
              icon: Icon(Icons.delete, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }

  void showUpdateDialog(BuildContext context, String employeeName) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update $employeeName'),
            content: Text('What would you like to update for $employeeName?'),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
              TextButton(onPressed: () => Get.back(), child: Text("Update")),
            ],
          );
        });
  }

  void showDeleteDialog(BuildContext context, String employeeName) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete $employeeName"),
            content: Text("Are you sure you want to delete $employeeName?"),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
              TextButton(
                onPressed: () {
                  employeeController.removeEmployee(employeeName);
                  Get.back();
                },
                child: Text("Delete"),
              ),
            ],
          );
        });
  }
}
*/

/*
//static data with employee Screen
import 'package:Deprofiz/controllers/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeePage extends StatefulWidget {
  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final EmployeeController employeeController = Get.put(EmployeeController());

  void addNewEmployee() {
    String newCardID = '';
    String newEmployeeName = '';
    String newDepartment = '';
    String newDesignation = '';
    String newEmail = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Dustbin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Card ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0), // Square corners
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(0.0), // Square corners when focused
                  borderSide: BorderSide(
                    color: Colors.blue, // Customize the color if needed
                    width: 2.0, // Customize the border width
                  ),
                ),
              ),
              onChanged: (value) => newCardID = value.trim(),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Employee Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0), // Square corners
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(0.0), // Square corners when focused
                  borderSide: BorderSide(
                    color: Colors.blue, // Customize the color if needed
                    width: 2.0, // Customize the border width
                  ),
                ),
              ),
              onChanged: (value) => newEmployeeName = value.trim(),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Department',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0), // Square corners
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(0.0), // Square corners when focused
                  borderSide: BorderSide(
                    color: Colors.blue, // Customize the color if needed
                    width: 2.0, // Customize the border width
                  ),
                ),
              ),
              onChanged: (value) => newDepartment = value.trim(),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Designation',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0), // Square corners
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(0.0), // Square corners when focused
                  borderSide: BorderSide(
                    color: Colors.blue, // Customize the color if needed
                    width: 2.0, // Customize the border width
                  ),
                ),
              ),
              onChanged: (value) => newDesignation = value.trim(),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0), // Square corners
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(0.0), // Square corners when focused
                  borderSide: BorderSide(
                    color: Colors.blue, // Customize the color if needed
                    width: 2.0, // Customize the border width
                  ),
                ),
              ),
              onChanged: (value) => newEmail = value.trim(),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              SizedBox(
                width: 100,
              ),
              TextButton(
                onPressed: () {
                  if (newCardID.isNotEmpty &&
                      newDepartment.isNotEmpty &&
                      newEmployeeName.isNotEmpty &&
                      newDesignation.isNotEmpty &&
                      newEmail.isNotEmpty) {
                    employeeController.addEmployee(newCardID, newEmployeeName,
                        newDepartment, newDesignation, newEmail);
                    print(
                        "Adding Employee: $newCardID, $newEmployeeName, $newDepartment, $newDesignation, $newEmail");

                    Get.back();
                  } else {
                    Get.snackbar("Error", "Please fill all fields.",
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.black);
                    print("Please fill all fields."); // Debug Log
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Employees'),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: addNewEmployee,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 8),
                    Text("Add New Employee",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Header row
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 2, child: Text("Card ID", style: headerTextStyle())),
                Expanded(
                    flex: 3,
                    child: Text("Employee Name", style: headerTextStyle())),
                Expanded(
                    flex: 3,
                    child: Text("Department", style: headerTextStyle())),
                Expanded(
                    flex: 4,
                    child: Text("Designation", style: headerTextStyle())),
                Expanded(
                    flex: 2, child: Text("Email", style: headerTextStyle())),
                Expanded(
                  flex: 1,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text("Action", style: headerTextStyle()),
                  ]),
                ),
              ],
            ),
          ),
          // Employee list
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: employeeController.employees.length,
                  itemBuilder: (context, index) {
                    final employeeData = employeeController.employees[index];
                    return BuildEmployeeTile(
                      context,
                      employeeData['Card ID'] ?? '',
                      employeeData['Employee Name'] ?? '',
                      employeeData['Department'] ?? '',
                      employeeData['Designation'] ?? '',
                      employeeData['Email'] ?? '',
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  TextStyle headerTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.black,
    );
  }

  Widget BuildEmployeeTile(BuildContext context, String cardId, String name,
      String department, String designation, String email) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 2, child: Text(cardId)),
            Expanded(flex: 3, child: Text(name)),
            Expanded(flex: 3, child: Text(department)),
            Expanded(flex: 4, child: Text(designation)),
            Expanded(flex: 2, child: Text(email)),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.black54),
                  onPressed: () => showActionMenu(context, name),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showActionMenu(BuildContext context, String employeeName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Actions for $employeeName'),
          content: Column(
            mainAxisSize:
                MainAxisSize.min, // Ensures the dialog fits the content
            children: [
              ListTile(
                leading: Icon(Icons.edit, color: Colors.greenAccent),
                title: Text("Edit"),
                onTap: () {
                  Get.back(); // Close the dialog
                  showUpdateDialog(
                      context, employeeName); // Call the update dialog
                },
              ),
              ListTile(
                leading: Icon(Icons.key_sharp, color: Colors.blueAccent),
                title: Text("Manage Access"),
                onTap: () {
                  Get.back(); // Close the dialog
                
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.redAccent),
                title: Text("Delete"),
                onTap: () {
                  Get.back(); // Close the dialog
                  showDeleteDialog(
                      context, employeeName); // Call the delete dialog
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog without any action
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void showUpdateDialog(BuildContext context, String employeeName) {
    // Find the employee data from the list
    final employeeData = employeeController.employees.firstWhere(
      (employee) => employee["Employee Name"] == employeeName,
      orElse: () => {},
    );

    // Controllers to hold the current values of the employee data
    TextEditingController cardIdController =
        TextEditingController(text: employeeData["Card ID"] ?? '');
    TextEditingController nameController =
        TextEditingController(text: employeeData["Employee Name"] ?? '');
    TextEditingController departmentController =
        TextEditingController(text: employeeData["Department"] ?? '');
    TextEditingController designationController =
        TextEditingController(text: employeeData["Designation"] ?? '');
    TextEditingController emailController =
        TextEditingController(text: employeeData["Email"] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update $employeeName'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: cardIdController,
                  decoration: InputDecoration(
                    labelText: 'Card ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Employee Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: departmentController,
                  decoration: InputDecoration(
                    labelText: 'Department',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: designationController,
                  decoration: InputDecoration(
                    labelText: 'Designation',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Update the employee data in the controller
                employeeController.employees[employeeController.employees
                    .indexWhere(
                        (emp) => emp["Employee Name"] == employeeName)] = {
                  "Card ID": cardIdController.text.trim(),
                  "Employee Name": nameController.text.trim(),
                  "Department": departmentController.text.trim(),
                  "Designation": designationController.text.trim(),
                  "Email": emailController.text.trim(),
                };

                // Close the dialog
                Get.back();
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context, String employeeName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete $employeeName"),
          content: Text("Are you sure you want to delete $employeeName?"),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
            TextButton(
              onPressed: () {
                employeeController.removeEmployee(employeeName);
                Get.back();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
*/
