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

class AnswerClient {
  static Future<bool> addAnswers(List<Answer> questions) async {

    BaseOptions options = BaseOptions(
      contentType: "application/json;charset=UTF-8"
    );
    Dio dio = new Dio(options);
    print(json.encode(new List<dynamic>.from(questions.map((x) => x.toJson()))).toString());
        var response = await dio.post(GlobalConfig.url + "answer/newbatch/", data:
            {
              "answers": new List<dynamic>.from(questions.map((x) => x.toJson()))
            });
    Map resp = response.data;
    if (resp["code"] == "200") {
      return true;
    }
    return false;
  }

  static Future<List<Answer>> getAnswersByHomeworkIdAndUserId(int homeworkId, int userId) async {
    prefix0.Utf8Decoder utf8decoder = new Utf8Decoder();
    var client = http.Client();
    http.Response response = await client.get(GlobalConfig.url +
        "answer/getAnswersByHomeworkIdAndUserId/?homeworkId=" + homeworkId.toString() +
        "&userId=" + userId.toString()
    );
    print(json.decode(utf8decoder.convert(response.bodyBytes)));
    Iterable l = json.decode(utf8decoder.convert(response.bodyBytes))["entity"];
    List<Answer> recs = l.map((model) => Answer.fromJson(model)).toList();
    return recs;
  }

  static Future<List<User>> getUsersByHomeworkId(int id, int judge) async {
    prefix0.Utf8Decoder utf8decoder = new Utf8Decoder();
    var client = http.Client();
    http.Response response = await client.get(GlobalConfig.url +
        "answer/getUsersByHomeworkId/?id=" + id.toString() + "" + "&judged=" + judge.toString()
    );
    Iterable l = json.decode(utf8decoder.convert(response.bodyBytes))["entity"];
    List<User> recs = l.map((model) => User.fromJson(model)).toList();
    return recs;
  }


  static Future<bool> judgeBatch(List<Answer> answers) async {
    BaseOptions options = BaseOptions(
        contentType: "application/json;charset=UTF-8"
    );
    Dio dio = new Dio(options);
    var response = await dio.post(GlobalConfig.url + "answer/judgeBatch/", data:
    {
      "answers": new List<dynamic>.from(answers.map((x) => x.toJson()))
    });
    Map resp = response.data;
    if (resp["code"] == "200") {
      return true;
    }
    return false;
  }

}