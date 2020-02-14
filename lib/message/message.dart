import 'package:easy_class/util/config.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {

  @override
  _MessageState createState() => new _MessageState();

}

class _MessageState extends State<Message> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('消息'),
          ),
          body: new Center(
              child: null
          ),
        ),
        theme: GlobalConfig.themeData
    );
  }

}