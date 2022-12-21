import 'package:flutter/material.dart';
import 'package:flutter_nodejs/src/landing.dart';
import 'package:flutter_nodejs/src/loginsection.dart';
import 'package:flutter_nodejs/src/textfiel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CupertinoTextFieldDemo(),
      routes: {
        LandingScreen.id: (context) => LandingScreen(),
                LoginSection.id: (context) => LoginSection(),

        },
    );
  }
}
