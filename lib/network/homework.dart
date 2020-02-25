import 'dart:async';
import 'dart:convert';
import 'dart:convert' as prefix0;
import 'package:dio/dio.dart';
import 'package:easy_class/models/index.dart';
import 'package:easy_class/util/config.dart';
import 'package:easy_class/util/storage.dart';
import 'package:http/http.dart' as http;

import 'package:uuid/uuid.dart';

var uuid = new Uuid();

class HomeworkClient {
  static const List<String> types = <String>[
    "getToCommitByUserId",
    "getNotJudgedByUserId",
    "getJudgedByUserId",
    "getPushedByTeacherUserId",
    "getToJudgeByTeacherUserId",
    "getJudgedByTeacherUserId",
  ];

  static Future<List<Homework>> getHomework(int type) async {
    if (GlobalConfig.user == null) {
      await Storage.is_login();
    }
    prefix0.Utf8Decoder utf8decoder = new Utf8Decoder();
    var client = http.Client();
    http.Response response = await client.get(GlobalConfig.url + "homework/"+ types[type] + "/?id=" + GlobalConfig.user.id.toString());
    print(utf8decoder.convert(response.bodyBytes));
    Iterable l = json.decode(utf8decoder.convert(response.bodyBytes))["entity"];
    List<Homework> recs = l.map((model) => Homework.fromJson(model)).toList();
    return recs;
  }

  static Future<Homework> addHomework(Homework homework) async {
    Dio dio = new Dio();
    FormData formdata = new FormData.fromMap(homework.toJson());
    var response = await dio.post(GlobalConfig.url + "homework/new/", data: formdata);
    Map resp = response.data;
    print(resp["msg"]);
    if (resp["code"] == "200") {
      return Homework.fromJson(resp["entity"]);
    }
    return null;
  }
}