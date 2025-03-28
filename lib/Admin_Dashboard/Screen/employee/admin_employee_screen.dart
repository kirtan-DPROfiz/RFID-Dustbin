import 'dart:developer';
import 'package:Deprofiz/network%20manager/rest_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/api_models/user_list_in_Array_emp.dart';


class AdminEmployeePageScreen extends StatefulWidget {
  const AdminEmployeePageScreen({super.key});

  @override
  State<AdminEmployeePageScreen> createState() => _AdminEmployeePageScreenState();
}

class _AdminEmployeePageScreenState extends State<AdminEmployeePageScreen> {
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

  void addNewEmployee() {
    print("addNewEmployee() called"); // Log for method invocation
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
                        "Card_ID": newCardID,
                        "Employee_Name": newEmployeeName,
                        "Department": newDepartment,
                        "Designation": newDesignation,
                        "Email_ID": newEmail,
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
    );
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




  // Method to edit an existing dustbin
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

  void initState() {
    super.initState();
    userList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            if (value == 'edit') {
                              log("Edit option selected for: ${data.empName}");
                              //editDustbin();
                            } else if (value == 'manage') {
                              log("manage Assign  option selected for: ${data.empName}");
                              manageRole(data.email.toString(),
                                  data.role.toString());
                            }
                          },
                          itemBuilder: (context) => const [
                            /* PopupMenuItem(
                                          value: 'edit',
                                          child: Text('Edit Details')),*/
                            PopupMenuItem(
                                value: 'manage',
                                child: Text('Manage Access')),
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
              BorderRadius.circular(0), // Custom Rounded Shape
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30, // Icon Size
            ),
            tooltip: 'Add New Employee',
          ),
        ],
      ),
    );
  }
}
