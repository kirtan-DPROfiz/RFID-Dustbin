import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/DprofizLogo.png",
                  height: 50, // Adjusted size
                ),
                SizedBox(width: 8),
                Column(
                  children: [
                    Text(
                      "Dprofiz.PVT.LTD",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        label: Text("Company Name : "),
                      ),
                      readOnly: true,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        label: Text("Company Address : "),
                      ),
                      readOnly: true,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
