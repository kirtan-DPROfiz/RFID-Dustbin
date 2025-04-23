//import 'package:http_clear_architec/models/post_api_model.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:js_interop';

//import 'package:Deprofiz/models/api_models/user_list_in_Obj.dart';
import 'package:Deprofiz/models/api_models/All_Access_Block_List_In_Obj.dart';
import 'package:Deprofiz/models/api_models/Audit_list_in_obj_array.dart';
import 'package:Deprofiz/models/api_models/dustbin_access_list_in_obj.dart';
import 'package:Deprofiz/models/api_models/dustbin_list_in_array.dart';
import 'package:Deprofiz/models/api_models/log_List_in_obj.dart';
import 'package:Deprofiz/models/api_models/profileListInArray.dart';
import 'package:Deprofiz/network%20manager/http_helper.dart';
import 'package:http/http.dart' as http;
import '../models/api_models/export_alllogs_list_in_obj.dart';
import '../models/api_models/export_dustbin_list_in_obj.dart';
import '../models/api_models/export_emp_list_in_obj.dart';
import '../models/api_models/user_list_in_Array_emp.dart';



class RestClient {
  static final HttpHelper httpHelper = HttpHelper();

 // static const String baseurl = "https://intervein.dprofiz.com";

/*// Authentication for login:
  static Future<dynamic> login() async {
    print("Fetching data from API..."); // Debugging log
    Map<String, dynamic> response = await httpHelper.post(
      url: '$baseurl/Rfid_api/Auth/login.php',
    );
    print("API Response: $response"); // Debugging log
    return response;
  }*/

// get data in object:

// Dustbin : fetch the Accessdata:
  static Future<List<DustbinAccessListInObj>> getDustbinAccessListInObj() async {
    print("Starting getDustbinAccessListInObjDB...");
    try {
      const String apiUrl =
          "https://intervein.dprofiz.com/Rfid_api/Dustbin/fetch_dustbin_assignments.php";
      print("Fetching data from API: $apiUrl");

      // Call httpHelper.get
      Map<String, dynamic> response = await httpHelper.get(
        url: apiUrl,
        isRequireAuthorization: true,
      );
      print("API request completed. Response received.");
      print("API Response: $response");

      if (response['assignments'] != null) {
        List<DustbinAccessListInObj> data = [];
        response['assignments'].forEach((v) {
          data.add(DustbinAccessListInObj.fromJson({'assignments': [v]}));
        });
        print("Parsed Data: $data");
        return data;
      } else {
        print("No assignments found in the response.");
        return [];
      }
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print("Stack trace: $stackTrace");
      throw Exception("Error fetching data: $e");
    }
  }

  // 5.ExportData : fetch EmpWise data
  /*static Future<List<ExportEmpListInObj>> getEmpWiseListInObj() async {
    print("Starting getEmpWiseListInObj...");
    try {
      const String apiUrl =
          "https://intervein.dprofiz.com/Rfid_api/Logs/export_employee_logs_pdf.php";
      print("Fetching data from API: $apiUrl");

      // Call httpHelper.get
      Map<String, dynamic> response = await httpHelper.get(
        url: apiUrl,
        isRequireAuthorization: true,
      );
      print("API request completed. Response received.");
      print("API Response: $response");

      if (response['scan_logs'] != null) {
        List<ExportEmpListInObj> data = [];
        response['scan_logs'].forEach((v) {
          data.add(ExportEmpListInObj.fromJson({'scan_logs': [v]}));
        });
        print("Parsed Data: $data");
        return data;
      } else {
        print("No scan logs found in the response.");
        return [];
      }
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print("Stack trace: $stackTrace");
      throw Exception("Error fetching data: $e");
    }
  }
*/
  static Future<List<ExportEmpListInObj>> getEmpWiseListInObj(Map<String, dynamic> requestBody) async {
    print("Starting getEmpWiseListInObj with Card ID: ${requestBody['card_id']}");
    try {
      const String apiUrl = "https://intervein.dprofiz.com/Rfid_api/Logs/export_employee_logs_pdf.php";
      print("🔍 [RestClient] Sending POST request to: $apiUrl");
      print("📤 [RestClient] Request Body: $requestBody");
      print("📤 [RestClient] Final Request Body: ${json.encode(requestBody)}");


      Map<String, dynamic> response = await httpHelper.post(
        url: apiUrl,
        isRequireAuthorization: true,
        requestBody: json.encode(requestBody),
      );

      print("✅ [RestClient] API request completed. Status code: ${response['status_code'] ?? 'Unknown'}");
      print("📥 [RestClient] Response body: ${response}");

      if (response['scan_logs'] != null) {
        List<ExportEmpListInObj> data = [];
        response['scan_logs'].forEach((v) {
          data.add(ExportEmpListInObj.fromJson({'scan_logs': [v]}));
        });
        print("📌 [RestClient] Total Scan Logs Fetched: ${data.length}");
        return data;
      } else {
        print("⚠️ [RestClient] No scan logs found in the response.");
        return [];
      }
    } catch (e) {
      print("❌ [RestClient] Error fetching data: $e");
      throw Exception("Error fetching data: $e");
    }
  }
  // ExportData : DustbinWise data
  static Future<List<ExportDustbinListInObj>> getDustbinWiseListInObj(Map<String, dynamic> requestBody) async {
    print("Starting getDustbinWiseListInObj...");
    try {
      const String apiUrl =
          "https://intervein.dprofiz.com/Rfid_api/Logs/export_dustbin_logs_pdf.php";
      print("Fetching data from API: $apiUrl");
      print("📤 [RestClient] Request Body: $requestBody");
      print("📤 [RestClient] Final Request Body: ${json.encode(requestBody)}");

      // Call httpHelper.get
      Map<String, dynamic> response = await httpHelper.post(
        url: apiUrl,
        isRequireAuthorization: true,
        requestBody:  json.encode(requestBody),
      );
      print("API request completed. Response received.");
      print("API Response: $response");

      if (response['scan_logs'] != null) {
        List<ExportDustbinListInObj> data = [];
        response['scan_logs'].forEach((v) {
          data.add(ExportDustbinListInObj.fromJson({'scan_logs': [v]}));
        });
        print("Parsed Data: $data");
        return data;
      } else {
        print("No assignments found in the response.");
        return [];
      }
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print("Stack trace: $stackTrace");
      throw Exception("Error fetching data: $e");
    }
  }
  // ExportData : All Logs data
  static Future<List<ExportAllLogsListInObj>> getAllLogsListInObj() async {
    print("Starting getAllLogsListInObj...");
    try {
      const String apiUrl =
          "https://intervein.dprofiz.com/Rfid_api/Logs/export_logs_pdf.php";
      print("Fetching data from API: $apiUrl");

      // Call httpHelper.get
      Map<String, dynamic> response = await httpHelper.get(
        url: apiUrl,
        isRequireAuthorization: true,
      );
      print("API request completed. Response received.");
      print("API Response: $response");

      if (response['scan_logs'] != null) {
        List<ExportAllLogsListInObj> data = [];
        response['scan_logs'].forEach((v) {
          data.add(ExportAllLogsListInObj.fromJson({'scan_logs': [v]}));
        });
        print("Parsed Data: $data");
        return data;
      } else {
        print("No assignments found in the response.");
        return [];
      }
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print("Stack trace: $stackTrace");
      throw Exception("Error fetching data: $e");
    }
  }
  // Dustbin : ManageAccess Employee: All Access Allow and Block :
  static Future<Map<String, dynamic>> getManageAccessListInObj(Map<String, dynamic> requestBody) async {
    print("Starting getmanageAccessListInObj...");
    try {
      const String apiUrl =
          "https://intervein.dprofiz.com/Rfid_api/Dustbin/manage_access.php";
      print("Fetching response from API: $apiUrl");

      // Call httpHelper.get
      Map<String, dynamic> response = await httpHelper.post(
        url: apiUrl,
        isRequireAuthorization: true,
        requestBody: json.encode(requestBody),
      );
      print("API request completed. Response received.");
      print("API Response: $response");

      return response;
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print("Stack trace: $stackTrace");
      throw Exception("Error fetching data: $e");
    }
  }
// Dustbin : fetch dustbinId :
  static Future<List<AllAccessBlockListInObj>> getFetchDustbinListInObj(Map<String, dynamic> requestBody) async {
    print("Starting getFetchDustbinListInObj...");
    try {
      const String apiUrl =
          "https://intervein.dprofiz.com/Rfid_api/Dustbin/fetch_dustbin_assign.php";
      print("Fetching response from API: $apiUrl");

      // Call API with requestBody
      Map<String, dynamic> response = await httpHelper.post(
        url: apiUrl,
        isRequireAuthorization: true,
        requestBody: json.encode(requestBody),
      );

      print("API request completed. Response received.");
      print("API Response: $response");

      List<AllAccessBlockListInObj> data = [];

      if (response['dustbin_assignments'] != null && response['dustbin_assignments'] is List) {
        // Parse each item in the response
        response['dustbin_assignments'].forEach((v) {
          data.add(AllAccessBlockListInObj.fromJson({'dustbin_assignments': [v]}));
        });
        print("Parsed Data Length: ${data.length}");
      } else {
        print("No assignments found or invalid format.");
      }

      return data;
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print("Stack trace: $stackTrace");
      throw Exception("Error fetching data: $e");
    }
  }
// Employee : manage role :
  static Future<Map<String, dynamic>> getManageAccessRole(Map<String, dynamic> requestBody) async {
    print("Starting getmanageAccessRole...");
    try {
      const String apiUrl =
          "https://intervein.dprofiz.com/Rfid_api/Employee/update_role.php";
      print("Fetching response from API: $apiUrl");

      // Call httpHelper.get
      Map<String, dynamic> response = await httpHelper.post(
        url: apiUrl,
        isRequireAuthorization: true,
        requestBody: json.encode(requestBody),
      );
      print("API request completed. Response received.");
      print("API Response: $response");

      return response;
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print("Stack trace: $stackTrace");
      throw Exception("Error fetching data: $e");
    }
  }


  // RFID Scan ID:
  static Future<void> rfidScan(Map<String, dynamic> requestBody) async {
    print("➡️ [RestClient] Starting RFIDScan...");

    try {
      final String apiUrl = "https://intervein.dprofiz.com/Rfid_api/Employee/insert_data.php";
      print("🌐 [RestClient] Adding Employee via API: $apiUrl");
      final response = await httpHelper.post(
        url: apiUrl,
        isRequireAuthorization: true,
        requestBody: json.encode(requestBody),
      );
      print("API request completed. Response received.");
      print("📥 [RestClient] API Response: $response");

      if (response != null && response['status'] == "success") {
        print("✅ Employee added successfully!");
      } else {
        print("❌ Failed to add Employee. Response: $response");
        throw Exception("Failed to add Employee");
      }
      // print("✅ [RestClient] API request completed. Status code: ${response
      //     .statusCode}");
      // print("📥 [RestClient] Response body: ${response.body}");
    } catch (e) {
      print("❌ [RestClient] Error adding Employee: $e");
      throw e;
    }
  }






//4.Audit : fetchdata :
/*  static Future<List<AuditLogs>> getAuditListInArray() async {
    print("Fetching data from API..."); // Debugging log
    const String apiUrl =
        "https://intervein.dprofiz.com/Rfid_api/Audit/fetch_audit_logs.php";
    print("Fetching data from API: $apiUrl");

// Call httpHelper.get
    final response = await httpHelper.get(
      url: apiUrl,
      isRequireAuthorization: true,
    );
    print("API request completed. Response received.");
    print("API Response: $response");

    print("API Response: ${response.body}"); // Debugging log

    if (response.statusCode == 200) {
      // Parse the JSON response
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      AuditListInArray auditListInArray = AuditListInArray.fromJson(
          jsonResponse);
      return auditListInArray.auditLogs ?? []; // Return the list of audit logs
    } else {
      throw Exception('Failed to load audit logs');
    }
  }*/
  //-------------------new ---------------------------//
  static Future<List<AuditListInObj>> getAuditListInObj() async {
    print("Starting getAuditListInObj...");
    try {
      const String apiUrl = "https://intervein.dprofiz.com/Rfid_api/Audit/fetch_audit_logs.php";
      print("Fetching data from API: $apiUrl");

      Map<String, dynamic> response = await httpHelper.get(
        url: apiUrl,
        isRequireAuthorization: true,
      );
      print("API Response: $response");
      if (response['audit_logs'] != null) {
        List<AuditListInObj> data = [];
        response['audit_logs'].forEach((v) {
          data.add(AuditListInObj.fromJson({'audit_logs': [v]}));
        });

     /* if (response['audit_logs'] != null) {
        List<AuditLogs> data = response['audit_logs'].map<AuditLogs>((v) {
          return AuditLogs.fromJson(v);
        }).toList();*/

        print("Parsed Data: $data");
        return data;
      } else {
        print("No audit logs found.");
        return [];
      }
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print("Stack trace: $stackTrace");
      throw Exception("Error fetching data: $e");
    }
  }



//get data in Array:

// 1. Employee : fetch data
  static Future<List<UserListInArrayEmp>> getUserListInArray() async {
    print("Starting getUserListInObj...");

    try {
      const String apiUrl =
          "https://intervein.dprofiz.com/Rfid_api/Employee/get_employee_details.php";
      print("Fetching data from API: $apiUrl");

      // Call httpHelper.get
      final response = await httpHelper.get(
        url: apiUrl,
        isRequireAuthorization: true,
      );
      print("API request completed. Response received.");

      // Log the response
      print("API Response: $response");

      // If the response is already a List<dynamic>, use it directly
      if (response is List<dynamic>) {
        print("Parsing response into List<UserListInObjEmp>...");
        return response.map((data) => UserListInArrayEmp.fromJson(data)).toList();
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print("Stack trace: $stackTrace");
      throw e;
    }
  }
  // Add a new dustbin
  static Future<void> addNewEmployee(Map<String, dynamic> requestBody) async {
    print("➡️ [RestClient] Starting addNewDustbin...");

    try {
      final String apiUrl = "https://intervein.dprofiz.com/Rfid_api/Employee/add_employee.php";
      print("🌐 [RestClient] Adding dustbin via API: $apiUrl");
      final response = await httpHelper.post(
        url: apiUrl,
        isRequireAuthorization: true,
        requestBody: json.encode(requestBody),
      );
      print("API request completed. Response received.");
      print("📥 [RestClient] API Response: $response");

      if (response != null && response['status'] == "success") {
        print("✅ Dustbin added successfully!");
      } else {
        print("❌ Failed to add dustbin. Response: $response");
        throw Exception("Failed to add dustbin");
      }
      // print("✅ [RestClient] API request completed. Status code: ${response
      //     .statusCode}");
      // print("📥 [RestClient] Response body: ${response.body}");
    } catch (e) {
      print("❌ [RestClient] Error adding dustbin: $e");
      throw e;
    }
  }
  // Update an existing Employee
  static Future<void> updateEmployee(Map<String, dynamic> requestBody) async {
    print("➡️ [RestClient] Starting updateDustbin...");

    try {
      final String apiUrl = "https://intervein.dprofiz.com/Rfid_api/Dustbin/update_dustbin.php";
      print("🌐 [RestClient] Updating dustbin via API: $apiUrl");

      final response = await httpHelper.put(
        url: apiUrl,
        isRequireAuthorization: true, requestBody: json.encode(requestBody),
      );


      print("API request completed. Response received.");

      print("✅ [RestClient] API request completed. Status code: ${response
          .statusCode}");
      print("📥 [RestClient] Response body: ${response.body}");

      if (response.statusCode != 200) {
        print("❌ [RestClient] Failed to update dustbin. Status code: ${response
            .statusCode}");
        throw Exception('Failed to update dustbin: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ [RestClient] Error updating dustbin: $e");
      throw e;
    }
  }

  // 2. Dustbin : fetch data
  static Future<List<DustBinListInArray>> getDustbinListInArray() async {
    print("Starting getUserListInObjDB...");
    try {
      const String apiUrl =
          "https://intervein.dprofiz.com/Rfid_api/Dustbin/fetch_dustbin.php";
      print("Fetching data from API: $apiUrl");

      // Call httpHelper.get
      final response = await httpHelper.get(
        url: apiUrl,
        isRequireAuthorization: true,
      );
      print("API request completed. Response received.");
      print("API Response: $response");

      if (response is List<dynamic>) {
        print("✅ [RestClient] API request completed. List received.");
        print("📥 [RestClient] Response data length: ${response.length}");
        return response.map((data) => DustBinListInArray.fromJson(data ?? {})).toList();
      } else if (response is http.Response) {
        print("❌ [RestClient] Response is of type Response. Decoding manually...");
        List<dynamic> data = json.decode(response.body);
        return data.map((data) => DustBinListInArray.fromJson(data ?? {})).toList();
      } else {
        print("❌ [RestClient] Unexpected response type: ${response.runtimeType}");
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print("Stack trace: $stackTrace");
      throw Exception("Error fetching data: $e");
    }
  }

  //Add new dustbin:
  /*static Future<void> addNewDustbin(Map<String, dynamic> requestBody) async {
    print("➡️ [RestClient] Starting addNewDustbin...");

    try {
      final String apiUrl = "https://intervein.dprofiz.com/Rfid_api/Dustbin/add_dustbin.php";
      print("🌐 [RestClient] Adding dustbin via API: $apiUrl");
      final response = await httpHelper.post(
        url: apiUrl,
        isRequireAuthorization: true,
        requestBody: json.encode(requestBody),
      );
      print("API request completed. Response received.");
      print("📥 [RestClient] API Response: $response");

      if (response != null && (response['success'] != null || response['status'] == "success")) {
        print("✅ Dustbin added successfully!");
      } else {
        print("❌ Failed to add dustbin. Response: $response");
        throw Exception("Failed to add dustbin");
      }
    } catch (e) {
      print("❌ [RestClient] Error adding dustbin: $e");
      throw e;
    }
  }
  */
  // Add a new dustbin
  static Future<void> addNewDustbin(Map<String, dynamic> requestBody) async {
    print("➡️ [RestClient] Starting addNewDustbin...");

    try {
      final String apiUrl = "https://intervein.dprofiz.com/Rfid_api/Dustbin/add_dustbin.php";
      print("🌐 [RestClient] Adding dustbin via API: $apiUrl");
      final response = await httpHelper.post(
        url: apiUrl,
        isRequireAuthorization: true,
        requestBody: json.encode(requestBody),
      );
      print("API request completed. Response received.");
      print("📥 [RestClient] API Response: $response");

      if (response != null && response['status'] == "success") {
        print("✅ Dustbin added successfully!");
      } else {
        print("❌ Failed to add dustbin. Response: $response");
        throw Exception("Failed to add dustbin");
      }
      // print("✅ [RestClient] API request completed. Status code: ${response
      //     .statusCode}");
      // print("📥 [RestClient] Response body: ${response.body}");
    } catch (e) {
      print("❌ [RestClient] Error adding dustbin: $e");
      throw e;
    }
  }
  // Update an existing dustbin
  static Future<void> updateDustbin(Map<String, dynamic> requestBody) async {
    print("➡️ [RestClient] Starting updateDustbin...");

    try {
      final String apiUrl = "https://intervein.dprofiz.com/Rfid_api/Dustbin/update_dustbin.php";
      print("🌐 [RestClient] Updating dustbin via API: $apiUrl");

      final response = await httpHelper.put(
        url: apiUrl,
        isRequireAuthorization: true, requestBody: json.encode(requestBody),
      );


      print("API request completed. Response received.");
      print("📥 [RestClient] API Response: $response");


      // print("✅ [RestClient] API request completed. Status code: ${response
      //     .statusCode}");
      // print("📥 [RestClient] Response body: ${response.body}");

      if (response.statusCode != 200) {
        print("❌ [RestClient] Failed to update dustbin. Status code: ${response
            .statusCode}");
        throw Exception('Failed to update dustbin: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ [RestClient] Error updating dustbin: $e");
      throw e;
    }
  }
  // removeAccess of dustbin
  static Future<Map<String, dynamic>> removeAccessDB(Map<String, dynamic> requestBody) async {
    print("➡️ [RestClient] Starting removeAccessDB...");

    try {
      final String apiUrl = "https://intervein.dprofiz.com/Rfid_api/Dustbin/remove_dustbin_assignment.php";
      print("🌐 [RestClient] Deleting dustbin access via API: $apiUrl");

      // Call httpHelper.get
      Map<String, dynamic> response = await httpHelper.post(
        url: apiUrl,
        isRequireAuthorization: true,
        requestBody: json.encode(requestBody),
      );
      print("API request completed. Response received.");
      print("API Response: $response");

      return response;

      /* if (response.statusCode != 200) {
        print("❌ [RestClient] Failed to remove access. Status code: ${response.statusCode}");
        throw Exception('Failed to remove access: ${response.statusCode}');
      }*/
    } catch (e,stackTrace) {
      print("❌ [RestClient] Error in removing access of dustbin: $e");
      print("Error fetching data: $e");
      print("Stack trace: $stackTrace");
      throw Exception("Error fetching data: $e");
      throw e;
    }
  }
  // grantAccess of dustbin
  static Future<Map<String, dynamic>> grantAccessDB(Map<String, dynamic> requestBody) async {
    print("➡️ [RestClient] Starting grantAccessDB...");

    try {
      final String apiUrl = "https://intervein.dprofiz.com/Rfid_api/Dustbin/assign_dustbin.php";
      print("🌐 [RestClient] Deleting dustbin access via API: $apiUrl");

      Map<String, dynamic> response = await httpHelper.post(
        url: apiUrl,
        isRequireAuthorization: true,
          requestBody: json.encode(requestBody)
      );
      print("API request completed. Response received.");
      print("API Response: $response");

      return response;

    } catch (e) {
      print("❌ [RestClient] Error in removing access of dustbin: $e");
      throw e;
    }
  }

  // 3. Logs : fetch data
  static Future<List<LogListInObj>> getLogListInObj() async {
    print("Starting getLogListInObj...");

    try {
      const String apiUrl =
          "https://intervein.dprofiz.com/Rfid_api/Logs/Fetch_Logs.php";
      print("Fetching data from API: $apiUrl");

      // Call httpHelper.get
      final response = await httpHelper.get(
        url: apiUrl,
        isRequireAuthorization: true,
      );

      print("API request completed.");

      // Log the full response (Optional but useful for debugging)
      print("API Response: $response");

      // Check if the response is a List
      if (response is List) {
        print("Parsing response into List<LogListInObj>...");

        // Use the model's fromJson method to map data
        List<LogListInObj> logs =
        response.map((data) => LogListInObj.fromJson(data)).toList();

        print("Parsed ${logs.length} log items successfully.");
        return logs;
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } catch (e, stackTrace) {
      print("Error fetching log data: $e");
      print("Stack Trace: $stackTrace");
      return []; // Return empty list instead of throwing exception
    }
  }

  //4. profile: fetch data
/*  static Future<List<ProfileListInArray>> getProfileListInArray() async {
    print("Starting getProfileListInObjDB...");
    try {
      const String apiUrl =
          "https://intervein.dprofiz.com/Rfid_api/Employee/profile_details.php";
      print("Fetching data from API: $apiUrl");

      // Call httpHelper.get
      final response = await httpHelper.get(
        url: apiUrl,
        isRequireAuthorization: true,
      );
      print("API request completed. Response received.");
      print("API Response: $response");

      if (response is List<dynamic>) {
        print("✅ [RestClient] API request completed. List received.");
        print("📥 [RestClient] Response data length: ${response.length}");
        return response.map((data) => ProfileListInArray.fromJson(data ?? {})).toList();
      } else if (response is http.Response) {
        print("❌ [RestClient] Response is of type Response. Decoding manually...");
        List<dynamic> data = json.decode(response.body);
        return data.map((data) => ProfileListInArray.fromJson(data ?? {})).toList();
      } else {
        print("❌ [RestClient] Unexpected response type: ${response.runtimeType}");
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print("Stack trace: $stackTrace");
      throw Exception("Error fetching data: $e");
    }
  }*/

//---------------------------------------//


  static Future<ProfileListInArray?> getProfileListInArray() async {
    print("Starting getProfileListInArray...");
    try {
      const String apiUrl =
          "https://intervein.dprofiz.com/Rfid_api/Employee/profile_details.php";
      print("Fetching data from API: $apiUrl");

      final response = await httpHelper.get(
        url: apiUrl,
        isRequireAuthorization: true,
      );

      print("API request completed. Response received.");
      print("API Response: $response");

      if (response is Map<String, dynamic>) {
        // ✅ Correctly handling a single object response
        print("✅ [RestClient] API returned a single object.");
        return ProfileListInArray.fromJson(response);
      } else if (response is http.Response) {
        // ✅ Handle raw HTTP response
        print("❌ [RestClient] Response is of type http.Response. Decoding manually...");
        Map<String, dynamic> data = json.decode(response.body);
        return ProfileListInArray.fromJson(data);
      } else {
        print("❌ [RestClient] Unexpected response type: ${response.runtimeType}");
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } catch (e, stackTrace) {
      print("❌ Error fetching data: $e");
      print("Stack trace: $stackTrace");
      throw Exception("Error fetching data: $e");
    }
  }
  // profile: SentOtp:
  static Future<bool> profileSendOtp(String email,) async {
    print('sendOtp: Starting OTP process...');
    try {
      const String apiUrl =
          " ";

      print('sendOtp: Sending OTP to: $apiUrl');
      print('sendOtp: Request Body: ${json.encode({'email': email,})}');

      final response = await httpHelper.post(
        url: apiUrl,
        isRequireAuthorization: true,
          requestBody: json.encode({'email': email,})
      );

      print('sendOtp: Response received: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] != null) {
          if (data['success'] is String &&
              data['success'].contains("OTP sent to email")) {
            print('sendOtp: OTP sent successfully.');
            return true;
          }
          if (data['success'] is bool) {
            print('sendOtp: Success field is boolean: ${data['success']}');
            return data['success'];
          }
        }
        print('sendOtp: Unexpected response structure');
        return false;
      } else {
        print('sendOtp: Failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('sendOtp: Error: $e');
      return false;
    }
  }

  //profile:  Verify OTP and update Email
  static Future<Map<String, dynamic>> VerifyOtpandUpdateEmail(String currentemail,String otp, String newEmail,) async {
    try {
      const String apiUrl = " ";
      print('Verifying OTP at: $apiUrl');
     print('Request Body: ${json.encode({'currentemail': currentemail, 'otp': otp, "newEmail" : newEmail})}');

    /*  final response = await http.post(
        Uri.parse(verifyOtpUrl),
        body: json.encode(
            {'email': email, 'otp': otp}), // Encode the body as JSON
      );*/
      final response = await httpHelper.put(
          url: apiUrl,
          isRequireAuthorization: true,
          requestBody: json.encode({
            'currentemail': currentemail, 'otp': otp, "newEmail" : newEmail
          }),
      );

      print('Verify OTP Response: ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Check if the response contains a "success" field
        if (data['success'] != null) {
          // If the "success" field is a string, check if it contains "Login successful"
          if (data['success'] is String &&
              data['success'].contains("Login successful")) {
            return {
              'success': true,
              'token': data['token'], // Extract the token
              'card_id': data['card_id'], // Extract the card ID
              'role': data['role'], // Extract the role
            };
          }
        }
        return {
          'success': false,
          'token': null
        }; // Default to false if the response is unexpected
      } else {
        print('Failed with status code: ${response.statusCode}');
        return {'success': false, 'token': null};
      }
    } catch (e) {
      print('Verify OTP Error: $e');
      return {'success': false, 'token': null};
    }
  }




// employee
/*static Future<List<UserListInArrayEmp>> getUserListInArray() async {
    print("➡️ [START] getUserListInArray: Initiating API Call...");

    try {
      const String apiUrl = "https://intervein.dprofiz.com/Rfid_api/Employee/get_employee_details.php";
      print("🌍 Fetching data from API: $apiUrl");

      // Step 1: Make the API request
      final response = await httpHelper.get(url: apiUrl);
      print("✅ API request completed.");

      // Step 2: Log the full API response
      print("📜 Raw API Response: $response");

      // Step 3: Check if the response is a List<dynamic>
      if (response is List<dynamic>) {
       print("🔄 Parsing API response into UserListInArrayEmp objects...");

        // Step 4: Handle the case where the response is empty
        if (response.isEmpty) {
          print("⚠️ Warning: API returned an empty list.");
          return [];
        }

        // Step 5: Parse the response into UserListInArrayEmp objects
        List<UserListInArrayEmp> userList = response.map((data) {
          print("🔍 Parsing data: $data");

          // Ensure each item is a Map<String, dynamic>
          if (data is Map<String, dynamic>) {
            return UserListInArrayEmp.fromJson(data);
          } else {
            throw Exception('Unexpected item type in response: ${data.runtimeType}');
          }
        }).toList();

        // Step 6: Log the successfully parsed data
        print("✅ Successfully parsed ${userList.length} users.");
        return userList;
      } else {
        // If the response is not a List<dynamic>, throw an exception
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } catch (e, stackTrace) {
      // Step 7: Log any errors encountered
      print("❌ ERROR: Exception occurred while fetching user list.");
      print("Exception: $e");
      print("Stack trace: $stackTrace");

      // Return an empty list to prevent app crash
      return [];
    } finally {
      print("➡️ [END] getUserListInArray: Execution completed.");
    }
  }*/
// Employee : fetch data
/*
 static Future<List<DustBinListInObj>> getDustListInArray() async {
    print("➡️ [START] getUserListInArray: Initiating API Call...");

    try {
      // Log the API endpoint being accessed
      const String apiUrl = "https://intervein.dprofiz.com/Rfid_api/Employee/get_employee_details.php";
      print("🌍 Fetching data from API: $apiUrl");

      // Step 1: Make the API request
      List<dynamic> response = await httpHelper.get(url: apiUrl);
      print("✅ API request completed.");

      // Step 2: Log the full API response
      print("📜 Raw API Response: ${response.toString()}");

      // Step 3: Handle the case where the response is empty
      if (response.isEmpty) {
        print("⚠️ Warning: API returned an empty list.");
        return [];
      }

      // Step 4: Parse the response into UserListInArray objects
      print("🔄 Parsing API response into UserListInArray objects...");
      List<DustBinListInObj> userList = List<DustBinListInObj>.from(
          response.map((x) => DustBinListInObj().fromJson(x))
      );

      // Step 5: Log the successfully parsed data
      print("✅ Successfully parsed ${userList.length} users.");

      return userList;

    } catch (e, stackTrace) {
      // Step 6: Log any errors encountered
      print("ERROR: Exception occurred while fetching user list.");
      print("Exception: $e");
      print("Stack trace: $stackTrace");

      // Return an empty list to prevent app crash
      return [];
    } finally {
      print("➡️ [END] getUserListInArray: Execution completed.");
    }
  }
*/

//post API
// Dustbin : AddNewDustbin

/* Future<dynamic> AddNewDustbin(Map<String, dynamic> requestBody) async {
    print("➡️ [START] AddNewDustbin API Call...");

    try {
      const String apiUrl = 'https://intervein.dprofiz.com/Rfid_api/Dustbin/add_dustbin.php';
      print("🌍 Sending request to API: $apiUrl");
      print("📤 Request Body: $requestBody");

      var response = await httpHelper.post(url: apiUrl, requestBody: requestBody);

      print("✅ API Response Received: $response");

      return response;
    } catch (e, stackTrace) {
      print(" ERROR: Exception while calling AddNewDustbin API.");
      print(" Exception: $e");
      print(" Stack trace: $stackTrace");
      return {"status": "error", "message": "Failed to connect to API"};
    } finally {
      print("➡️ [END] AddNewDustbin API Call.");
    }
  }
*/

// post api :
/*
  static Future<dynamic> registration(Object requestbody) async {
    print("Fetching data from API..."); // Debugging log
    var response = await httpHelper.post(
        url: 'https://reqres.in/api/register', requestBody: requestbody);
    print("API Response: $response"); // Debugging log
    return response;
  }
  */

//put api :
/*
  static Future<UpdateUserModel> UpdateUserPut(Object requestbody) async {
    print("Fetching data from API..."); // Debugging log
    var response = await httpHelper.put(
        url: 'https://reqres.in/api/users/2', requestBody: requestbody);
    print("API Response: $response"); // Debugging log
    return UpdateUserModel.fromJson(response);
  }
  */

//patch api :
/*
  static Future<UpdateUserModel> UpdateUserPatch(Object requestbody) async {
    print("Fetching data from API..."); // Debugging log
    var response = await httpHelper.put(
        url: 'https://reqres.in/api/users/2', requestBody: requestbody);
    print("API Response: $response"); // Debugging log
    return UpdateUserModel.fromJson(response);
  }
  */

//delete api :
/*
  static Future<dynamic> Userdelete(String id) async {
    print("Fetching data from API..."); // Debugging log
    var response = await httpHelper.delete(
      url: 'https://fakestoreapi.com/users/$id',
    );
    print("API Response: $response"); // Debugging log
    return response;
  }*/

/*
  Future<PostApiModel> postApi(Object model) async {
    Map params = {'email': '', 'password': ''};
    Map<String, dynamic> response =
        await httpHelper.post(url: "  ", requestBody: params);
    return PostApiModel.fromJson(response);
  }*/
}
