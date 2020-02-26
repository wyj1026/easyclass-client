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
  static Future<Question> addQuestion(Question question) async {
    Dio dio = new Dio();
    FormData formdata = new FormData.fromMap(question.toJson());
    var response = await dio.post(GlobalConfig.url + "question/new/", data: formdata);
    Map resp = response.data;
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
        var response = await dio.post(GlobalConfig.url + "question/newbatch/", data:
            {
              "questions": new List<dynamic>.from(questions.map((x) => x.toJson()))
            });
    Map resp = response.data;
    if (resp["code"] == "200") {
      return true;
    }
    return false;
  }

  static Future<bool> judgeQuestions(List<Question> questions) async {
    BaseOptions options = BaseOptions(
        contentType: "application/json;charset=UTF-8"
    );
    Dio dio = new Dio(options);
    print(json.encode(new List<dynamic>.from(questions.map((x) => x.toJson()))).toString());
    var response = await dio.post(GlobalConfig.url + "question/judgeBatch/", data:
    {
      "questions": new List<dynamic>.from(questions.map((x) => x.toJson()))
    });
    Map resp = response.data;
    if (resp["code"] == "200") {
      return true;
    }
    return false;
  }

  static Future<List<Question>> getQuestionsByHomeworkId(int id) async {
    prefix0.Utf8Decoder utf8decoder = new Utf8Decoder();
    var client = http.Client();
    http.Response response = await client.get(GlobalConfig.url + "question/getBatchByHomeworkId/?id=" + id.toString());
    print(utf8decoder.convert(response.bodyBytes));
    Iterable l = json.decode(utf8decoder.convert(response.bodyBytes))["entity"];
    List<Question> recs = l.map((model) => Question.fromJson(model)).toList();
    return recs;
  }
}