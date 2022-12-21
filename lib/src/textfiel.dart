// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CupertinoTextFieldDemo extends StatelessWidget {
  const CupertinoTextFieldDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email;
    var password;
    return CupertinoPageScaffold(
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
                onPressed: () {
                  print(email);
                  print(password);
                 signup(email, password);
                },
                icon: Icon(Icons.save),
                label: Text('Sign UP'))
          ],
        ),
      ),
    );
  }
}

signup(email, password) async {
  var url = "localhost:3000/signup";
  final http.Response response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email':  email,
      'password': password,
    }),
  );
  print(response.body);
//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create album.');
//   }
}
