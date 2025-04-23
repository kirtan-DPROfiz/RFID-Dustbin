/*import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl;

  AuthService(this.apiUrl);

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true; // Adjust based on your API response
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

*/

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Deprofiz/Authentication_services/sharedpreferencehelper.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../helper/sharedpreferences_helper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  // final sharedpreference = SharedPreferencesAuth();
  String showErrorMessage = " ";


//-------------------user Agent String formate-------------//
/*  Future<String> getMacAddress() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
      print('getMacAddress: Web UserAgent = ${webInfo.userAgent}');
      return webInfo.userAgent ?? 'Unknown'; // Web UserAgent as identifier
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('getMacAddress: Android ID = ${androidInfo.id}');
      return androidInfo.id ?? 'Unknown';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('getMacAddress: iOS ID = ${iosInfo.identifierForVendor}');
      return iosInfo.identifierForVendor ?? 'Unknown';
    } else {
      print('getMacAddress: Unsupported platform');
      return 'Unknown';
    }
  }

  // Send OTP
  Future<bool> sendOtp(String sendOtpUrl, String email) async {
    print('sendOtp: Starting OTP process...');
    try {
      print('sendOtp: Fetching MAC Address...');
      String macAddress = await getMacAddress();
      print('sendOtp: MAC Address fetched: $macAddress');

      try {
        final result = await InternetAddress.lookup('intervein.dprofiz.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('sendOtp: API is reachable');
        }
      } catch (e) {
        print('sendOtp: API is not reachable: $e');
      }

      print('sendOtp: Sending OTP to: $sendOtpUrl');
      print('sendOtp: Request Body: ${json.encode({'email': email, 'macAddress': macAddress})}');

      final response = await http.post(
        Uri.parse(sendOtpUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'uuid': macAddress, // Send MAC Address
        }),
      );

      print('sendOtp: Response received: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] != null) {
          if (data['success'] is String && data['success'].contains("OTP sent")) {
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
    } on http.ClientException catch (e) {
      print('sendOtp: ClientException: $e');
      return false;
    } on SocketException catch (e) {
      print('sendOtp: SocketException: $e');
      return false;
    } on TimeoutException catch (e) {
      print('sendOtp: TimeoutException: $e');
      return false;
    } catch (e) {
      print('sendOtp: Error: $e');
      return false;
    }
  }*/
//----------------uuid----------//

/*  Future<bool> sendOtp(String sendOtpUrl, String email) async {
    print('sendOtp: Starting OTP process...');

    try {
      print('sendOtp: Fetching or generating UUID...');
      String uuid = await SharedPreferencesAuth.getOrCreateUuid();// Get the stored UUID
      print('sendOtp: UUID fetched: $uuid');

      print('sendOtp: Sending OTP to: $sendOtpUrl');
      print('sendOtp: Request Body: ${json.encode({'email': email, 'uuid': uuid})}');

      final response = await http.post(
        Uri.parse(sendOtpUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'uuid': uuid, // Use the stored UUID
        }),
      );

      print('sendOtp: Response received: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] != null) {
          if (data['success'] is String && data['success'].contains("OTP sent")) {
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
        // Handle invalid device access
        if (response.statusCode == 403) {
          print('sendOtp: Invalid device access');
          // Show error message to the user
          showErrorMessage :'Invalid device access. Please use the original device.';
        } else {
          print('sendOtp: Failed with status code: ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      print('sendOtp: Error: $e');
      return false;
    }
  }*/
  //----------------------uuid stored in web local Storage ------------------------------//

  Future<bool> sendOtp(
      //String UserId
      String sendOtpUrl, String email) async {
    print('sendOtp: Starting OTP process...');
    try {
      print('sendOtp: Fetching or generating UUID...');
      String uuid = await SharedPreferencesAuth
          .getOrCreateUuid(); // Get the stored UUID
      print('sendOtp: UUID fetched: $uuid');

      print('sendOtp: Sending OTP to: $sendOtpUrl');
      print('sendOtp: Request Body: ${json.encode(
          {
            //'user_id':UserId ,
            'email': email,
            'uuid': uuid
          })}');

      final response = await http.post(
        Uri.parse(sendOtpUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
         // 'user_id':UserId,
          'email': email,
          'uuid': uuid, // Use the stored UUID
        }),
      );

      print('sendOtp: Response received: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] != null) {
          if (data['success'] is String &&
              data['success'].contains("OTP sent")) {
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

  //--------------------------verify the token ---------------------------------------//
  Future<Map<String, dynamic>> verifyToken(String verifyTokenUrl) async {
    try {
      print('Verifying token at: $verifyTokenUrl');

      // Retrieve the stored token
      final token = await SharedPreferencesAuth.getToken();
      if (token == null || token.isEmpty) {
        print('No token found. User is not logged in.');
        return {'success': false, 'message': 'No token found'};
      }

      print('Using token: $token');

      // Send the token to the API for verification
      final response = await http.get(
        Uri.parse(verifyTokenUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Verify Token Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message'] == "Access granted") {
          // Token is valid, save the user details
          await SharedPreferencesAuth.saveUserDetails(data['user']);
          return {'success': true, 'user': data['user']};
        } else {
          // Token is invalid or access denied
          return {'success': false, 'message': data['message']};
        }
      } else {
        print('Failed with status code: ${response.statusCode}');
        return {'success': false, 'message': 'Server error'};
      }
    } catch (e) {
      print('Verify Token Error: $e');
      return {'success': false, 'message': 'An error occurred'};
    }
  }


  // Verify OTP and return token
  Future<Map<String, dynamic>> verifyOtp(String verifyOtpUrl, String email,
      String otp) async {
    try {
      print('Verifying OTP at: $verifyOtpUrl');
      print('Request Body: ${json.encode({'email': email, 'otp': otp})}');

      final response = await http.post(
        Uri.parse(verifyOtpUrl),
        body: json.encode(
            {'email': email, 'otp': otp}), // Encode the body as JSON
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


  // Verify OTP and return token
  /*Future<bool> verifyOtp(String verifyOtpUrl, String email, String otp) async {
    try {
      print('Verifying OTP at: $verifyOtpUrl');
      print('Request Body: ${json.encode({'email': email, 'otp': otp})}');

      final response = await http.post(
        Uri.parse(verifyOtpUrl),
        body: json.encode({'email': email, 'otp': otp}), // Encode the body as JSON
      );

      print('Verify OTP Response: ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Check if the response contains a "success" field
        if (data['success'] != null) {
          // If the "success" field is a string, check if it contains "OTP verified"
          if (data['success'] is String && data['success'].contains("OTP verified")) {
            return true; // OTP verified successfully
          }
          // If the "success" field is a boolean, return its value
          if (data['success'] is bool) {
            return data['success'];
          }
        }
        return false; // Default to false if the response is unexpected
      } else {
        print('Failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Verify OTP Error: $e');
      return false;
    }
  }
*/
  // Verify OTP
  /* Future<bool> verifyOtp(String verifyOtpUrl, String email, String otp) async {
    try {

      final response = await http.post(
        Uri.parse(verifyOtpUrl), // Use the full URL
        body: {'email': email, 'otp': otp},
      );

      print('Verify OTP Response: ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true; // Adjust based on your API response
      }
      return false;
    }
    on http.ClientException catch (e) {
      print('ClientException: $e');
      return false;
    } on SocketException catch (e) {
      print('SocketException: $e');
      return false;
    } on TimeoutException catch (e) {
      print('TimeoutException: $e');
      return false;
    }catch (e) {
      print('Verify OTP Error: $e');
      return false;
    }
  }*/


// Logout user:
  /*Future<bool> logout(String logoutUrl) async {
    try {
      // Retrieve the saved token
      final token = await SharedPreferencesAuth.getToken();
      //final prefs = await SharedPreferences.getInstance();
      //final token = prefs.getString('token');
      if (token == null) {
        print('No token found. User is not logged in.');
        return false;
      }
      print('Logging out with token: $token');
      final response = await http.post(
        Uri.parse(logoutUrl),
        headers: {
          'Authorization': 'Bearer $token', // Use the bearer token
          'Content-Type': 'application/json',
        },
      );
      // check for the uuid :
      String uuid = await SharedPreferencesAuth.getOrCreateUuid(); // Get the stored UUID
      print('local Stored : UUID fetched: $uuid');

      print('Logout Response: ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
       // return data['success'] == true; // Adjust based on your API response
        // Check if the response message is "User logged out successfully"
        if (data['message'] == "User logged out successfully") {
          return true; // Logout successful
        } else {
          print('Logout failed: ${data['message']}');
          return false; // Logout failed due to incorrect message
        }
      } else {
        print('Failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Logout Error: $e');
      return false;
    }
  }*/
//------------------------------------//
  Future<bool> logout(String logoutUrl, BuildContext context) async {
    print("Logout function called.");

    try {
      // Retrieve the saved token
      print("Fetching token from SharedPreferences...");
      final token = await SharedPreferencesAuth.getToken();
      print("Retrieved token: $token");

      if (token == null || token.isEmpty) {
        print('No token found. User is not logged in.');
        _showSnackBar(context, 'No active session found.');
        return false;
      }

      print('Logging out with token: $token');

      // API Request
      print("Sending logout request to: $logoutUrl");
      final response = await http.post(
        Uri.parse(logoutUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("Logout request sent. Waiting for response...");

      // Retrieve stored UUID
      print("Fetching local stored UUID...");
      String uuid = await SharedPreferencesAuth.getOrCreateUuid();
      print('Local Stored UUID: $uuid');

      print('Logout API Response: ${response.body}');
      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Decoded API Response: $data");

        if (data['success']?.toString().toLowerCase() ==
            "user logged out successfully".toLowerCase() ||
            data['message']?.toString().toLowerCase() ==
                "user logged out successfully".toLowerCase()) {
          print("Logout successful at auth Service .");
       /*   _showSnackBar(context, 'Logout successful.');*/
          return true;
        } else {
          print('Logout failed. API returned: ${data['success']}');
          _showSnackBar(context, 'Logout failed. Please try again.');
          return false;
        }
      } else {
        print('Logout failed with status code: ${response.statusCode}');
        _showSnackBar(context, 'Server error. Please try again later.');
        return false;
      }
    } catch (e) {
      print('Logout Error: $e');
      _showSnackBar(context, 'An error occurred. Please try again.');
      return false;
    }
  }

// Helper function to show Snackbar
  void _showSnackBar(BuildContext context, String message) {
    print("Attempting to show SnackBar with message: $message");

    if (ScaffoldMessenger.maybeOf(context) != null) {
      print("ScaffoldMessenger found. Showing SnackBar.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } else {
      print("No active Scaffold found. Cannot show SnackBar.");
    }
  }

// Verify OTP

// Future<bool> verifyOtp(String endpoint, String email, String otp) async {
//   try {
//     final response = await http.post(
//       Uri.parse('$baseUrl/$endpoint'),
//       body: {'email': email, 'otp': otp},
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data['success'] == true; // Adjust based on your API response
//     }
//     return false;
//   } catch (e) {
//     return false;
//   }
// }
}
