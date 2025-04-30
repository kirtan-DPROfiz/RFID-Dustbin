// routes_names.dart

import 'package:Deprofiz/screens/access_Dustbin/access_List_Dustbin.dart';
import 'package:Deprofiz/screens/audit/audit_page_screen.dart';
import 'package:Deprofiz/screens/dashboard/dashboard_screen.dart';
import 'package:Deprofiz/screens/dustbin/dustbin_page_screen.dart';
import 'package:Deprofiz/screens/employee/employee_page_screen.dart';
import 'package:Deprofiz/screens/export_data/export_data_screen.dart';
import 'package:Deprofiz/screens/login_screen/custom_login_screen.dart';
import 'package:Deprofiz/screens/logs/logs_page_screen.dart';
import 'package:Deprofiz/screens/main/main_screen.dart';
import 'package:Deprofiz/screens/profile/profile_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes.dart'; // Import the route paths

class RouteNames {
  static final List<GetPage> Pages = [
    GetPage(name: Routes.mainScreen, page: () => MainScreen()),
    GetPage(name: Routes.loginScreen, page: () => CustomLoginScreen()),
    GetPage(name: Routes.dashboardScreen, page: () => DashboardScreen()),
    GetPage(name: Routes.dustbinPage, page: () => DustbinPage()),
    GetPage(name: Routes.employeePage, page: () => EmployeePage()),
    GetPage(name: Routes.exportDataScreen, page: () => ExportDataScreen()),
    GetPage(name: Routes. auditPageScreen, page: () => AuditPageScreen()),
    GetPage(name: Routes.logsPageScreen, page: () => LogsPageScreen()),
    GetPage(name: Routes.AccessListDustbinScreen, page: () => AccessListDustbin()),
    GetPage(name: Routes. profilePageScreen, page: () => ProfilePageScreen()),
  ];

  static const String loginScreen = Routes.loginScreen;
  static const String mainScreen = Routes.mainScreen;
  static const String OrganizationScreen = Routes.OrganizationScreen;
  static const String dashboardScreen = Routes.dashboardScreen;
  static const String dustbinPage= Routes.dustbinPage;
  static const String employeePage = Routes.employeePage;
  static const String exportDataScreen = Routes.exportDataScreen;
  static const String auditPageScreen = Routes.auditPageScreen;
  static const String logsPageScreen = Routes.logsPageScreen;
  static const String AccessListDustbinScreen = Routes.AccessListDustbinScreen;
  static const String profilePageScreen = Routes.profilePageScreen;
  static const String settingPageScreen = Routes.settingPageScreen;
  // ----------------------Admin---------------------------//
  static const String adminmainScreen = Routes.adminmainScreen;
  static const String admindashboardScreen = Routes.admindashboardScreen;
  static const String admindustbinPage= Routes.admindustbinPage;
  static const String adminemployeePage = Routes.adminemployeePage;
  static const String adminprofilePageScreen = Routes.adminprofilePageScreen;
  //----------------------Emp------------------------------//
  static const String empmainScreen = Routes.empmainScreen;


}
