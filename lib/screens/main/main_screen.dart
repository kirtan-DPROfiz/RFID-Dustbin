import 'package:Deprofiz/controllers/menu_app_controller.dart';
import 'package:Deprofiz/responsive.dart';
import 'package:Deprofiz/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Authentication_services/auth_services.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    _verifyToken();
  }

  Future<void> _verifyToken() async {
    final authService = AuthService();
    final response = await authService.verifyToken(
      "https://intervein.dprofiz.com/Rfid_api/Auth/protected_api.php",
    );

    if (!response['success']) {
      // Token is invalid, navigate back to login
      Navigator.pushReplacementNamed(context,"/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
