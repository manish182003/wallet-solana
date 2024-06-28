import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_intern/Provider/Provider.dart';
import 'package:wallet_intern/home/screens/homescreen.dart';
import 'package:wallet_intern/models/user.dart';
import 'package:wallet_intern/utility.dart';
import 'package:http/http.dart' as http;

class LoginServices {
  loginUser(BuildContext context, String email, String password) async {
    try {
      email = email.trim();
      password = password.trim();
      var res = await http.post(
        Uri.parse('https://api.socialverseapp.com/user/login'),
        body: {
          "mixed": email,
          "password": password,
        },
      );

      var data = jsonDecode(res.body);

      if (data['status'] == 'error') {
        showSnackBar(context, data['message']);
      } else {
        User user = User.fromMap(data);
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Navigator.pushNamedAndRemoveUntil(
          context,
          Homescreen.routename,
          (route) => false,
        );
        showSnackBar(context, 'User Login Sucess');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
