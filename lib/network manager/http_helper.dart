import 'dart:convert';
import 'dart:io';

import 'package:Deprofiz/utils/print_value.dart';
import 'package:Deprofiz/utils/toast_message.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Authentication_services/sharedpreferencehelper.dart';
import '../helper/sharedpreferences_helper.dart';

class HttpHelper {


// Get API Handle


    Future<dynamic> get({
      required String url,
      bool isRequireAuthorization = false, /*required Map<String, String> headers,*/
    }) async {
      try {
        // Step 1: Retrieve the saved token using SharedPreferencesHelper
        final token = await SharedPreferencesAuth.getToken();

        if (isRequireAuthorization && token == null) {
          print("Error: No token found. User is not logged in.");
          throw Exception("User is not logged in.");
        }

      Map<String, String> apiHeader = {
        "Content-type": " application/json ",
      };
      if (isRequireAuthorization && token != null) {
        apiHeader = {"Content-type": "application/json  ", "Authorization": "Bearer $token" };
        print("Using token: $token");
      }

        final apiResponse = await http.get(Uri.parse(url), headers: apiHeader);
        printvalue(url, tag: " API GET URL: ");
        printvalue(apiHeader, tag: " API HEADER: ");
        printvalue(apiResponse.body, tag: " API RESPONSE: ");
        if (apiResponse.statusCode == 200) {
          //return apiResponse; // Return whole response object
          return json.decode(apiResponse.body); // Convert JSON to Map
        } else {
          throw Exception("Failed to load data: ${apiResponse.statusCode}");
        }
        // return _returnResponse(
        //   response: apiResponse,
        // );
      } on SocketException {
        print("No internet connection");
        return null;
      } catch (e) {
        print("Unexpected error: $e");
        throw Exception("Unexpected error: $e");
      }
    }

  //POST API HANDLE
  Future<dynamic> post({
    required String url,
    Object? requestBody,
    //required dynamic requestBody,
    bool isRequireAuthorization = false,
  }) async {
    try {
    // Step 1: Retrieve the saved token using SharedPreferencesHelper
    final token = await SharedPreferencesAuth.getToken();

    if (isRequireAuthorization && token == null) {
      print("Error: No token found. User is not logged in.");
      throw Exception("User is not logged in.");
    }
    Map<String, String> apiHeader = { "Content-type": " application/json ",};
    if (isRequireAuthorization) {
      apiHeader = {"Content-type": "application/json  ", "Authorization": "Bearer $token"};
      print("Using token: $token");
    }

      http.Response apiResponse;
      if (requestBody == null) {
        apiResponse = await http.post(Uri.parse(url), headers: apiHeader);
      } else {
        apiResponse = await http.post(Uri.parse(url),
            headers: apiHeader, body: requestBody);
      }
      printvalue(url, tag: " API GET URL: ");
      printvalue(requestBody, tag: " API GET URL: ");
      printvalue(apiHeader, tag: " API HEADER: ");
      printvalue(apiResponse.body, tag: " API RESPONSE: ");
       return json.decode(apiResponse.body);


      // return _returnResponse(
      //   response: apiResponse,
      // );
    } on SocketException {
      return null;
    }
  }

  // PUT API HANDLE
  Future<dynamic> put({
    required String url,
    bool isRequireAuthorization = false,
    required dynamic requestBody,
  }) async {
    try {
    // Step 1: Retrieve the saved token using SharedPreferencesHelper
    final token = await SharedPreferencesAuth.getToken();

    if (isRequireAuthorization && token == null) {
      print("Error: No token found. User is not logged in.");
      throw Exception("User is not logged in.");
    }

    Map<String, String> apiHeader = {};
    if (isRequireAuthorization) {
      apiHeader = {"Content-type": "application/json ", "Authorization": "Bearer $token"};
      print("Using token: $token");
    }


      http.Response apiResponse;
      if (requestBody == null) {
        apiResponse = await http.put(Uri.parse(url), headers: apiHeader);
      } else {
        apiResponse = await http.put(Uri.parse(url),
            headers: apiHeader, body: requestBody);
      }
      printvalue(url, tag: " API GET URL: ");
      printvalue(requestBody, tag: " API GET URL: ");
      printvalue(apiHeader, tag: " API HEADER: ");
      printvalue(apiResponse.body, tag: " API RESPONSE: ");
    return json.decode(apiResponse.body);

      // return _returnResponse(
      //   response: apiResponse,
      // );
    } on SocketException {
      return null;
    }
  }

  //PATCH API HANDLE:
  Future<dynamic> patch({
    required String url,
    bool isRequireAuthorization = false,
    required dynamic requestBody,
  }) async {
    Map<String, String> apiHeader = {};
    if (isRequireAuthorization) {
      apiHeader = {"Content-type": "application/json ", "Authorization": " "};
    }
    try {
      http.Response apiResponse;
      if (requestBody == null) {
        apiResponse = await http.patch(Uri.parse(url), headers: apiHeader);
      } else {
        apiResponse = await http.patch(Uri.parse(url),
            headers: apiHeader, body: requestBody);
      }
      printvalue(url, tag: " API PATCH URL: ");
      printvalue(requestBody, tag: " API GET URL: ");
      printvalue(apiHeader, tag: " API HEADER: ");
      printvalue(apiResponse.body, tag: " API RESPONSE: ");

      return _returnResponse(
        response: apiResponse,
      );
    } on SocketException {
      return null;
    }
  }

  // DELETE API HANDLE
  Future<dynamic> delete({
    required String url,
    bool isRequireAuthorization = false,
    Object? requestBody,
  }) async {
    Map<String, String> apiHeader = {};
    if (isRequireAuthorization) {
      apiHeader = {"Content-type": " application/json", "Authorization": " "};
    }
    try {
      http.Response apiResponse;
      if (requestBody == null) {
        apiResponse = await http.delete(Uri.parse(url), headers: apiHeader);
      } else {
        apiResponse = await http.delete(Uri.parse(url),
            headers: apiHeader, body: requestBody);
      }
      printvalue(url, tag: " API DELETE URL: ");
      printvalue(apiHeader, tag: " API HEADER: ");
      printvalue(apiResponse.body, tag: " API RESPONSE: ");

      return _returnResponse(
        response: apiResponse,
      );
    } on SocketException {
      return null;
    }
  }

  /// MULTIPART API HANDLE:
  Future<dynamic> uploadImage(String url, File imageFile) async {
    try {
      var request = http.MultipartRequest("post", Uri.parse(url));
      request.headers.addAll({"content-Type ": "Multipart/from-data "});

      request.files.add(
        await http.MultipartFile.fromPath("file ", imageFile.path,
            filename: imageFile.toString().split("/ ").last),
      );
      StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);

      printvalue(url, tag: " API GET URL: ");
      printvalue({"content-Type ": "Multipart/from-data "},
          tag: " API HEADER: ");
      printvalue(response.body, tag: " API RESPONSE: ");

      return _returnResponse(response: response);
    } on SocketException {
      return null;
    }
  }

  dynamic _returnResponse({required http.Response response}) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);

      case 400:
        try {
          var decodeError = json.decode(response.body);
          String errorMessage = decodeError['message'] ?? 'Bad Request';
          toastMessage(errorMessage); // Show meaningful message
        } catch (e) {
          toastMessage("Invalid error response from server.");
        }
        throw Exception("Bad Request: ${response.body}");

      case 401:
        throw Exception("UNAUTHORIZED 401 - Please log in again");

      case 500:
        throw Exception("Server Error: Status Code 500");

      default:
        throw Exception("Unexpected Error: Status Code ${response.statusCode}");
    }
  }

/*
  dynamic _returnResponse({
    required http.Response response,
  }) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;

      case 201:
        var responseJson = json.decode(response.body);
        return responseJson;

      case 400:
        var decodeError = json.decode(response.body);
        toastMessage(decodeError.toString());
        /* if (decodeError.containsKey('')) {
          toastMessage(decodeError['message'].toString());
        } */
        throw Exception("Error");
      case 401:
        // navigate to login page:
        throw Exception('UNAUTHORIZED 401');

      case 500:
        throw Exception(
            "Error occured while communication with server StatusCode 500");

      default:
        throw Exception(
            "Error occured while communication with server StatusCode ${response.statusCode.toString()}");
    }
  }*/
}
