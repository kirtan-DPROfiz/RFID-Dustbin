/*
import 'package:Deprofiz/models/my_files.dart';
import 'package:Deprofiz/responsive.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text(
            //   "My Files",
            //   style: Theme.of(context).textTheme.titleMedium,
            // ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Color(
                    0xFF00BFAE), // Modern teal color for "Add New Employee"
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.add,
                  color: Colors.white), // White icon for better contrast
              label: Text(
                "Add New Employee",
                style: TextStyle(
                  color: Colors.white, // White text color for the label
                  fontWeight:
                      FontWeight.w500, // Slightly bolder text for a modern look
                ),
              ),
            ),
            SizedBox(
                width: defaultPadding), // Add spacing between buttons if needed
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Color(
                    0xFF00BFAE), // Modern blue color for "Add New Dustbin"
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.add,
                  color: Colors.white), // White icon for better contrast
              label: Text(
                "Add New Dustbin",
                style: TextStyle(
                  color: Colors.white, // White text color for the label
                  fontWeight:
                      FontWeight.w500, // Slightly bolder text for a modern look
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}
*/

import 'package:Deprofiz/constants.dart';
import 'package:Deprofiz/controllers/dustbin_controller.dart';
import 'package:Deprofiz/controllers/employee_controller.dart';
import 'package:Deprofiz/models/my_files.dart';
import 'package:Deprofiz/responsive.dart';
import 'package:Deprofiz/screens/dashboard/components/file_info_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../network manager/rest_client.dart';
import '../../../../screens/dashboard/components/my_fields.dart';
import 'admin_file_info_card.dart';
import 'admina_my_files.dart';


class AdminMyFiles extends StatelessWidget {
   AdminMyFiles({
    Key? key,
  }) : super(key: key);

  // Ensure the controllers are initialized
  final EmployeeController adminemployeeController = Get.put(EmployeeController());
  final DustbinController admindustbinController = Get.put(DustbinController());



  void addNewEmployee(dynamic context) {
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
                      adminemployeeController.userListInarray;// Refresh the list
                      Get.back();
                    } catch (e) {
                      Get.snackbar("Success", "Employee added successfully!",
                          backgroundColor: Colors.black,
                          colorText: Colors.greenAccent,
                          snackPosition: SnackPosition.TOP);
                     /* Get.snackbar("Error", "Failed to add Employee: $e",
                          backgroundColor: Colors.black,
                          colorText: Colors.redAccent,
                          snackPosition: SnackPosition.TOP);*/
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

  // Method to add a new dustbin using API
  void addNewDustbin(dynamic context) {
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
                  admindustbinController.fetchDustbins();
                  //fetchDustbins(); // Refresh the list
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



            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF00BFAE),
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                  defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // Handle "Add New Employee"
                addNewEmployee(context);
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text(
                "Add New Employee",
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF00BFAE),
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                  defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // Handle "Add New Dustbin"
                addNewDustbin(context);
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text(
                "Add New Dustbin",
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: AdminFileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 4 : 2,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 2,// childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: AdminFileInfoCardGridView(),
          desktop: AdminFileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 2 :2,// childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class AdminFileInfoCardGridView extends StatelessWidget {
  const AdminFileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: admindemoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => AdminFileInfoCard(info: admindemoMyFiles[index]),
    );
  }
}
