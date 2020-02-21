import 'package:easy_class/homework/homework_item.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/question/new_nobj_question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class NewHomework extends StatefulWidget {
  NewHomework({Key key, @required this.rec}) : super(key: key);

  final Class rec;

  @override
  _NewHomeworkState createState() {
    return new _NewHomeworkState();
  }
}

class _NewHomeworkState extends State<NewHomework> with TickerProviderStateMixin {
  TextEditingController _commentController = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  FocusScopeNode focusScopeNode;

  bool _checkboxSelected = true; //维护单选开关状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('新建作业'),
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
        bottomNavigationBar: null,
        floatingActionButton: buildFloatingButton(),
    );
  }

  AnimationController _controller;

  static const List<String> qs = const [ "客观", "主观"];

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget buildFloatingButton() {
    return new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(qs.length, (int index) {
          Widget child = new Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: new ScaleTransition(
              scale: new CurvedAnimation(
                parent: _controller,
                curve: new Interval(
                    0.0,
                    1.0 - index / qs.length / 2.0,
                    curve: Curves.easeOut
                ),
              ),
              child: new FloatingActionButton(
                heroTag: null,
                mini: true,
//                child: new Icon(icons[index], color: foregroundColor),
                child: new Text(qs[index]),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => new NewNobjQuestionPage(),
                      ));
                },
              ),
            ),
          );
          return child;
        }).toList()..add(
          new FloatingActionButton(
            heroTag: null,
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform: new Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: new Icon(_controller.isDismissed ? Icons.add : Icons.close),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
      );
  }
}
