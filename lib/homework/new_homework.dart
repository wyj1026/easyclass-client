import 'package:easy_class/homework/homework_item.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/models/homework.dart';
import 'package:easy_class/models/index.dart';
import 'package:easy_class/question/new_nobj_question.dart';
import 'package:easy_class/question/new_obj_question.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class NewHomeworkWithTitle extends StatefulWidget {
  NewHomeworkWithTitle({Key key, @required this.title})
      : assert(title != null),
        super(key: key);

  String title;

  @override
  _NewHomeworkWithTitleState createState() {
    return new _NewHomeworkWithTitleState(this.title);
  }
}

class _NewHomeworkWithTitleState extends State<NewHomeworkWithTitle>
    with TickerProviderStateMixin {
  TextEditingController _title = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  FocusScopeNode focusScopeNode;

  String title;

  _NewHomeworkWithTitleState(this.title);
  List<Question> questions = new List();


  List<Widget> get(Question question) {
    List<String> options = question.answer["options"];
    List<bool> content = question.answer["content"];
    return options.map((option) =>
        new Container(
//            margin: const EdgeInsets.all(16.0),
            alignment: Alignment(-1.0, 1),
                color: Colors.blue,
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: content[options.indexOf(option)],
                  onChanged: (value) {
                  },
                ),

                new Expanded(
                  child: Text(option),
                ),

              ],
            ))
    ).toList();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加题目'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.check),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => new NewHomeworkWithTitle()));
              })
        ],
      ),
      body: ConstrainedBox(
          constraints: BoxConstraints(minHeight: double.infinity),
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.amber,
                child: new Text(title),
                margin: const EdgeInsets.all(16.0),
              ),
              Flexible(
                  child: ListView(
                      children: questions
                          .map((q) => new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ExpansionTile(
                                    title: new Text((questions.indexOf(q) + 1).toString() + ". " +  q.question),
                                    children: <Widget>[
                                      new Container(
//                            alignment: Alignment(-1, 1),
                                        color: Colors.red,
                                        child: new Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Offstage(
                                              child: Column(
                                                children: get(q),
                                              ),
//                                              child: new Container(
//                                                alignment: Alignment(-1.0, 1),
//                                                color: Colors.blue,
//                                                child: Checkbox(
//                                                  value: _checkboxSelected,
//                                                  onChanged: (value) {
//                                                    setState(() {
//                                                      _checkboxSelected = value;
//                                                    });
//                                                  },
//                                                ),
//                                              ),
                                              offstage: !q.is_objective,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                          .toList())

//            InfiniteListView<Question>(
//              onRetrieveData: (int page, List<Question> items, bool refresh) async {
//                print("FETCH DATA");
//                var data = new Question();
//                data.id = 1;
//                data.class_id = 1;
//                data.classname = "数据";
//                data.question = ".如果阿客户的反馈";
//                data.gmt_create = 1579610044222;
////                items.add(data);
//                if (items.length >= questions.length) {
//                  return false;
//                }
//                else {
//                  items.addAll(questions.sublist(items.length, questions.length));
//                  return false;
//                }
//              },
//              itemBuilder: (List<Question> list, int index, BuildContext ctx) {
//                return ExpansionTile(
//                  title: new Text(index.toString() + list[index].question),
//                );
//              },
//            ),
                  ),
            ],
          )),

//      ConstrainedBox(
//        constraints: BoxConstraints.expand(),
//        child: Stack(
//          children: <Widget>[
//            SingleChildScrollView(
//                padding: const EdgeInsets.only(top: 8.0),
//                child: Column(
//                  children: <Widget>[
//                      Padding(
//                        padding: EdgeInsets.all(16.0),
//                        child: SizedBox(
//                          height: 200,
//                          child: Expanded(
//                            child: Container(
//                              color: Colors.red,
//                              child: Text("123"),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ConstrainedBox(
//                      constraints: BoxConstraints(minWidth: double.infinity),
//                      child: Container(
////                          color: Colors.amber,
//                        child: new Text(title),
//                        margin: const EdgeInsets.all(16.0),
//                      ),
//                    ),
//                    Column(
//                      mainAxisSize: MainAxisSize.max,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Container(
//                          color: Colors.red,
//                          child: Text("123"),
//                        ),
//                      ],
//                    ),
//                    Container(
//                      margin: EdgeInsets.all(10.0),
//                      color: Colors.blue,
//                      child: Text("123"),
//                    ),
//                    ExpansionTile(
//                      title: new Text("查看全部题目"),
//                      children: <Widget>[
//                        Divider(),
//                        new Text("1.题目A"),
//                        Divider(),
//                        new Text("2.题目B"),
//                        Divider(),
//                        new Text("3.题目C"),
//                        new Container(
////                            alignment: Alignment(-1, 1),
//                          color: Colors.red,
//                          child: new Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              new Text("4.题目D"),
//                              new Container(
//                                alignment: Alignment(0.0, 1),
//                                color: Colors.blue,
//                                child: Checkbox(
//                                  value: _checkboxSelected,
//                                  onChanged: (value) {
//                                    setState(() {
//                                      _checkboxSelected = value;
//                                    });
//                                  },
//                                ),
//                              )
//                            ],
//                          ),
//                        )
//                      ],
//                    )
//                  ],
//                )),
//          ],
//        ),
//      ),
      bottomNavigationBar: null,
      floatingActionButton: buildFloatingButton(),
    );
  }

  AnimationController _controller;

  static const List<String> qs = const ["客观", "主观"];

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
              curve: new Interval(0.0, 1.0 - index / qs.length / 2.0,
                  curve: Curves.easeOut),
            ),
            child: new FloatingActionButton(
              heroTag: null,
              mini: true,
//                child: new Icon(icons[index], color: foregroundColor),
              child: new Text(qs[index]),
              onPressed: () async {
                final data = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => index == 0? NewObjQuestionPage(): NewNobjQuestionPage()),
                ) as Question;
                if (data != null) {
                  setState(() {
                    questions = List.from(questions)..add(data);
                  });
                }
//                Navigator.of(context).push(MaterialPageRoute(
//                  builder: (context) => new NewNobjQuestionPage(),));
              },
            ),
          ),
        );
        return child;
      }).toList()
        ..add(
          new FloatingActionButton(
            heroTag: null,
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform:
                      new Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: new Icon(
                      _controller.isDismissed ? Icons.add : Icons.close),
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
