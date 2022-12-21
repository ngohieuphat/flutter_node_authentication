import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nodejs/src/landing.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class LoginSection extends StatelessWidget {
   static String id = "LoginSection";
    var email;
    var password;

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(),
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
        ),
        child: SafeArea(
          child: ListView(
            restorationId: 'text_field_demo_list_view',
            padding: const EdgeInsets.all(16),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CupertinoTextField(
                  textInputAction: TextInputAction.next,
                  restorationId: 'email_address_text_field',
                  placeholder: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  clearButtonMode: OverlayVisibilityMode.editing,
                  autocorrect: false,
                  onChanged: ((value) {
                    email = value;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CupertinoTextField(
                  textInputAction: TextInputAction.next,
                  restorationId: 'login_password_text_field',
                  placeholder: 'Password',
                  clearButtonMode: OverlayVisibilityMode.editing,
                  obscureText: true,
                  autocorrect: false,
                  onChanged: ((value) {
                    password = value;
                  }),
                ),
              ),
              TextButton.icon(
                  onPressed: () async {
                    login(email, password);
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    String? token = pref.getString("token");
                    if (token != null) {
                      Navigator.pushNamed(context, LandingScreen.id);
                    }
                  },
                  icon: Icon(Icons.save),
                  label: Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
login(email, password) async {
  var url = "http://localhost:3000/login";
  final http.Response response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  print(response.body);
  SharedPreferences pref = await SharedPreferences.getInstance();

  var parse = jsonDecode(response.body);
  // print(parse["token"]);
  await pref.setString('token', parse["token"]);
}
