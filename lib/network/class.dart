import 'dart:async';
import 'dart:convert';
import 'dart:convert' as prefix0;
import 'package:dio/dio.dart';
import 'package:easy_class/models/index.dart';
import 'package:easy_class/util/config.dart';
import 'package:http/http.dart' as http;

import 'package:uuid/uuid.dart';

var uuid = new Uuid();

class ClassClient {
  static Future<List<Class>> getAllMyClass() async {
    prefix0.Utf8Decoder utf8decoder = new Utf8Decoder();
    var client = http.Client();
    http.Response response = await client.get(GlobalConfig.url + "class/getBatchByUserId/?id=1");
    print(utf8decoder.convert(response.bodyBytes));
    Iterable l = json.decode(utf8decoder.convert(response.bodyBytes))["entity"];
    List<Class> recs = l.map((model) => Class.fromJson(model)).toList();
    return recs;
  }

  static Future<List<Class>> searchByName(String name) async {

  }

  static Future<Class> addClass(Class aclass) async {
    Dio dio = new Dio();
    FormData formdata = new FormData.fromMap(aclass.toJson());
    var response = await dio.post(GlobalConfig.url + "class/new/", data: formdata);
    Map resp = response.data;
    print(resp["msg"]);
    if (resp["code"] == "200") {
      return Class.fromJson(resp["entity"]);
    }
    return null;
  }

  static Future<bool> updateCLass(Class aclass) async {
    Dio dio = new Dio();
    FormData formdata = new FormData.fromMap(aclass.toJson());
    var response = await dio.post(GlobalConfig.url + "class/update/", data: formdata);
    Map resp = response.data;
    print(resp["msg"]);
    if (resp["code"] == "200") {
      return true;
    }
    return false;
  }

  static Future<bool> removeClass(int id) async {

  }
}