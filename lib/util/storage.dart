import 'package:easy_class/models/index.dart';
import 'package:easy_class/util/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Storage {
  static Future<bool> is_login() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("user")) {
      String userString = preferences.getString("user");
      User u = User.fromJson(json.decode(userString));
      preferences.setInt("login_timestamp", DateTime.now().millisecondsSinceEpoch);
      GlobalConfig.user = u;
      return true;
    }
    else{
      return false;
    }
  }

  static void save(User user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String str = new JsonEncoder.withIndent("    ").convert(user.toJson());
    preferences.setString("user", str);
    preferences.setInt("login_timestamp", DateTime.now().millisecondsSinceEpoch);
}

  static delete() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("user");
    preferences.remove("login_timestamp");
  }

  static Future<int> get_timestamp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt("login_timestamp");
  }
}