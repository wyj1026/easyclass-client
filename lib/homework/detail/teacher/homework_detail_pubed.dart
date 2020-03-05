import 'package:easy_class/homework/homework_item.dart';
import 'package:easy_class/models/answer.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/models/homework.dart';
import 'package:easy_class/models/question.dart';
import 'package:easy_class/network/answer.dart';
import 'package:easy_class/network/question.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeworkDetailPubed extends StatefulWidget {
  HomeworkDetailPubed(
      {Key key, @required this.homework, @required this.questions, this.stat})
      : super(key: key);

  final Homework homework;
  final List<Question> questions;
  final int stat;

  @override
  _HomeworkDetailPubedState createState() {
    return new _HomeworkDetailPubedState(questions);
  }
}

TextStyle hintr = new TextStyle(color: Colors.red);
TextStyle hintb = new TextStyle(color: Colors.blue);
TextStyle title = new TextStyle(fontSize: 18);
TextStyle value = new TextStyle(fontSize: 16);

class _HomeworkDetailPubedState extends State<HomeworkDetailPubed> {
  List<TextEditingController> _controllers = new List();
  List<List<bool>> _check = new List();
  List<Question> _questions;

  _HomeworkDetailPubedState(List<Question> questions) {
    print("Questions: " + questions.length.toString());
    for (int i = 0; i < questions.length; i++) {
      _controllers.add(new TextEditingController());
      _check.add(new List());
    }
    _questions = questions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('作业'),
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
                          widget.homework.homework_title,
                          style: title,
                        ),
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      color: GlobalConfig.cardBackgroundColor,
                      child: SingleChildScrollView(
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
                          getQuestions(),
                        ],
                      ))),
                ),
              ],
            )),
        bottomNavigationBar: null);
  }

  List<Widget> get(Question question) {
    List<String> options = new List<String>.from(question.answer["options"]);
    List<bool> content = new List<bool>.from(question.answer["content"]);
    int index = _questions.indexOf(question);
    _check[index].addAll(content);

    return options
        .map((option) => new Container(
//            margin: const EdgeInsets.all(16.0),
            alignment: Alignment(-1.0, 1),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _check[_questions.indexOf(question)]
                      [options.indexOf(option)],
                  onChanged: (value) {
                    setState(() {
                    });
                  },
                ),
                new Expanded(
                  child: Text(option),
                ),
              ],
            )))
        .toList();
  }

  getQuestions() {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 2, 0, 5),
        padding: const EdgeInsets.only(top: 0.0, bottom: 15.0),
        child: ListView(
            shrinkWrap: true,
            children: _questions
                .map((q) => new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ExpansionTile(
                          title: new Text(
                            (_questions.indexOf(q) + 1).toString() +
                                ". " +
                                q.question,
                            style: title,
                          ),
                          children: <Widget>[
                            new Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Offstage(
                                  child: Column(
                                    children: get(q),
                                  ),
                                  offstage: !q.is_objective,
                                ),
                                Offstage(
                                  child: Container(
                                    constraints:  BoxConstraints(minWidth: double.infinity),
                                    padding: EdgeInsets.only(
                                        left: 15,
                                        top: 10,
                                        bottom: 10,
                                        right: 10),
//                                color: Colors.red,
                                    child:
                                        Text("参考答案: " + q.answer["options"][0]),
                                  ),
                                  offstage: q.is_objective,
                                )
                              ],
                            )),
                          ],
                        ),
                      ],
                    ))
                .toList()));
  }
}
