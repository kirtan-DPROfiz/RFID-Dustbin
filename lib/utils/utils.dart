

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Utils {


  static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode  nextFocus ){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }



  static snackBar(String title, String message){
    Get.snackbar(
      title,
      message ,
    );
  }
}