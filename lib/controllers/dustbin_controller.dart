// import 'package:get/get.dart';

// class DustbinController extends GetxController {
//   // Initialize with the default number of dustbins
//   var dustbinCount = 5.obs;

//   void updateDustbinCount(int count) {
//     dustbinCount.value = count;
//   }
// }

/*
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DustbinController extends GetxController {
  var dustbins = <Map<String, String>>[
    {'id': 'D001', 'location': '1st floor'},
    {'id': 'D002', 'location': '2nd floor'},
    {'id': 'D003', 'location': '3rd floor'},
    {'id': 'D004', 'location': '4th floor'},
    {'id': 'D005', 'location': '5th floor'},
  ].obs;

  int get dustbinCount => dustbins.length;
}
*/




import 'dart:developer';

import 'package:get/get.dart';

import '../models/api_models/dustbin_list_in_array.dart';
import '../network manager/rest_client.dart';

class DustbinController extends GetxController {
  var errorMessage = "".obs;

  //RxList<Map<String, String>> dustbins = <Map<String, String>>[].obs;


/*  @override
  void onInit() {
    // Initialize with default values
    dustbins.addAll([
      {'id': 'D001', 'location': '1st floor'},
      {'id': 'D002', 'location': '2nd floor'},
      {'id': 'D003', 'location': '3rd floor'},
      {'id': 'D004', 'location': '4th floor'},
      {'id': 'D005', 'location': '5th floor'},
    ]);
    dustbinCount.value = dustbins.length;
    super.onInit();
  }
  // Add Dustbin
  void addDustbin(String id, String location) {
    dustbins.add({'id': id, 'location': location});
    // Optional: print to verify
    print(dustbins);
  }
  // Remove Dustbin
  void removeDustbin(String id) {
    dustbins.removeWhere((dustbin) => dustbin['id'] == id);
    // Optional: print to verify
    print(dustbins);
  }
  */



  var dustbinListInObj = <DustBinListInArray>[].obs;
  var dustbinCount = 0.obs;

  @override
  void onInit() {
    fetchDustbins();
    super.onInit();
  }

  // Fetch dustbin data from the API
  void fetchDustbins() async {
  print("➡️ [DustbinPage] Starting fetchDustbins...");

  try {
  final value = await RestClient.getDustbinListInArray();
  log("✅ [DustbinPage] API Response: $value");

  if (value.isEmpty) {
  log("⚠️ [DustbinPage] API returned an empty list.");
  errorMessage.value = "No data found.";
  } else {
  log("📊 [DustbinPage] API returned data: ${value.length} items");
  dustbinListInObj.value = value ?? [];
  dustbinCount.value = dustbinListInObj.length;
  }
  } catch (error) {
  log("❌ [DustbinPage] Error fetching API data: $error");
  errorMessage.value = "Failed to load data. Please check your network or try again.";
  } finally {
    print("Execution complete !");

  }
  }
  }










