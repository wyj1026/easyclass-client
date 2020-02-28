
import 'dart:io';
import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:easy_class/util/config.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class FileClient {
  static var uuid = new Uuid();


  static Future<String> send(File file) async {
    String filename = uuid.v1() + ".jpeg";
    Uri uri = Uri.parse(GlobalConfig.url + "file/upload");
    http.MultipartRequest request = http.MultipartRequest("POST", uri);
    http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
    'file',
    await file.readAsBytes(),
    filename: filename,
    contentType: new MediaType("image", "jpeg"),
    );

// add file to multipart
    request.files.add(multipartFile);
    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!"); else print("Failed!");
    });
    return GlobalConfig.url + "file/download/" + filename;
  }
}
