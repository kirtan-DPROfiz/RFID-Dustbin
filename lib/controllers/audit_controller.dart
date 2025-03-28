import 'dart:developer';

import 'package:Deprofiz/models/api_models/Audit_list_in_obj_array.dart';
import 'package:Deprofiz/models/api_models/export_alllogs_list_in_obj.dart';
import 'package:get/get.dart';

import '../network manager/rest_client.dart';

class AuditController extends GetxController {

  var errorMessage = "".obs;
  var auditListInobj = <AuditListInObj>[].obs;
  var auditListCount = 0.obs;

  @override
  void onInit() {
    AuditList();
    super.onInit();
  }
  // Fetch all logs data from the API


  void AuditList() {
    print("➡️ [START] userList: Fetching employee data...");
    try {
      RestClient.getAuditListInObj().then((value) {
        log("✅ API Response: $value");
        print("✅ API Response: $value");

        if (value == null || value.isEmpty) {
          log("⚠️ Warning: API returned null or an empty list.");
          print("⚠️ Warning: API returned null or an empty list.");
          errorMessage.value = "No data found, because API response is empty!";
        } else {
          // **Fix: Explicitly map the response to List<AuditListInArray>**
          auditListInobj.value = value ?? [];
          auditListCount.value = auditListInobj.length;
        }
      });
    } catch (error) {
      log("❌ Error fetching API data: $error");
      errorMessage.value = "Failed to load data. Please check your network or try again.";
    } finally {
      print("Execution complete!");
    }
  }

}
