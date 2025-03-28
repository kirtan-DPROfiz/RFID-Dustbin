
import 'package:Deprofiz/Employee_Dashboard/Screen/DustbinScreen/emp_Dustbin_screen.dart';
import 'package:Deprofiz/Employee_Dashboard/component/Empsidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Authentication_services/auth_services.dart';

import '../controllers/menu_app_controller.dart';
import '../responsive.dart';

class EmpMainScreen extends StatefulWidget {
  const EmpMainScreen({super.key});

  @override
  State<EmpMainScreen> createState() => _EmpMainScreenState();
}

class _EmpMainScreenState extends State<EmpMainScreen> {
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


  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: EmpSideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child:EmpSideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: EmpDustbinPageScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
