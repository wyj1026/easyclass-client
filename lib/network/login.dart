import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:easy_class/models/index.dart';
import 'package:easy_class/util/config.dart';
import 'package:easy_class/util/storage.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:uuid/uuid.dart';

//var uuid = new Uuid();
//
//


class LoginClient {
  static Future<User> tryLogin(String email, String pass) async {
    Dio dio = new Dio();
    FormData formdata = new FormData.fromMap({
      "email": email,
      "password": pass,
    });
    var response = await dio.post(GlobalConfig.url + "user/login/", data: formdata);
    Map resp = response.data;
    print(resp["msg"]);
    if (resp["code"] == "200") {
      return User.fromJson(resp["entity"]);
    }
    return null;
  }

  static Future<User> signUp(String email, String pass) async {
    Dio dio = new Dio();
    FormData formdata = new FormData.fromMap({
      "email": email,
      "password": pass,
      "nickname": "用户dajl23jld",
      "avatar_url": GlobalConfig.url + "file/download/default.jpeg"
    });
    var response = await dio.post(GlobalConfig.url + "user/new/", data: formdata);
    Map resp = response.data;
    print(resp["msg"]);
    if (resp["code"] == "200") {
      return User.fromJson(resp["entity"]);
    }
    return null;
  }

  static Future<bool> update() async {
    Storage.save(GlobalConfig.user);
    Dio dio = new Dio();
    FormData formdata = new FormData.fromMap(GlobalConfig.user.toJson());
    print(GlobalConfig.user.toJson().toString());
    var response = await dio.post(GlobalConfig.url + "user/update/", data: formdata);
    Map resp = response.data;
    print(resp["msg"]);
    if (resp["code"] == "200") {
      return true;
    }
    return false;
  }
}