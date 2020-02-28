import 'dart:io';

import 'package:easy_class/network/file.dart';
import 'package:easy_class/network/login.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';

class CropImageRoute extends StatefulWidget {
  CropImageRoute(this.image);

  File image; //原始图片路径

  @override
  _CropImageRouteState createState() => new _CropImageRouteState();
}

class _CropImageRouteState extends State<CropImageRoute> {
  double baseLeft; //图片左上角的x坐标
  double baseTop; //图片左上角的y坐标
  double imageWidth; //图片宽度，缩放后会变化
  double imageScale = 1; //图片缩放比例
  Image imageView;
  final cropKey = GlobalKey<CropState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("修改"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () async  {
                _crop(widget.image);
              },
              child: Icon(
                Icons.check,
                color: Colors.black,
              ),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
//          height: Screen.height,
//          width: Screen.width,
          child: Column(
            children: <Widget>[
              Flexible(
                child: Crop.file(
                  widget.image,
                  key: cropKey,
//                  scale: 0.5,
                  aspectRatio: 1,
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _crop(File originalFile) async {
    final crop = cropKey.currentState;
    final area = crop.area;
    if (area == null) {
      //裁剪结果为空
      print('裁剪不成功');
    }
    await ImageCrop.requestPermissions().then((value) {
      if (value) {
        ImageCrop.cropImage(
          file: originalFile,
          area: crop.area,
        ).then((value) {
          print("成功");
          FileClient.send(value).then((value) {
            GlobalConfig.user.avatar_url = value;
            LoginClient.update();
          });
          Navigator.of(context).pop(value);
        });
      };
    });
  }
}