import 'dart:developer';

import 'package:Deprofiz/models/api_models/export_alllogs_list_in_obj.dart';
import 'package:get/get.dart';

import '../network manager/rest_client.dart';

class LogsController extends GetxController {

  var errorMessage = "".obs;
  var AllLogsListInobj = <ExportAllLogsListInObj>[].obs;
  var allLogsCount = 0.obs;

  @override
  void onInit() {
AllLogList();
    super.onInit();
  }
  // Fetch all logs data from the API


  void AllLogList() {
    print("➡️ [START] userList: Fetching employee data...");
try{
    final value = RestClient.getAllLogsListInObj().then((value) {
      log("✅ API Response: $value");
      print("✅ API Response: $value");

      // Step 1: Check if the response is null or empty
      if (value == null) {
        log("⚠️ Warning: API returned null or an empty list.");
        print("⚠️ Warning: API returned null or an empty list.");
          errorMessage.value = "No data found, because Api response is Empty! ";

      } else {
        // Step 2: Log the number of items returned
        log("📊 API returned data: ${value} items");
        // Step 3: Update the state with the fetched data

          AllLogsListInobj.value = value ?? [] ; // Directly assign the list
          allLogsCount.value = AllLogsListInobj.length;

      }
    });
  }catch(error) {
      // Step 4: Log any errors encountered
      log("❌ Error fetching API data: $error");
        errorMessage.value=
        "Failed to load data. Please check your network or try again.";
    }finally {
    print("Execution complete !");

    }
  }
}
