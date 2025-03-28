/*
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SharedPreferencesHelper {
  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';
  static const String _isLoggedInKey = 'isLoggedIn';
  //static const String UUID = 'uuid';
  static const String _tokenKey = 'token'; // Key for saving the token

  // Save user credentials
  static Future<void> saveCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
    await prefs.setBool(_isLoggedInKey, true);
  }

  // Save token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Get saved token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Clear credentials and token on logout
  static Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  // Clear token on logout
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Get saved credentials
  static Future<Map<String, String>> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_emailKey) ?? '';
    final password = prefs.getString(_passwordKey) ?? '';
    return {'email': email, 'password': password};
  }



*/
/*  static Future<String> getOrCreateUuid() async {
    print('Starting getOrCreateUuid()');

    final prefs = await SharedPreferences.getInstance();
    print('SharedPreferences instance obtained');

    String? uuid = prefs.getString('uuid');
    print('Checked for Stored or existing UUID: $uuid');

    if (uuid == null) {
      print('No existing or Stored UUID found. Generating a new one...');
      uuid = Uuid().v4();
      await prefs.setString('uuid', uuid);
      print('Generated and stored new UUID: $uuid');
    } else {
      print('Retrieved stored UUID: $uuid');
    }

    print('Returning UUID: $uuid');
    return uuid;
  }*//*


}*/
