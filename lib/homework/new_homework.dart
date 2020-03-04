import 'package:easy_class/models/homework.dart';
import 'package:easy_class/models/index.dart';
import 'package:easy_class/network/homework.dart';
import 'package:easy_class/network/question.dart';
import 'package:easy_class/question/new_nobj_question.dart';
import 'package:easy_class/question/new_obj_question.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class NewHomeworkWithTitle extends StatefulWidget {
  NewHomeworkWithTitle({Key key, @required this.homework})
      : assert(homework != null),
        super(key: key);

  Homework homework;

  @override
  _NewHomeworkWithTitleState createState() {
    return new _NewHomeworkWithTitleState(this.homework);
  }
}

TextStyle hintr = new TextStyle(color: Colors.red);
TextStyle hintb = new TextStyle(color: Colors.blue);
TextStyle title = new TextStyle(fontSize: 18);
TextStyle value = new TextStyle(fontSize: 16);


class _NewHomeworkWithTitleState extends State<NewHomeworkWithTitle>
    with TickerProviderStateMixin {
  FocusNode focusNode = new FocusNode();
  FocusScopeNode focusScopeNode;

  Homework homework;

  _NewHomeworkWithTitleState(this.homework);

  List<Question> questions = new List();

  List<Widget> get(Question question) {
    List<String> options = question.answer["options"];
    List<bool> content = question.answer["content"];
    return options
        .map((option) => new Container(
//            margin: const EdgeInsets.all(16.0),
            alignment: Alignment(-1.0, 1),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: content[options.indexOf(option)],
                  onChanged: (value) {},
                ),
                new Expanded(
                  child: Text(option, style: value,),
                ),
              ],
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加题目'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.check),
              onPressed: () async {
                homework.question_number = questions.length;
                homework.total_grade = 0;
                questions.map((Question q) {
                  homework.total_grade += q.grade == null ? 0 : q.grade;
                  return q;
                });
                Homework h = await HomeworkClient.addHomework(homework);
                questions = questions.map((Question q) {
                  homework.total_grade += q.grade == null ? 0 : q.grade;
                  q.classname = homework.classname;
                  q.class_id = homework.class_id;
                  q.homework_id = h.id;
                  return q;
                }).toList();

                QuestionClient.addQuestions(questions);
              })
        ],
      ),
      body: ConstrainedBox(
          constraints: BoxConstraints(minHeight: double.infinity),
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(minWidth: double.infinity),
                margin: const EdgeInsets.fromLTRB(0, 2, 0, 5),
                padding: const EdgeInsets.only(top: 0.0, bottom: 15.0),
                color: GlobalConfig.cardBackgroundColor,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: const EdgeInsets.fromLTRB(20, 15, 0, 5),
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "* ",
                          style: hintr,
                        ),
                        TextSpan(
                          text: "作业标题",
                          style: hintb,
                        ),
                      ])),
                    ),
                    new Container(
                      child: Text(
                        widget.homework.homework_title, style: title,
                      ),
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                    color: GlobalConfig.cardBackgroundColor,
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: const EdgeInsets.fromLTRB(20, 15, 0, 5),
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "* ",
                          style: hintr,
                        ),
                        TextSpan(
                          text: "题目列表",
                          style: hintb,
                        ),
                      ])),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 2, 0, 5),
                        padding: const EdgeInsets.only(top: 0.0, bottom: 15.0),
                        child: ListView(
                            shrinkWrap: true,
                            children: questions
                                .map((q) => new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ExpansionTile(
                                          title: new Text(
                                              (questions.indexOf(q) + 1)
                                                      .toString() +
                                                  ". " +
                                                  q.question, style: title,),
                                          children: <Widget>[
                                            new Container(
                                              child: Stack(
                                                children: <Widget>[
                                                  Offstage(
                                                    child: Column(
                                                      children: get(q),
                                                    ),
                                                    offstage: !q.is_objective,
                                                  ),
                                                  Offstage(
                                                    child: Container(
                                                      padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
                                                      alignment: Alignment(-1.0, 0),
                                                      child: Text(q.answer["options"][0], style: value,),
                                                    ),
                                                    offstage: q.is_objective,
                                                  )
                                                ],
                                              )
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                                .toList()))
                  ],
                )),
              ),
            ],
          )),
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
                      builder: (context) => index == 0
                          ? NewObjQuestionPage()
                          : NewNobjQuestionPage()),
                ) as Question;
                if (data != null) {
                  data.question_number = questions.length + 1;
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
