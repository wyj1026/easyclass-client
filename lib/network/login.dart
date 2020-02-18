import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:easy_class/models/index.dart';
import 'package:easy_class/util/config.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:uuid/uuid.dart';

var uuid = new Uuid();


void send_img(Asset asset, String filename) async {
  Uri uri = Uri.parse(GlobalConfig.url + "upload/");

  http.MultipartRequest request = http.MultipartRequest("POST", uri);

  ByteData byteData = await asset.getByteData();
  List<int> imageData = byteData.buffer.asUint8List();

  http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
    'file',
    imageData,
    filename: filename,
    contentType: MediaType("image", "jpg"),
  );

// add file to multipart
  request.files.add(multipartFile);
// send
  var response = await request.send();
}

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
      "nickname": "用户dajl23jld"
    });
    var response = await dio.post(GlobalConfig.url + "user/new/", data: formdata);
    Map resp = response.data;
    print(resp["msg"]);
    if (resp["code"] == "200") {
      return User.fromJson(resp["entity"]);
    }
    return null;
  }
}