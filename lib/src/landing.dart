import 'package:flutter/material.dart';
import 'package:flutter_nodejs/src/loginsection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatelessWidget {
  static  String id = "landingscreen";
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {

     return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(child: Text("Welcome to the Landing Screen")),
        TextButton.icon(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              // null co khong co ma thong qa k tu dong dang nhap 
              await prefs.setString('token','null' );
              Navigator.pushNamed(context, LoginSection.id);
            },
            icon: Icon(Icons.send),
            label: Text("Logout"))
      ],
    ));
  
  }
}
