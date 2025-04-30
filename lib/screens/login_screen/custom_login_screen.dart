/*
import 'package:Deprofiz/Authentication_services/auth_services.dart';
import 'package:Deprofiz/helper/sharedpreferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomLoginScreen extends StatefulWidget {
  final String apiUrl;

  const CustomLoginScreen({Key? key, required this.apiUrl}) : super(key: key);

  @override
  _CustomLoginScreenState createState() => _CustomLoginScreenState();
}

class _CustomLoginScreenState extends State<CustomLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    print('initState: LoginScreen initialized');
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    print('_checkLoginStatus: Checking login status...');
    final isLoggedIn = await SharedPreferencesHelper.isLoggedIn();
    print('_checkLoginStatus: isLoggedIn = $isLoggedIn');

    if (isLoggedIn) {
      print(
          '_checkLoginStatus: User is already logged in. Navigating to /main');
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      print('_checkLoginStatus: User is not logged in.');
    }
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      print('_login: Form is valid. Starting login process...');
      setState(() => _isLoading = true);
      print('_login: _isLoading set to true');

      final authService = AuthService(widget.apiUrl);
      print('_login: AuthService initialized with API URL: ${widget.apiUrl}');

      try {
        final success = await authService.login(
          _emailController.text,
          _passwordController.text,
        );
        print('_login: API call completed. Success = $success');

        if (success) {
          print('_login: Login successful. Saving credentials...');
          await SharedPreferencesHelper.saveCredentials(
            _emailController.text,
            _passwordController.text,
          );
          print('_login: Credentials saved. Navigating to /main');
          Navigator.pushReplacementNamed(context, '/main');
        } else {
          print('_login: Login failed. Showing error message.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed. Please try again.')),
          );
        }
      } catch (e) {
        print('_login: Error during login - $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred. Please try again.')),
        );
      } finally {
        setState(() => _isLoading = false);
        print('_login: _isLoading set to false');
      }
    } else {
      print('_login: Form is invalid. Please check the input fields.');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build: Building LoginScreen UI');
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                child: Text(
                  "Smart Dustbin",
                  style:
                      TextStyle(color: Colors.deepPurpleAccent, fontSize: 50),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'UserID',
                  prefixIcon: Icon(Icons.email),
                  prefixIconColor: Colors.blueAccent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email' : null,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.password),
                  prefixIconColor: Colors.blueAccent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                ),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your password' : null,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 32,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                        ),
                        onPressed: _login,
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

*/

import 'package:Deprofiz/Authentication_services/auth_services.dart';
import 'package:Deprofiz/Authentication_services/sharedpreferencehelper.dart';
import 'package:Deprofiz/helper/sharedpreferences_helper.dart';
import 'package:Deprofiz/screens/login_screen/Subscribtion/subscribtionplanpage.dart';
import 'package:Deprofiz/screens/login_screen/UserDetails/User_details.dart';
import 'package:Deprofiz/screens/login_screen/webViewpage/web_view_Screen.dart';
import 'package:Deprofiz/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Authentication_services/device_info_helper.dart';
import '../Footer/footer.dart';

class CustomLoginScreen extends StatefulWidget {
  // final String apiUrl; // Base API URL
  final String sendOtpurl =
      "https://intervein.dprofiz.com/Rfid_api/Auth/get_password.php"; // Endpoint for sending OTP
  final String verifyOtpurl =
      "https://intervein.dprofiz.com/Rfid_api/Auth/login.php"; // Endpoint for verifying OTP

  const CustomLoginScreen({
    Key? key,
    // required this.apiUrl,
    /*  required this.sendOtpurl,
    required this.verifyOtpurl,*/
  }) : super(key: key);

  @override
  _CustomLoginScreenState createState() => _CustomLoginScreenState();
}

class _CustomLoginScreenState extends State<CustomLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _useridController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isLoading = false;
  bool _otpSent = false; // Track if OTP has been sent
  //String _selectedRole = 'Super-Admin'; // Default selected role
  //final List<String> _roles = ['Super-Admin', 'Admin', 'Employee']; // Roles
  String? _emailError; // Error message for email field
  String? _useridError; // Error message for userId field
  String? _otpError; // Error message for userId field

  @override
  void initState() {
    super.initState();
    print('initState: LoginScreen initialized');
    _checkLoginStatus();
  }

/*  Future<void> _checkLoginStatus() async {
    print('_checkLoginStatus: Checking login status...');
    final isLoggedIn = await SharedPreferencesAuth.isLoggedIn();
    print('_checkLoginStatus: isLoggedIn = $isLoggedIn');

    if (isLoggedIn) {
      print(
          '_checkLoginStatus: User is already logged in. Navigating to /main');
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      print('_checkLoginStatus: User is not logged in.');
      String uuid =
          await SharedPreferencesAuth.getOrCreateUuid(); // Get the stored UUID
      print('local Stored : UUID fetched: $uuid');
    }
  }*/
  //-----------------------------new checkLoginStatus ------------------//
  Future<void> _checkLoginStatus() async {
    print('_checkLoginStatus: Checking login status...');
    final isLoggedIn = await SharedPreferencesAuth.isLoggedIn();
    print('_checkLoginStatus: isLoggedIn = $isLoggedIn');

    if (isLoggedIn) {
      print('_checkLoginStatus: User is already logged in. Verifying token...');
      print("checking for verifying Token..... ");
      final authService = AuthService();
      final response = await authService.verifyToken(
        "https://intervein.dprofiz.com/Rfid_api/Auth/protected_api.php",
      );
      if (response['success']) {
        print('_checkLoginStatus: Token is valid. Checking user role...');

        // Extract user details from the response
        final user = response['user'];
        final role = user['role'];

        print('Navigating user According to their role : $role .... ');

        // Navigate based on the user's role
        switch (role) {
          case 'super_admin':
            print(
                '_checkLoginStatus: User is a super_admin. Navigating to /main');
            Navigator.pushReplacementNamed(context, '/main');
            print("Login Successfully  as superAdmin !!");
            break;
          case 'admin':
            print(
                '_checkLoginStatus: User is an admin. Navigating to /adminmain');
            Navigator.pushReplacementNamed(context, '/adminmain');
            print("Login Successfully as Admin !!");
            break;
          case 'employee':
            print(
                '_checkLoginStatus: User is an employee. Navigating to /employee');
            Navigator.pushReplacementNamed(context, '/employee');
            print("Login Successfully as Employee !!");
            break;
          default:
            print('_checkLoginStatus: Unknown role. Logging out...');
            await SharedPreferencesAuth.clearToken();
            await SharedPreferencesAuth.clearCredentials();
            Navigator.pushReplacementNamed(context, '/login');
            break;
        }
      } else {
        print('_checkLoginStatus: Token is invalid. Logging out...');
        await SharedPreferencesAuth.clearToken();
        await SharedPreferencesAuth.clearCredentials();
        Navigator.pushReplacementNamed(context, "/login");
      }
    } else {
      print('_checkLoginStatus: User is not logged in.');
      String uuid =
          await SharedPreferencesAuth.getOrCreateUuid(); // Get the stored UUID
      print('local Stored : UUID fetched: $uuid');
    }
  }

  //---------------------send OTP funciton---------------------//
  Future<void> _sendOtp() async {
    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = "Please enter your email address.";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter  your email address.'),
        ),
      );
      print("Please enter  your email address.");
      GetSnackBar(
        title: "Error",
        messageText: Text(
          "Please enter  your email address.",
          style: TextStyle(color: Colors.redAccent),
        ),
        backgroundColor: Colors.black,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      setState(() {
        _emailError = null; // Clear error when email is entered
      });
    }

 /*   if (_useridController.text.isEmpty) {
      setState(() {
        _useridError = "Please enter your UserId.";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your UserId.'),
        ),
      );
      print("Please enter your UserId.");
      GetSnackBar(
        title: "Error",
        messageText: Text(
          "Please enter your UserId.",
          style: TextStyle(color: Colors.redAccent),
        ),
        backgroundColor: Colors.black,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      setState(() {
        _useridError = null; // Clear error when email is entered
      });
    }*/
    // otp :
    if (_otpController.text.isEmpty) {
      setState(() {
        _otpError = "Please enter your OTP.";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your OTP."),
        ),
      );
      print("Please enter your OTP.");
      GetSnackBar(
        title: "Error",
        messageText: Text(
          "Please enter your OTP.",
          style: TextStyle(color: Colors.redAccent),
        ),
        backgroundColor: Colors.black,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      setState(() {
        _otpError = null; // Clear error when email is entered
      });
    }


    setState(() => _isLoading = true);
    print('_sendOtp: Sending OTP to ${_emailController.text}');
    //print('_sendOtp: Sending OTP to ${_useridController.text}');

    final authService = AuthService();
    try {
      final success = await authService.sendOtp(
        widget.sendOtpurl, // Use the full URL
        _emailController.text,
       // _useridController.text,
      );

      if (success) {
        print('_sendOtp: OTP sent successfully.');
        setState(() => _otpSent = true); // Show OTP input field
        GetSnackBar(
          title: "OTP Send Successfully! ",
          messageText: Text(
            " Please, check your Email Sir !! ",
            style: TextStyle(color: Colors.greenAccent),
          ),
          backgroundColor: Colors.black,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        print('_sendOtp: Failed to send OTP.');
            ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to send OTP. Please try again.')),
        );
        GetSnackBar(
          title: "Error",
          messageText: Text(
            "Failed to send OTP. Please try again.",
            style: TextStyle(color: Colors.redAccent),
          ),
          backgroundColor: Colors.black,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print('_sendOtp: Error - $e');
      /* ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );*/
   /*   GetSnackBar(
        title: "Error",
        messageText: Text(
          "An error occurred. Please try again.",
          style: TextStyle(color: Colors.redAccent),
        ),
        backgroundColor: Colors.black,
        snackPosition: SnackPosition.TOP,
      );*/
      Get.snackbar(
        "Error",
        e.toString().replaceAll("Exception: ", ""),
        backgroundColor: Colors.black,
        colorText: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 4),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  //---------------------verify OTP funciton---------------------//
/*  Future<void> _verifyOtp() async {
    if (_otpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the OTP.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    print('_verifyOtp: Verifying OTP...');

    final authService = AuthService();
    try {
      final response = await authService.verifyOtp(
        widget.verifyOtpurl, // Use the full URL
        _emailController.text,
        _otpController.text,
      );

      if (response.isEmpty) {
        print('_verifyOtp: API response is empty. Redirecting to payment.');
        _redirectToPayment();
        return;
      }

      if (response.containsKey("error") &&
          response["error"] == "No active subscription found. Please complete the payment.") {
        print('_verifyOtp: No active subscription. Redirecting to payment page.');
        _redirectToPayment();
        return;
      }

      final success = response['success'];
      final token = response['token'];

      if (success) {
        print('_verifyOtp: OTP verified successfully.');

        await SharedPreferencesAuth.saveCredentials(
          _emailController.text,
          _otpController.text, // Save OTP temporarily
        );
        await SharedPreferencesAuth.saveToken(token);

        print("Checking for verifying Token...");
        final response = await authService.verifyToken(
          "https://intervein.dprofiz.com/Rfid_api/Auth/protected_api.php",
        );

        if (response['success']) {
          print('_checkLoginStatus: Token is valid. Checking user role...');
          final role = response['user']['role'];

          print('Navigating user according to their role: $role ...');
          switch (role) {
            case 'super_admin':
              Navigator.pushReplacementNamed(context,'/main');
              break;
            case 'admin':
              Navigator.pushReplacementNamed(context, '/adminmain');
              break;
            case 'employee':
              Navigator.pushReplacementNamed(context, '/empmain');
              break;
            default:
              await SharedPreferencesAuth.clearToken();
              await SharedPreferencesAuth.clearCredentials();
              Navigator.pushReplacementNamed(context, '/login');
              break;
          }
        } else {
          print('_checkLoginStatus: Token is invalid. Logging out...');
          await SharedPreferencesAuth.clearToken();
          await SharedPreferencesAuth.clearCredentials();
          Navigator.pushReplacementNamed(context, "/login");
        }
      } else {
        setState(() {
          _emailError = "Invalid OTP. Please check the OTP & try again." ;
        });
        print('_verifyOtp: OTP verification failed.');
        GetSnackBar(
          title: "Error",
          messageText: Text(
            "Invalid OTP. Please check the OTP & try again.",
            style: TextStyle(color: Colors.redAccent),
          ),
          backgroundColor: Colors.black,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print('_verifyOtp: Error - $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _redirectToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentWebView(
          paymentUrl: "https://intervein.dprofiz.com/Rfid_api/Payment/payment.html",
        ),
      ),
    );
  }*/
  //-------------------new-------------//
  Future<void> _verifyOtp() async {
    if (_otpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the OTP.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final authService = AuthService();
    try {
      final response = await authService.verifyOtp(
        widget.verifyOtpurl,
        _emailController.text,
        _otpController.text,
      );

      // Handle payment required case
      if (response['requires_payment'] == true) {
        print('Payment required - redirecting to payment page');
        _redirectToPayment();
        return;
      }

      if (!response['success']) {
        setState(() {
          _otpError = "Invalid OTP. Please check the OTP & try again.";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid OTP. Please check the OTP & try again.")),
        );
        return;
      }

      // Handle successful login
      final token = response['token'];
      await SharedPreferencesAuth.saveCredentials(
        _emailController.text,
        _otpController.text,
      );
      await SharedPreferencesAuth.saveToken(token);

      final verifyResponse = await authService.verifyToken(
        "https://intervein.dprofiz.com/Rfid_api/Auth/protected_api.php",
      );

      if (verifyResponse['success']) {
        final role = verifyResponse['user']['role'];
        print('User role: $role');

        switch (role) {
          case 'super_admin':
            Navigator.pushReplacementNamed(context, '/main');
            break;
          case 'admin':
            Navigator.pushReplacementNamed(context, '/adminmain');
            break;
          case 'employee':
            Navigator.pushReplacementNamed(context, '/empmain');
            break;
          default:
            await SharedPreferencesAuth.clearToken();
            await SharedPreferencesAuth.clearCredentials();
            Navigator.pushReplacementNamed(context, '/login');
            break;
        }
      } else {
        await SharedPreferencesAuth.clearToken();
        await SharedPreferencesAuth.clearCredentials();
        Navigator.pushReplacementNamed(context, "/login");
      }
    } catch (e) {
      print('_verifyOtp: Error - $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _redirectToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubscriptionPlansPage(),
      ),
    );
  }


/*  void _listenForPaymentSuccess() async {
    print("Waiting for payment success...");

    // Simulating periodic checking (replace this with actual WebView listener)
    Future.delayed(Duration(seconds: 5), () {
      // Simulating success message detection
      String pageContent = "Payment successful! Your subscription is activated."; // Simulated response

      if (pageContent.contains("Payment successful! Your subscription is activated.")) {
        print("Payment completed! Redirecting to CustomLoginScreen.");
        Navigator.pushReplacementNamed(context, '/customLogin');
      }
    });
  }*/

  Future<void> _launchSubscriptionUrl() async {
    final url = Uri.parse('https://intervein.dprofiz.com/Rfid_api/Payment/payment.html');
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }



  @override
  Widget build(BuildContext context) {
    print('build: Building LoginScreen UI');
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: AppBar(centerTitle: true, title: const Text('Login')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),

                    borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(  // Add this for the border
                        color: Colors.green,  // Green border color
                        width: 2.0,  // Border width
                      ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  width: 400, // Fixed width for the form
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Header Text
                        Text(
                          "Login Yourself",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Logo and Name
                        Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Dprofiz",
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Image.asset(
                                "assets/images/DprofizLogo.png",
                                height: 50, // Adjusted size
                              ),
                            ],
                          ),
                        ),

                        // Smart Dustbin Title
                        Text(
                          "Smart Dustbin",
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),

                       /* // userid Field
                        TextFormField(
                          controller: _useridController,
                          decoration: InputDecoration(
                            labelText: 'UserID',
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: "Enter your userId",
                            prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26.0),
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter your UserId' : null,
                        ),

                        if (_useridError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              _useridError!,
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),*/
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: "Enter your Email",
                            prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26.0),
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter your email' : null,
                        ),
                        const SizedBox(height:4 ),
                        // Error Message
                        if (_emailError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              _emailError!,
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ), // Error Message


                        const SizedBox(height: 12),

                        // Send OTP Button
                        _isLoading
                            ? const CircularProgressIndicator()
                            : SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurpleAccent,
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: _sendOtp,
                                  child: const Text(
                                    'Send OTP',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                        if (_otpSent) ...[
                          const SizedBox(height: 16),

                          // OTP Field
                          TextFormField(
                            controller: _otpController,
                            decoration: InputDecoration(
                              labelText: 'Enter OTP',
                              prefixIcon:
                                  Icon(Icons.lock, color: Colors.blueAccent),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(26.0),
                              ),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter the OTP' : null,
                          ),
                          const SizedBox(height:4 ),
                          if (_otpError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                _otpError!,
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                            ),
                          const SizedBox(height: 12),

                          // Verify OTP Button
                          _isLoading
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    onPressed: _verifyOtp,
                                    child: const Text(
                                      'Submit OTP',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 120),
                Padding(padding: EdgeInsets.all(1.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: (){

                      }, child: Text('PRIVACY POLICY',
                          style: TextStyle(color: Colors.blueAccent)),
                      ),
                      SizedBox(width: 4,),
                      TextButton(onPressed: (){
                        Get.to(()=>  UserDetailsForm());
                      }, child: Text(" Organization Registration ",//'Don\'t have an account? Sign up'
                          style: TextStyle(color: Colors.blueAccent)),
                      ),  TextButton(
                        onPressed: () async {
                          try {
                            final url = Uri.parse('https://intervein.dprofiz.com/Rfid_api/Payment/payment.html');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              throw 'Could not launch $url';
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        },
                        child: Text("Subscription Plans",//'Don\'t have an account? Sign up'
                          style: TextStyle(color: Colors.blueAccent)),
                      ),
                      SizedBox(width: 4,),
                      TextButton(onPressed: (){

                      }, child: Text('Terms & Condition',
                          style: TextStyle(color: Colors.blueAccent)),
                      )
                    ],
                  ) ,
                ),
                FooterWidget(),

              ],
            ),
          ),
        ),
      ),

    );

  }
}
