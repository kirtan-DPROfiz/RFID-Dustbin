import 'dart:developer';
import 'package:Deprofiz/models/api_models/profileListInArray.dart';
import 'package:Deprofiz/network%20manager/rest_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProfilePageScreen extends StatefulWidget {
  const AdminProfilePageScreen({super.key});

  @override
  State<AdminProfilePageScreen> createState() => _AdminProfilePageScreenState();
}

class _AdminProfilePageScreenState extends State<AdminProfilePageScreen> {
  bool isLoading = true;
  List<ProfileListInArray> profileListInArray = [];
  String errorMessage = "";

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  ProfileListInArray? profileData;

  void profileList() {
    log("➡️ [START] Fetching employee data...");

    RestClient.getProfileListInArray().then((value) {
      log("✅ API Response: $value");

      if (value == null ) {
        log("⚠️ Warning: API returned null or empty data.");
        setState(() {
          errorMessage = "No data found.";
          isLoading = false;
        });
      } else {
        setState(() {
          profileData = value;
          _nameController.text = profileData?.empName ?? "";
          _emailController.text = profileData?.email ?? "";
          isLoading = false;
        });
      }
    }).catchError((error) {
      log("❌ Error fetching API data: $error");
      setState(() {
        errorMessage = "Failed to load data. Please check your network.";
        isLoading = false;
      });
    }).whenComplete(() {
      log("➡️ [END] Fetching execution completed.");
    });
  }

  @override
  void initState() {
    super.initState();
    profileList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Employee Name
              TextFormField(
                controller: _nameController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Employee Name",
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  suffixIcon: Icon(Icons.edit, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                ),
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),

              // Employee Email
              TextFormField(
                controller: _emailController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Employee Email",
                  prefixIcon: Icon(Icons.email, color: Colors.white),
                  suffixIcon: Icon(Icons.edit, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
