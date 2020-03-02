import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_class/models/class_role.dart';
import 'package:easy_class/models/user.dart';
import 'package:easy_class/util/config.dart';
import 'package:http/http.dart' as http;

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

  static Future<List<User>> getAllTeacher(int classId) async {
    Utf8Decoder utf8decoder = new Utf8Decoder();
    var client = http.Client();
    http.Response response = await client.get(GlobalConfig.url + "role/getClassTeachers/?id=" + classId.toString());
    Iterable l = json.decode(utf8decoder.convert(response.bodyBytes))["entity"];
    List<User> recs = l.map((model) => User.fromJson(model)).toList();
    return recs;
  }
}