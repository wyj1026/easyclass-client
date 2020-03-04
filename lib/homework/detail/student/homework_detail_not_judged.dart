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

class HomeworkNotJudgedStudent extends StatefulWidget {
  HomeworkNotJudgedStudent({Key key, @required this.homework, @required this.questions, this.stat})
      : super(key: key);

  final Homework homework;
  final List<Question> questions;
  final int stat;

  @override
  _HomeworkNotJudgedStudentState createState() {
    return new _HomeworkNotJudgedStudentState(questions);
  }
}
TextStyle hintr = new TextStyle(color: Colors.red);
TextStyle hintb = new TextStyle(color: Colors.blue);
TextStyle title = new TextStyle(fontSize: 18);
TextStyle value = new TextStyle(fontSize: 16);

class _HomeworkNotJudgedStudentState extends State<HomeworkNotJudgedStudent> {
  List<TextEditingController> _controllers = new List();
  List<List<bool>> _check = new List();
  List<Question> _questions;

  _HomeworkNotJudgedStudentState(List<Question> questions) {
    print("Questions: "+ questions.length.toString());
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
          title: Text(''),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.check),
                onPressed: () async {
                  List<Answer> answers = _questions.map((q) {
                    Answer answer = new Answer();
                    answer.classname = widget.homework.classname;
                    answer.class_id = widget.homework.class_id;
                    answer.homework_id = widget.homework.id;
                    answer.user_id = GlobalConfig.user.id;
                    answer.username = GlobalConfig.user.name;
                    answer.homework_question_id = q.id;
                    answer.student_question_answer = new List();
                    int index = _questions.indexOf(q);
                    if (q.is_objective) {
                      answer.student_question_answer.addAll(_check[index]);
                    }
                    else {
                      answer.student_question_answer.add(_controllers[index].text);
                    }
                    answer.gmt_upload = DateTime.now().millisecondsSinceEpoch;
                    return answer;
                  }).toList();
                  AnswerClient.addAnswers(answers);
                  Navigator.of(context).pop();
                }
            ),
          ],
        ),
        body:
            ConstrainedBox(
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
        bottomNavigationBar: null
    );
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
            color: Colors.blue,
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _check[_questions.indexOf(question)][options.indexOf(option)],
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
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 15.0, right: 15),
                                alignment: Alignment(-1.0, 0),
                                child: Theme(
                                  data: new ThemeData(
                                      primaryColor: Colors.lightBlueAccent,
                                      hintColor: Colors.black),
                                  child: new TextField(
                                    decoration: InputDecoration(
                                        hintText: "请输入答案...",
                                        contentPadding:
                                        EdgeInsets.all(10.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        )),
                                    controller:
                                    _controllers[_questions.indexOf(q)],
                                    maxLines: 4,
                                  ),
                                ),
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
