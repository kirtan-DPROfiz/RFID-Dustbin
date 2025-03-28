// navigation.dart

import 'package:Deprofiz/Admin_Dashboard/Screen/profile/admin_profile_screen.dart';
import 'package:Deprofiz/Employee_Dashboard/main_screen.dart';
import 'package:Deprofiz/res/routes/routes.dart';
import 'package:Deprofiz/screens/access_Dustbin/access_List_Dustbin.dart';
import 'package:Deprofiz/screens/login_screen/custom_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import '../../Admin_Dashboard/Screen/Dashboard/adminDashboard.dart';
import '../../Admin_Dashboard/Screen/Dustbin/admin_dustbin_Screen.dart';
import '../../Admin_Dashboard/Screen/employee/admin_employee_screen.dart';
import '../../Admin_Dashboard/main_Screen.dart';
import '../../screens/audit/audit_page_screen.dart';
import '../../screens/dashboard/dashboard_screen.dart';
import '../../screens/dustbin/dustbin_page_screen.dart';
import '../../screens/employee/employee_page_screen.dart';
import '../../screens/export_data/export_data_screen.dart';
import '../../screens/logs/logs_page_screen.dart';
import '../../screens/main/main_screen.dart';
import '../../screens/profile/profile_page_screen.dart';
import 'routes_name.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      initialRoute: RouteNames.loginScreen, // Start with the main screen
      onGenerateRoute: (RouteSettings settings) {
        // Custom route animation with PageRouteBuilder
        switch (settings.name) {
          case Routes.loginScreen:
            return _buildRoute(CustomLoginScreen(
/*              sendOtpurl:
                  "https://intervein.dprofiz.com/Rfid_api/Auth/get_password.php",
              verifyOtpurl:
                  "https://intervein.dprofiz.com/Rfid_api/Auth/login.php",*/
                ));
          case Routes.mainScreen:
            return _buildRoute(MainScreen());

          //---------------Admin--------------//
          case Routes.adminmainScreen:
            return _buildRoute(AdminMainScreen());
          case Routes.admindashboardScreen:
            return _buildRoute(AdminDashboardScreen());
          case Routes.admindustbinPage:
            return _buildRoute(AdminDustbinPageScreen());
          case Routes.adminemployeePage:
            return _buildRoute(AdminEmployeePageScreen());
          case Routes.adminprofilePageScreen:
            return _buildRoute(AdminProfilePageScreen());
          //----------------------------------------------//

          //--------------Emp----------------//
          case Routes.empmainScreen:
            return _buildRoute(EmpMainScreen());

          //----------------------------------------//
          /*      case RouteNames.dashboardScreen:
            return _buildRoute(DashboardScreen());*/
          case Routes.dustbinPage:
            return _buildRoute(DustbinPage());
          case Routes.employeePage:
            return _buildRoute(EmployeePage());
          case Routes.exportDataScreen:
            return _buildRoute(ExportDataScreen());
          case Routes.auditPageScreen:
            return _buildRoute(AuditPageScreen());
          case Routes.logsPageScreen:
            return _buildRoute(LogsPageScreen());
          case Routes.AccessListDustbinScreen:
            return _buildRoute(AccessListDustbin());
          case Routes.profilePageScreen:
            return _buildRoute(ProfilePageScreen());
          case Routes.settingPageScreen:
          //  return _buildRoute(SettingPageScreen());
          default:
            return null;
        }
      },
    );
  }

  // Method to create a custom route with fade animation
  PageRouteBuilder _buildRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide from right to left
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        // Slide transition
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
