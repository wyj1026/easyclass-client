import 'package:easy_class/homework/homework_item.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/models/homework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeworkDetail extends StatefulWidget {
  HomeworkDetail({Key key, @required this.rec}) : super(key: key);

  final Homework rec;

  @override
  _HomeworkDetailState createState() {
    return new _HomeworkDetailState();
  }
}

class _HomeworkDetailState extends State<HomeworkDetail> {
  TextEditingController _commentController = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  FocusScopeNode focusScopeNode;

  bool _checkboxSelected = true; //维护单选开关状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: <Widget>[
                      HomeworkItem(widget.rec),
                      ExpansionTile(
                        title: new Text("查看全部题目"),
                        children: <Widget>[
                          Divider(),
                          new Text("1.题目A"),
                          Divider(),
                          new Text("2.题目B"),
                          Divider(),
                          new Text("3.题目C"),
                          new Container(
                            alignment: Alignment(-1.0, 1),
                            color: Colors.red,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text("4.题目D"),
                                new Container(
                                  alignment: Alignment(-1.0, 1),
                                  color: Colors.blue,
                                  child: Checkbox(
                                    value: _checkboxSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        _checkboxSelected = value;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
        bottomNavigationBar: RaisedButton(
          color: Colors.white,
          child: Text("去回答"),
          onPressed: () {},
        ));
  }
}
