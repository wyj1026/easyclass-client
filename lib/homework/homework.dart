import 'package:easy_class/util/config.dart';
import 'package:flutter/material.dart';

class Homework extends StatefulWidget {

  @override
  _HomeworkeState createState() => new _HomeworkeState();

}

class _HomeworkeState extends State<Homework> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('作业'),
          ),
          body: new Center(
              child: null
          ),
        ),
        theme: GlobalConfig.themeData
    );
  }

}