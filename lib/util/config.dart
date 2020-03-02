import 'package:easy_class/models/user.dart';
import 'package:flutter/material.dart';

class GlobalConfig {
  static User user = null;
  static const String url = "http://192.168.1.103:9000/";
//  static const String url = "http://123.206.45.190:5000/";
  static Color primaryColor = Colors.white;
  static bool dark = false;
  static ThemeData themeData = new ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: new Color(0xFFEBEBEB),
  );
  static Color searchBackgroundColor = new Color(0xFFEBEBEB);
  static Color cardBackgroundColor = Colors.white;
  static Color fontColor = Colors.black54;

  static bool stuMode = true;
  static int near = 1000 * 60 * 60 * 24 * 1;
}

class UserMode extends ChangeNotifier {
  bool userMode = GlobalConfig.stuMode;

  bool get() {
    return userMode;
  }

  void change() {
    userMode = !userMode;
    notifyListeners();
  }
}