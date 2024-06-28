import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_intern/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  loadUser() async {
    final pref = await SharedPreferences.getInstance();

    String? userToJson = pref.getString('user');

    if (userToJson != null) {
      User user = User.fromJson(userToJson);
      _user = user;
      notifyListeners();
    }
  }

  void setUser(User user) async {
    final pref = await SharedPreferences.getInstance();

    String userToJson = user.toJson();
    pref.setString('user', userToJson);

    _user = user;
    notifyListeners();
  }

  clearUser() async {
    final pref = await SharedPreferences.getInstance();

    pref.remove('user');
    _user = null;
    notifyListeners();
  }
}
