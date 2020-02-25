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
}