import 'package:dio/dio.dart';
import 'package:easy_class/models/class_role.dart';
import 'package:easy_class/util/config.dart';

class RoleClient {
  static Future<bool> enterClass(ClassRole classRole) async {
    Dio dio = new Dio();
    FormData formdata = new FormData.fromMap(classRole.toJson());
    var response = await dio.post(GlobalConfig.url + "role/new/", data: formdata);
    Map resp = response.data;
    print(resp["msg"]);
    if (resp["code"] == "200") {
      return true;
    }
    return false;
  }
}