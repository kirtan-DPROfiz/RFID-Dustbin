import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message, //"This is Center Short Toast",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
