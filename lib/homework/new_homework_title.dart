import 'package:easy_class/clas/home.dart';
import 'package:easy_class/homework/homework_item.dart';
import 'package:easy_class/homework/new_homework.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/models/homework.dart';
import 'package:easy_class/question/new_nobj_question.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:intl/intl.dart';

class NewHomeworkTitle extends StatefulWidget {
  NewHomeworkTitle({Key key, @required this.id, @required this.classname})
      : super(key: key);

  final int id;
  final String classname;

  @override
  _NewHomeworkTitleState createState() {
    return new _NewHomeworkTitleState();
  }
}

class _NewHomeworkTitleState extends State<NewHomeworkTitle>
    with TickerProviderStateMixin {
  TextEditingController _title = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  FocusScopeNode focusScopeNode;

  bool _checkboxSelected = true; //维护单选开关状态

  TextEditingController _start = new TextEditingController();
  TextEditingController _end = new TextEditingController();
  TextStyle titleStyle = new TextStyle(fontSize: 19);
  TextStyle valueStyle = new TextStyle(fontSize: 15);
  DateTime startDate;
  DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新建作业'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.check),
              onPressed: () {
                Homework homework = new Homework();
                homework.homework_title = _title.text;
                homework.class_id = widget.id;
                homework.classname = widget.classname;
                homework.gmt_create = DateTime.now().millisecondsSinceEpoch;
                homework.gmt_start_upload = startDate.millisecondsSinceEpoch;
                homework.gmt_stop_upload = endDate.millisecondsSinceEpoch;

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        new NewHomeworkWithTitle(homework: homework)));
              })
        ],
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Container(
          color: GlobalConfig.cardBackgroundColor,
          child:
            SingleChildScrollView(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: double.infinity),
                      child: Container(
                          margin: const EdgeInsets.all(16.0),
                        child: Theme(
                          data: new ThemeData(primaryColor: Colors.lightBlueAccent, hintColor: Colors.black),
                          child: new TextField(
                          decoration: InputDecoration(
                              hintText: "请输入作业标题...",
                              contentPadding: EdgeInsets.all(10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
//            borderSide: BorderSide(color: Colors.red, width: 3.0, style: BorderStyle.solid)//没什么卵效果
                              )),
                          controller: _title,
                          maxLines: 4,
                          autofocus: true,
                          ),
                        )
                      ),
                    ),
                    Divider(thickness: 1.0,),
                    ListTile(
                      leading: new Container(
                          margin: const EdgeInsets.only(bottom: 6.0),
                          child: new Text(
                            "开始上传时间",
                            style: titleStyle,
                          )),
                      trailing: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            _start.text,
                            style: valueStyle,
                          ),
                          IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: () async {
                                await _showDatePicker1();
                                DateFormat format =
                                    new DateFormat("yyyy-MM-dd hh:mm");
                                _start.text =
                                    format.format(startDate).toString();
                                setState(() {});
                              }),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                    ),
                    ListTile(
                      leading: new Container(
                          margin: const EdgeInsets.only(bottom: 6.0),
                          child: new Text(
                            "结束上传时间",
                            style: titleStyle,
                          )),
                      trailing: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            _end.text,
                            style: valueStyle,
                          ),
                          IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: () async {
                                await _showDatePicker2();
                                DateFormat format =
                                    new DateFormat("yyyy-MM-dd hh:mm");
                                _end.text = format.format(endDate).toString();
                                setState(() {});
                              }),
                        ],
                      ),
                    ),
                    Divider(thickness: 1.0,),
                  ],
                )),
        ),
      ),
      bottomNavigationBar: null,
      floatingActionButton: null,
    );
  }

  Future<DateTime> _showDatePicker1() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(
              Duration(days: 30),
            ),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              startDate = value;
            },
          ),
        );
      },
    );
  }

  Future<DateTime> _showDatePicker2() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(
              Duration(days: 30),
            ),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              endDate = value;
            },
          ),
        );
      },
    );
  }
}
