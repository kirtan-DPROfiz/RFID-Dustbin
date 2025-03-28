/*
// pubspec.yaml dependencies:
//   device_info_plus: ^9.0.3
//   uuid: ^3.0.7

import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';


void main() {
  print("[DEBUG] App Starting...");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("[DEBUG] Building MyApp Widget");
    return MaterialApp(
      title: 'Flutter Web License Key',
      home: LicenseScreen(),
    );
  }
}

class LicenseScreen extends StatefulWidget {
  @override
  _LicenseScreenState createState() {
    print("[DEBUG] Creating LicenseScreenState");
    return _LicenseScreenState();
  }
}

class _LicenseScreenState extends State<LicenseScreen> {
  final TextEditingController _licenseController = TextEditingController();
  String? hardwareId;
  String? hashedHardwareId;
  String? uuid;

  @override
  void initState() {
    super.initState();
    print("[DEBUG] initState Called");
    _getOrCreateUUID();
  }

  Future<void> _getOrCreateUUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUUID = prefs.getString('device_uuid');

    if (savedUUID == null) {
      var uuidGenerator = build();
      savedUUID = uuidGenerator.v4();
      await prefs.setString('device_uuid', savedUUID);
      print("[DEBUG] New UUID Generated: $savedUUID");
    } else {
      print("[DEBUG] Existing UUID Found: $savedUUID");
    }

    uuid = savedUUID;
    await _getHardwareId();
  }

  Future<void> _getHardwareId() async {
    print("[DEBUG] Fetching Hardware Address...");
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    hardwareId = "${webBrowserInfo.userAgent}_${webBrowserInfo.hardwareConcurrency}_${webBrowserInfo.platform}";
    String combinedId = "$uuid$hardwareId";
    hashedHardwareId = sha256.convert(utf8.encode(combinedId)).toString();

    print("[DEBUG] Hardware Address Generated: $hardwareId");
    print("[DEBUG] Combined UUID and Hardware ID: $combinedId");
    print("[DEBUG] Hashed Hardware Address: $hashedHardwareId");
  }

  Future<void> _saveLicenseKey(String key) async {
    print("[DEBUG] Saving License Key: $key");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('license_key', key);
    print("[DEBUG] License Key Saved Successfully: $key");
  }

  Future<String?> _getSavedLicenseKey() async {
    print("[DEBUG] Retrieving Saved License Key...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedKey = prefs.getString('license_key');
    print("[DEBUG] Retrieved License Key: $savedKey");
    return savedKey;
  }

  Future<void> _verifyLicense() async {
    print("[DEBUG] Starting License Verification...");
    String? savedKey = await _getSavedLicenseKey();
    print("[DEBUG] Comparing Hashed Hardware Address: $hashedHardwareId with Saved Key: $savedKey");
    if (savedKey == hashedHardwareId) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('License Verified!')));
      print("[DEBUG] License Verified Successfully");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid License Key!')));
      print("[DEBUG] License Verification Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("[DEBUG] Building LicenseScreen Widget");
    return Scaffold(
      appBar: AppBar(title: Text('License Key System')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _licenseController,
              decoration: InputDecoration(labelText: 'Enter License Key'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                print("[DEBUG] Save License Button Pressed");
                await _saveLicenseKey(hashedHardwareId!);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('License Key Saved!')));
              },
              child: Text('Save License Key'),
            ),
            ElevatedButton(
              onPressed: () {
                print("[DEBUG] Verify License Button Pressed");
                _verifyLicense();
              },
              child: Text('Verify License Key'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
