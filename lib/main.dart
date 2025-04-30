import 'dart:ui';

import 'package:Deprofiz/constants.dart';
import 'package:Deprofiz/controllers/menu_app_controller.dart';
import 'package:Deprofiz/res/routes/navigation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;
import 'dart:html' as html;


import 'screens/main/main_screen.dart';

void main() {
  runApp(MyApp());
}

void startNFCReader(Function(String) onCardRead) {
  print("Calling initNFCReader()..."); // Debug log
  js.context.callMethod('initNFCReader'); // Start JS reader
  html.window.addEventListener('nfc-card-read', (event) {
    final cardId = (event as html.CustomEvent).detail;
       onCardRead(cardId);
  });


  // Trigger JavaScript function to start NFC reader
  html.window.dispatchEvent(html.CustomEvent('start-nfc-reader'));
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: AppNavigator(),
      ),
    );
  }
}


/*void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Panel',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        home: AppNavigator(),
      ),
    );
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: AppNavigator(),
      ),
    );
  }
}*/
