import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      color: Colors.white,
      child: Center(
        child: Text(
          '© 2025 DPROFIZ .PVT. LTD. All rights reserved.',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
