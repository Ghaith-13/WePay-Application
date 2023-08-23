import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wepay/auth/Log_in.dart';

class ModelForName with ChangeNotifier {
  String token = "";
  bool isEnable = false;
  void convertIsenable() {
    isEnable = !isEnable;
    notifyListeners();
  }

  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    notifyListeners();
  }

  void logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Log_In()),
    );
    notifyListeners();
  }

  notifyListeners();
}
