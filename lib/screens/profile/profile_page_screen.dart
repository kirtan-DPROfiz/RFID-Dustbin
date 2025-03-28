/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  _ProfilePageScreenState createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  String profilePic =
      'https://picsum.photos/200'; // Placeholder Profile Picture
  String username = 'John Doe';
  String email = 'johndoe@example.com';
  String birthdate = '1995-06-15';

  void _updateField(
      String field, String currentValue, Function(String) onUpdate) {
    TextEditingController controller =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update $field'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: 'Enter new $field'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                onUpdate(controller.text.trim());
              });
              Get.back();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

     */
/*  void _updateProfilePic() {
    // Here, you can implement image picker functionality
    setState(() {
      profilePic = //'https://picsum.photos/200';
          'https://via.placeholder.com/150/0000FF/808080?Text=UpdatedPic';
    });
  }*/ /*


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double profileSize = constraints.maxWidth < 600
              ? 80
              : 100; // Adjust size for mobile vs desktop
          double textSize = constraints.maxWidth < 600 ? 14 : 16;
          double cardWidth =
              constraints.maxWidth < 600 ? constraints.maxWidth * 0.9 : 500;

          return Center(
            child: Card(
              color: Colors.cyanAccent,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple], // Two color combination
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: cardWidth, // Responsive card width
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Profile Picture
                        GestureDetector(
                          onTap: _updateProfilePic,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: profileSize / 2, // Responsive profile pic
                                backgroundImage: NetworkImage(profilePic),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: profileSize * 0.15,
                                  child: Icon(Icons.camera_alt,
                                      color: Colors.white,
                                      size: profileSize * 0.2),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),

                        // User Details
                        _buildProfileField(
                            'Username', username, Icons.person, textSize,
                            (value) {
                          setState(() {
                            username = value;
                          });
                        }),
                        _buildProfileField('Email', email, Icons.email, textSize,
                            (value) {
                          setState(() {
                            email = value;
                          });
                        }),
                       */
/* _buildProfileField(
                            'Birthdate', birthdate, Icons.cake, textSize,
                            (value) {
                          setState(() {
                            birthdate = value;
                          });
                        }),*/ /*

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileField(String label, String value, IconData icon,
      double textSize, Function(String) onUpdate) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(value, style: TextStyle(fontSize: textSize)),
        subtitle: Text(label,
            style: TextStyle(color: Colors.grey, fontSize: textSize * 0.9)),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            _updateField(label, value, onUpdate);
          },
        ),
      ),
    );
  }
}
*/

// --------------------------- new profile ------------------------------//
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Deprofiz/models/api_models/profileListInArray.dart';
import 'package:Deprofiz/network%20manager/rest_client.dart';

import '../Footer/footer.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  bool isLoading = true;
  String errorMessage = "";
  ProfileListInArray? profileData;
  String? _newemailError; // Error message for email field
  String? _OtpError; // Error message for email field

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  void profileList() {
    log("➡️ [START] Fetching employee data...");

    RestClient.getProfileListInArray().then((value) {
      log("✅ API Response: $value");

      if (value == null) {
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
    });
  }

  @override
  void initState() {
    super.initState();
    profileList();
  }

  // ---------------------- UPDATE EMAIL FUNCTION ---------------------- //
  void updateEmail() {
    TextEditingController emailController =
        TextEditingController(text: profileData?.email);
    TextEditingController otpController = TextEditingController();
    TextEditingController newEmailController = TextEditingController();
    bool otpSent = false; // To track OTP status

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text("Update Email"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Current Email Field
                  TextFormField(
                    controller: emailController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Current Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Send OTP Button
                  if (!otpSent)
                    ElevatedButton(
                      onPressed: () async {
                        bool otpSuccess = await sendOtp(emailController.text);
                        if (otpSuccess) {
                          setState(() {
                            otpSent = true;
                          });
                        }
                      },
                      child: const Text("Send OTP"),
                    ),

                  // OTP & New Email Fields (shown only after OTP is sent)
                  if (otpSent) ...[
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Enter OTP",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Show error message below the email field
                    if (_OtpError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _OtpError!,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: newEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Enter New Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Show error message below the email field
                    if (_newemailError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _newemailError!,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),

                    const SizedBox(height: 16),
                  ]
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                if (otpSent)
                  ElevatedButton(
                    onPressed: () async {
                      bool updateSuccess = await verifyOtpAndUpdateEmail(
                        emailController.text,
                        otpController.text,
                        newEmailController.text,
                      );

                      if (updateSuccess) {
                        Navigator.pop(context);
                        profileList(); // Refresh profile
                      }
                    },
                    child: const Text("Submit"),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  // ---------------------- SEND OTP FUNCTION ---------------------- //
  Future<bool> sendOtp(String email) async {
    try {
      final bool isOtpSent = await RestClient.profileSendOtp(
        _emailController.text,
      );
      if (isOtpSent) {
        print(" OTP Sent !! , Check your email for the OTP.");
        Get.snackbar("OTP Sent", "Check your email for the OTP.",
            snackPosition: SnackPosition.BOTTOM);
        return true;
      } else {
        Get.snackbar("Error", "Failed to send OTP.",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        return false;
      }
    } catch (e) {
      log("❌ Error sending OTP: $e");
      Get.snackbar("Error", "Something went wrong.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return false;
    }
  }

  // ---------------------- VERIFY OTP & UPDATE EMAIL ---------------------- //
  Future<bool> verifyOtpAndUpdateEmail(
      String currentEmail, String otp, String newEmail) async {
    try {
      if (newEmail == null) {
        setState(() {
          _newemailError = "Please enter your New Email Address, sir !! ";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter the newEmail, Sir! ')),
        );
      } else if (otp == null) {
        setState(() {
          _OtpError = "Please enter your OTP , sir !! ";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter the OTP,  sir! .')),
        );
      } else {
        setState(() {
          _newemailError = null; // Clear error when email is entered
        });
        setState(() {
          _OtpError = null; // Clear error when email is entered
        });
      }
      final response = await RestClient.VerifyOtpandUpdateEmail(
        currentEmail,
        otp,
        newEmail,
      );

      if (response['success'] == true) {
        Get.snackbar("Success", "Email updated successfully.",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
        return true;
      } else {
        Get.snackbar("Error", response['message'] ?? "Failed to update email.",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        return false;
      }
    } catch (e) {
      log("❌ Error updating email: $e");
      Get.snackbar("Error", "Something went wrong.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return false;
    }
  }

  // ---------------------- BUILD UI ---------------------- //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child:
                      Text(errorMessage, style: TextStyle(color: Colors.red)))
              : LayoutBuilder(builder: (context, constraints) {
                  double textSize = constraints.maxWidth < 600 ? 14 : 16;
                  double cardWidth = constraints.maxWidth < 600
                      ? constraints.maxWidth * 0.9
                      : 500;
                  return Center(
                    child: Card(
                      color: Colors.cyanAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.purple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: SizedBox(
                            width: cardWidth, // Responsive Width of card
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Employee Name
                                TextField(
                                  controller: _nameController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    label: Text("Employee Name",style: TextStyle(color: Colors.white),),
                                    //labelText: "Employee Name",
                                    prefixIcon: const Icon(Icons.person,
                                        color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.3),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 20),

                                // Employee Email with Update Icon
                                TextFormField(
                                  controller: _emailController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    label: Text("Employee Email",style: TextStyle(color: Colors.white),),
                                    //labelText: "Employee Email",
                                    prefixIcon: const Icon(Icons.email,
                                        color: Colors.white),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.white),
                                      onPressed: updateEmail,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.3),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                ),

                              ],
                            ),
                          ),
                      ),
                    ),

                  );

              }
              ),
    );

  }
}

//-----------------------//
/*

Future<void> _sendOtp() async {
  if (_emailController.text.isEmpty) {
    setState(() {
      _emailError = "Please enter your email address.";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter  your email address.'),
      ),
    );
    print("Please enter  your email address.");
    GetSnackBar(title: "Error",
      messageText: Text("Please enter  your email address.",style: TextStyle(color: Colors.redAccent),) ,
      backgroundColor: Colors.black,
      snackPosition: SnackPosition.TOP,
    );
  }else{
    setState(() {
      _emailError = null; // Clear error when email is entered
    });
  }

  setState(() => _isLoading = true);
  print('_sendOtp: Sending OTP to ${_emailController.text}');

  //final authService = AuthService();
  try {
    final success = await authService.sendOtp(
      widget.sendOtpurl, // Use the full URL
      _emailController.text,
    );

    if (success) {
      print('_sendOtp: OTP sent successfully.');
      setState(() => _otpSent = true); // Show OTP input field
      GetSnackBar(title: "OTP Send Successfully! ",
        messageText: Text(" Please, check your Email Sir !! ",style: TextStyle(color: Colors.greenAccent),) ,
        backgroundColor: Colors.black,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      print('_sendOtp: Failed to send OTP.');
      */
/*    ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to send OTP. Please try again.')),
        );*/ /*

      GetSnackBar(title: "Error",
        messageText: Text("Failed to send OTP. Please try again.",style: TextStyle(color: Colors.redAccent),) ,
        backgroundColor: Colors.black,
        snackPosition: SnackPosition.TOP,
      );

    }
  } catch (e) {
    print('_sendOtp: Error - $e');
    */
/* ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );*/ /*

    GetSnackBar(title: "Error",
      messageText: Text("An error occurred. Please try again.",style: TextStyle(color: Colors.redAccent),) ,
      backgroundColor: Colors.black,
      snackPosition: SnackPosition.TOP,
    );
  } finally {
    setState(() => _isLoading = false);
  }
}

Future<void> _verifyOtp() async {
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

    final success = response['success'];
    final token = response['token'];
    final cardId = response['card_id'];
    final role = response['role'];

    if (success) {
      print('_verifyOtp: OTP verified successfully.');
      print(' verification of token is executing for login.....');
      print('Generated Token: $token'); // Log the token to the console
      print('Card ID: $cardId'); // Log the card ID to the console
      print('Role: $role'); // Log the role to the console

      // Save credentials and token
      await SharedPreferencesAuth.saveCredentials(
        _emailController.text,
        _otpController.text, // Save OTP as password (temporary)
      );
      await SharedPreferencesAuth.saveToken(token); // Save the token

      //--------------------new--------------//
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
            print('_checkLoginStatus: User is an admin. Navigating to /adminmain');
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
      }else {
        print('_checkLoginStatus: Token is invalid. Logging out...');
        await SharedPreferencesAuth.clearToken();
        await SharedPreferencesAuth.clearCredentials();
        Navigator.pushReplacementNamed(context,"/login");
      }
    } else {
      print('_verifyOtp: OTP verification failed.');
      print("Invalid OTP. Please try again.");

      GetSnackBar(title: "Error",
        messageText: Text("Invalid OTP. Please try again.",style: TextStyle(color: Colors.redAccent),) ,
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


// Method to edit an existing dustbin
void UpdateEmail(String email) {
  print("editEmail() called for Email : $email"); // Log method call
  TextEditingController emailController =
  TextEditingController(text: email);


  // Show dialog for editing dustbin details
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Edit Dustbin'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [


          // TextField for editing Location
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          // Email Field
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'UserID',
              hintText: "Enter your Email",
              prefixIcon: Icon(Icons.email),
              prefixIconColor: Colors.blueAccent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(26.0),
              ),
            ),
            validator: (value) =>
            value!.isEmpty ? 'Please enter your email' : null,
          ),
          const SizedBox(height: 16),

          // Show error message below the email field
          if (_emailError != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _emailError!,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),


          const SizedBox(height: 16),

          // Send OTP Button
          _isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
            height: 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
              ),
              onPressed: _sendOtp,
              child: const Text(
                'Send OTP',
                style: TextStyle(
                    color: Colors.black87, fontSize: 16),
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
                prefixIcon: Icon(Icons.lock),
                prefixIconColor: Colors.blueAccent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(26.0),
                ),
              ),
              validator: (value) =>
              value!.isEmpty ? 'Please enter the OTP' : null,
            ),
            const SizedBox(height: 16),

            // Verify OTP Button
            _isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
              height: 32,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                onPressed: _verifyOtp,
                child: const Text(
                  'Submit OTP',
                  style: TextStyle(
                      color: Colors.black87, fontSize: 16),
                ),
              ),
            ),
          ],

        ],
      ),
      actions: [
        // Cancel button to close the dialog
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel'),
        ),
        // Update button to save changes
        TextButton(
          onPressed: () async {
            //print("✏️ [DustbinPage] Attempting to update dustbin: ID=${idController.text}, Location=${locationController.text}");

            try {
              await RestClient.updateEmployee({
                "Card_ID": idController,
                "Employee_Name": empNameController,
                "Department": departmentController,
                "Designation": departmentController,
                "Email_ID": emailController,
              });
              Get.snackbar("Success", "Dustbin updated successfully!",
                  backgroundColor: Colors.black,
                  colorText: Colors.greenAccent,
                  snackPosition: SnackPosition.TOP);
              userList();
              //UserListInArrayEmp(); // Refresh the list
              Get.back();
            } catch (e) {
              Get.snackbar("Error", "Failed to update dustbin: $e",
                  backgroundColor: Colors.black,
                  colorText: Colors.redAccent,
                  snackPosition: SnackPosition.TOP);
            }
            setState(() {
              cardId["card_id"] = idController.text.trim();
              cardId["email"] = emailController.text.trim();
              cardId["emp_name"] = empNameController.text.trim();
              cardId["department"] = departmentController.text.trim();
              cardId["designation"] = designationController.text.trim();

              print("Updated NewEmail: $newEmail"); // Log updated data
            });
            Get.back(); // Close the dialog
          },
          child: Text('Update'),
        ),
      ],
    ),
  );
}
*/
