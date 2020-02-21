import 'package:easy_class/homework/homework_item.dart';
import 'package:easy_class/homework/new_homework.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/question/new_nobj_question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class NewHomeworkTitle extends StatefulWidget {
  @override
  _NewHomeworkTitleState createState() {
    return new _NewHomeworkTitleState();
  }
}

class _NewHomeworkTitleState extends State<NewHomeworkTitle> with TickerProviderStateMixin {
  TextEditingController _title = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  FocusScopeNode focusScopeNode;

  bool _checkboxSelected = true; //维护单选开关状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('新建作业'),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.check), onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => new NewHomeworkWithTitle(title: _title.text))
              );
            })
          ],
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: double.infinity),
                        child: Container(
                          child: new TextField(
                            controller: _title,
                            maxLines: 3,
                            autofocus: true,
                            decoration: new InputDecoration(
                                hintText: "请输入题目...", hintStyle: new TextStyle()),
                          ),
                          margin: const EdgeInsets.all(16.0),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        bottomNavigationBar: null,
        floatingActionButton: null,
    );
  }
}
