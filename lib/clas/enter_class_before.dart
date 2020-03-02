import 'dart:io';

import 'package:easy_class/models/class.dart';
import 'package:easy_class/network/class.dart';
import 'package:easy_class/network/file.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'enter_class.dart';

class EnterClassBefore extends StatefulWidget {
  @override
  State createState() {
    return new EnterClassBeforeState();
  }
}

class EnterClassBeforeState extends State<EnterClassBefore> {
  TextEditingController _name = new TextEditingController();
  TextStyle titleStyle = new TextStyle(fontSize: 20);
  TextStyle valueStyle = new TextStyle(fontSize: 15);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('加入课程'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                Class cas = await ClassClient.getById(_name.text);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => new EnterClass(rec: cas,)
                ));
              }),
        ],
      ),
      body: new Container(
        color: GlobalConfig.cardBackgroundColor,
        margin: const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 5, right: 5),
        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
        child: new TextField(
          keyboardType: TextInputType.number,
          autofocus: true,
          controller: _name,
          decoration: new InputDecoration(hintText: '课程序号'),
        ),
      ),
    );
  }
}
