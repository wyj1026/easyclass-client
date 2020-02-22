import 'dart:async';
import 'dart:convert';
import 'dart:convert' as prefix0;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_class/models/index.dart';
import 'package:easy_class/util/config.dart';
import 'package:easy_class/util/storage.dart';
import 'package:http/http.dart' as http;

import 'package:uuid/uuid.dart';

var uuid = new Uuid();

class QuestionClient {
  static Future<List<Class>> getAllMyClass() async {
    if (GlobalConfig.user == null) {
      await Storage.is_login();
    }
    prefix0.Utf8Decoder utf8decoder = new Utf8Decoder();
    var client = http.Client();
    http.Response response = await client.get(GlobalConfig.url + "class/getBatchByUserId/?id=" + GlobalConfig.user.id.toString());
    print(utf8decoder.convert(response.bodyBytes));
    Iterable l = json.decode(utf8decoder.convert(response.bodyBytes))["entity"];
    List<Class> recs = l.map((model) => Class.fromJson(model)).toList();
    return recs;
  }

  static Future<Class> getById(String id) async {
    prefix0.Utf8Decoder utf8decoder = new Utf8Decoder();
    var client = http.Client();
    print("id is:" + id);
    http.Response response = await client.get(GlobalConfig.url + "class/getById/?id=" + id);
    print(utf8decoder.convert(response.bodyBytes));
    Map l = json.decode(utf8decoder.convert(response.bodyBytes))["entity"];
    return Class.fromJson(l);
  }

  static Future<List<Class>> searchByName(String name) async {

  }

  static Future<Question> addQuestion(Question question) async {
    Dio dio = new Dio();
    FormData formdata = new FormData.fromMap(question.toJson());
    var response = await dio.post(GlobalConfig.url + "question/new/", data: formdata);
    Map resp = response.data;
    print(resp["msg"]);
    if (resp["code"] == "200") {
      return Question.fromJson(resp["entity"]);
    }
    return null;
  }

  static Future<bool> addQuestions(List<Question> questions) async {

    BaseOptions options = BaseOptions(
      contentType: "application/json;charset=UTF-8"
    );
    Dio dio = new Dio(options);
    print(json.encode(new List<dynamic>.from(questions.map((x) => x.toJson()))).toString());
//    var response = await dio.post(GlobalConfig.url + "question/newbatch/", data: [
//      json.encode(new List<dynamic>.from(questions.map((x) => x.toJson())))
//    ]);
//    var response = await dio.post(GlobalConfig.url + "question/newbatch/", data:
//      new List<dynamic>.from(questions.map((x) => x.toJson()))
//    );
        var response = await dio.post(GlobalConfig.url + "question/newbatch/", data:
            {
              "questions": new List<dynamic>.from(questions.map((x) => x.toJson()))
            });
    Map resp = response.data;
    print(resp["msg"]);
    if (resp["code"] == "200") {
      return true;
    }
    return false;
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