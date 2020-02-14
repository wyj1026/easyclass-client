import 'package:flutter/material.dart';

class GlobalConfig {
  static const String serverUrl = "http://123.206.45.190:5000/";
  static Color primaryColor = Colors.white;
  static bool dark = false;
  static ThemeData themeData = new ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: new Color(0xFFEBEBEB),
  );
  static Color searchBackgroundColor = new Color(0xFFEBEBEB);
  static Color cardBackgroundColor = Colors.white;
  static Color fontColor = Colors.black54;
}