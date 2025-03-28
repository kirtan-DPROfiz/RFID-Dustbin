/*
import 'package:get/get.dart';

class EmployeeController extends GetxController {
  // Reactive list for employees
  var employees = <Map<String, String>>[].obs;

  // Reactive count of employees
  var employeeCount = 0.obs;

  @override
  void onInit() {
    // Initialize the employee list with default values
    employees.addAll([
      {
        "Card ID": "C0012",
        "Employee Name": "jone",
        " Department": " IT",
        "Designation ": "employee",
      },
      {
        "Card ID": "C0013",
        "Employee Name": "jone",
        " Department": " IT",
        "Designation ": "employee",
      },
      {
        "Card ID": "C001",
        "Employee Name": "jone",
        " Department": " IT",
        "Designation ": "employee",
      },
      {
        "Card ID": "C002",
        "Employee Name": "jone",
        " Department": " IT",
        "Designation ": "employee",
      },
      {
        "Card ID": "C003",
        "Employee Name": "jone",
        " Department": " IT",
        "Designation ": "employee",
      },
      {
        "Card ID": "C004",
        "Employee Name": "jone",
        " Department": " IT",
        "Designation ": "employee",
      },
    ]);

    ///employeeCount.value = employees.length;

    // Set the initial count of employees
    // _updateEmployeeCount();
    super.onInit();
  }

  // Helper function to update employee count
  void _updateEmployeeCount() {
    employeeCount.value = employees.length;
  }

  // Add a new employee to the list
  void addEmployee(String cardID, String employeeName, String department,
      String designation, String email) {
    employees.add({
      "CardID": cardID,
      "EmployeeName": employeeName,
      "Department": department,
      "Designation": designation,
      "Email": email
    });
    print(employees);
    _updateEmployeeCount();
  }

  // Remove an employee from the list
  void removeEmployee(String employee) {
    employees.remove(employees);
    print(employees);
    _updateEmployeeCount();
  }
}
*/



/*import 'package:get/get.dart';

class EmployeeController extends GetxController {
  // Observable list to store employees
  var employees = <Map<String, String>>[].obs;
  var employeeCount = 0.obs;

  void onInit() {
    // Initialize the employee list with default values
    employees.addAll([
      {
        "Card ID": "C0012",
        "Employee Name": "jone",
        " Department": " IT",
        "Designation ": "employee",
        "Email": "jone@gmail.com",
      },
      {
        "Card ID": "C0013",
        "Employee Name": "jone",
        " Department": " IT",
        "Designation ": "employee",
        "Email": "jone@gmail.com",
      },
      {
        "Card ID": "C001",
        "Employee Name": "jone",
        " Department": " IT",
        "Designation ": "employee",
        "Email": "jone@gmail.com",
      },
      {
        "Card ID": "C002",
        "Employee Name": "jone",
        " Department": " IT",
        "Designation ": "employee",
        "Email": "jone@gmail.com",
      },
      {
        "Card ID": "C003",
        "Employee Name": "jone",
        " Department": " IT",
        "Designation ": "employee",
        "Email": "jone@gmail.com",
      },
      {
        "Card ID": "C004",
        "Employee Name": "jone",
        " Department": " IT",
        "Designation ": "employee",
        "Email": "jone@gmail.com",
      },
      {
        "Card ID": "C0012",
        "Employee Name": "John",
        "Department": "IT",
        "Designation": "Employee",
        "Email": "john@gmail.com",
      },
      {
        "Card ID": "C0013",
        "Employee Name": "Jane",
        "Department": "HR",
        "Designation": "Manager",
        "Email": "jane@gmail.com",
      },
    ]);

    employeeCount.value = employees.length;

    // Set the initial count of employees
    // _updateEmployeeCount();
    super.onInit();
  }

  /// Function to add a new employee
  void addEmployee(String cardId, String employeename, String department,
      String designation, String email) {
    print(
        "Adding Employee: $cardId, $employeename, $department, $designation, $email"); // Debug Log

    employees.add({
      "Card ID": cardId,
      "Employee Name": employeename,
      "Department": department, // Fixed the key name (removed extra space)
      "Designation": designation, // Fixed the key name (removed extra space)
      "Email": email,
    });

    print("Updated Employee List: $employees"); // Debug Log
  }

  /// Function to remove an employee by name
  void removeEmployee(String employeeName) {
    print("Removing Employee: $employeeName"); // Debug Log

    employees
        .removeWhere((employee) => employee["Employee Name"] == employeeName);

    print("Updated Employee List After Deletion: $employees"); // Debug Log
  }
}*/


import 'package:Deprofiz/models/api_models/user_list_in_Array_emp.dart';
import 'package:get/get.dart';

import '../network manager/rest_client.dart';

import 'dart:developer';


class EmployeeController extends GetxController {

  var errorMessage = "".obs;
  var userListInarray = <UserListInArrayEmp>[].obs;
  var employeeCount = 0.obs;

  @override
  void onInit() {
    userList();
    super.onInit();
  }
  // Fetch dustbin data from the API
  void userList() async {
    print("➡️ [DustbinPage] Starting fetchDustbins...");
    try {
      final value = await RestClient.getUserListInArray();
      log("✅ [DustbinPage] API Response: $value");

      if (value.isEmpty) {
        log("⚠️ [DustbinPage] API returned an empty list.");
        errorMessage.value = "No data found.";
      } else {
        log("📊 [DustbinPage] API returned data: ${value.length} items");
        userListInarray.value = value ?? [];
        employeeCount.value = userListInarray.length;
      }
    } catch (error) {
      log("❌ [DustbinPage] Error fetching API data: $error");
      errorMessage.value = "Failed to load data. Please check your network or try again.";
    } finally {
      print("Execution complete !");

    }
  }
}

