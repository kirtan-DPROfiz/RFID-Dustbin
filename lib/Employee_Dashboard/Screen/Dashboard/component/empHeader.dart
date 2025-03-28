import 'dart:developer';

import 'package:Deprofiz/Authentication_services/auth_services.dart';
import 'package:Deprofiz/controllers/menu_app_controller.dart';
import 'package:Deprofiz/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../../Authentication_services/sharedpreferencehelper.dart';
import '../../../../constants.dart';
import '../../../../screens/login_screen/custom_login_screen.dart';

class EmpHeader extends StatelessWidget {
  const EmpHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: context.read<MenuAppController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent,
            Colors.purpleAccent
          ], // Add gradient for modern look
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/adminuser.png",
            height: 38,
            color: Colors.white,
          ),
          if (!Responsive.isMobile(
              context)) // If not mobile, show the role text
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(
                "Employee",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          // Profile Dropdown Menu
          // PopupMenuButton<String>(
          //   color: bgColor,
          //   onSelected: (String result) {
          //     if (result == 'logout') {
          //       _showLogoutDialog(context); // Show Logout dialog
          //     } else if (result == 'login') {
          //       _showLoginDialog(context); // Show Login dialog
          //     }
          //   },
          //   itemBuilder: (BuildContext context) {
          //     return [
          //       PopupMenuItem<String>(
          //
          //         value: 'login',
          //         child: Row(
          //           children: [
          //             Icon(Icons.login, color: Colors.white),
          //             SizedBox(width: 8),
          //             Text('Login', style: TextStyle(color: Colors.white)),
          //           ],
          //         ),
          //       ),
          //       PopupMenuItem<String>(
          //         value: 'logout',
          //         child: Row(
          //           children: [
          //             Icon(Icons.logout, color: Colors.white),
          //             SizedBox(width: 8),
          //             Text('Logout', style: TextStyle(color: Colors.white)),
          //           ],
          //         ),
          //       ),
          //     ];
          //   },
          //   icon: Icon(Icons.keyboard_arrow_down, color: Colors.white), // Dropdown icon
          // ),

          // Show dropdown inside the container
          Container(
            padding: EdgeInsets.all(defaultPadding / 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.purpleAccent
                ], // Gradient for dropdown
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildDropdownItem(
                  icon: Icons.logout,
                  text: "Logout",
                  onTap: () {
                    print("Logout Fucntion is being calling...! ");
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build dropdown items
  Widget _buildDropdownItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // Show the Login Dialog
  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: LoginForm(),
          ),
        );
      },
    );
  }

  // Show the Logout Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              /* onPressed: () async {
               try{
                 final authService = AuthService();
                 // Call the logout method
                 final success = await authService.logout(
                     'https://intervein.dprofiz.com/Rfid_api/Auth/logout.php');
                 if (success) {
                   // Clear saved credentials
                   await SharedPreferencesHelper.clearCredentials();
                   await SharedPreferencesHelper.clearToken();

                   print(" Log out Successfully! ");
                   log("log out Successfully ");
                   // Navigate to the CustomLoginScreen
                   Get.offAll(() => CustomLoginScreen());
                 } else {
                   print("Logout failed. Please try again.");


                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       content: Text(
                         'Logout failed. Please try again.',
                         style: TextStyle(color: Colors.redAccent), // Set text color to redAccent
                       ),
                       backgroundColor: Colors.black, // Set background color to black
                       behavior: SnackBarBehavior.floating, // Allows positioning
                       margin: EdgeInsets.only(
                         bottom: MediaQuery.of(context).size.height - 100, // Adjust margin to position at the top
                         left: 20,
                         right: 20,
                       ),
                     ),
                   );
                 }
                 Get.back();
                  // Close the dialog
                 print("Logged out!");
               }catch(e){
                 print("Failed to Log out ");
               }
              },*/
              //---------------------new -----------------------//
              onPressed: () async {
                try {
                  final authService = AuthService();
                  final success = await authService.logout(
                    'https://intervein.dprofiz.com/Rfid_api/Auth/logout.php',
                    dialogContext, // Use dialogContext inside dialog
                  );

                  Navigator.pop(
                      dialogContext); // Close the dialog before SnackBar

                  if (success) {
                    await SharedPreferencesAuth.clearCredentials();
                    await SharedPreferencesAuth.clearToken();
                    final response = await SharedPreferencesAuth.isLoggedIn();
                    print("isloggin status : $response");

                    print("Log out Successfully! at header");

                    /*   if (context.mounted) {  // Ensure the context is still valid
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Logout successful.")),
                      );
                    }*/

                    // Delay navigation to allow UI updates
                    print("Navigating user to the Login Screen! ");
                    Future.delayed(Duration(milliseconds: 500), () {
                      Get.offAll(() => CustomLoginScreen());
                    });
                  } else {
                    print("Logout failed. Please try again.");
                    /*   if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Logout failed. Please try again.")),
                      );
                    }*/
                  }
                } catch (e) {
                  print("Failed to Log out: $e");
                }
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Login",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: defaultPadding),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: secondaryColor,
              prefixIcon: Icon(Icons.email, color: Colors.white),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              String pattern = r'\w+@\w+\.\w+';
              RegExp regExp = RegExp(pattern);
              if (!regExp.hasMatch(value)) {
                return 'Invalid email format';
              }
              return null;
            },
          ),
          SizedBox(height: defaultPadding),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: secondaryColor,
              prefixIcon: Icon(Icons.lock, color: Colors.white),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Print email and password to console (for now)
                print('Email: ${_emailController.text}');
                print('Password: ${_passwordController.text}');
                // Perform login functionality here
                Navigator.pop(context); // Close the dialog after login
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Custom button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor, // Use the secondary background color
        borderRadius:
            BorderRadius.circular(12), // Rounded corners for modern look
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.1), // Soft shadow for a floating effect
            blurRadius: 8,
            offset: Offset(0, 4), // Adjust shadow position
          ),
        ],
      ),
      child: TextField(
        style: TextStyle(
            color: Colors
                .white), // Text color (white for contrast on dark background)
        decoration: InputDecoration(
          hintText: "ID-wise Search", // More descriptive hint text
          hintStyle:
              TextStyle(color: Colors.white70), // Lighter hint text color
          fillColor: secondaryColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20), // Adding padding for a more spacious look
          suffixIcon: InkWell(
            onTap: () {
              // Add search functionality here
            },
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                    0.2), // Semi-transparent background for the icon button
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                "assets/icons/Search.svg",
                color: bgColor, // Assuming bgColor is a lighter color
                height: 20, // Adjust the icon size
                width: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
