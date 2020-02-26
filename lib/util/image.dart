import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:async';

class SingleImageView extends StatefulWidget {

  @override
  _SingleImageViewState createState() => _SingleImageViewState(this.url);

  String url;

  SingleImageView(this.url);
}

class _SingleImageViewState extends State<SingleImageView> {
  String url;
  bool change = false;

  _SingleImageViewState(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("查看头像"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () async  {
                getImage();
//                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.add_a_photo,
                color: Colors.black,
              ),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            )
          ],
        ),
        body: Container(
            child: PhotoView(
              imageProvider: change? FileImage(_image): NetworkImage(url),
            )
        ),
        bottomNavigationBar: null
    );
  }

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      change = true;
    });
  }
}