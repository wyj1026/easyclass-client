import 'package:easy_class/clas/home.dart';
import 'package:easy_class/models/answer.dart';
import 'package:easy_class/models/homework.dart';
import 'package:easy_class/models/question.dart';
import 'package:easy_class/network/answer.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeworkJudged extends StatefulWidget {
  HomeworkJudged({Key key, @required this.homework, @required this.questions, this.stat})
      : super(key: key);

  final Homework homework;
  final List<Question> questions;
  final int stat;

  @override
  _HomeworkJudgedState createState() {
    return _HomeworkJudgedState(questions, homework);
  }
}

TextStyle hintr = new TextStyle(color: Colors.red);
TextStyle hintb = new TextStyle(color: Colors.blue);
TextStyle title = new TextStyle(fontSize: 18);
TextStyle value = new TextStyle(fontSize: 16);

class _HomeworkJudgedState extends State<HomeworkJudged> {
  List<Question> _questions = new List();
  Map<int, Answer> _questionAnswermap = new Map();
  int total = 0;

  _HomeworkJudgedState(List<Question> questions, Homework homework) {
    getData(questions, homework);
  }

  getData(List<Question> questions, Homework homework) async {
    Map<int, Answer> questionAnswermap = new Map();
    List<Answer> answers = await AnswerClient.getAnswersByHomeworkIdAndUserId(
        homework.id, GlobalConfig.user.id);
    for (int i = 0; i < questions.length; i++) {
      for (int j = 0; j < answers.length; j++) {
        total += answers[j].grade;
        if (answers[j].homework_question_id == questions[i].id) {
          questionAnswermap[questions[i].id] = answers[j];
          print(answers[j].toJson().toString());
        }
      }
    }

    setState(() {
      _questionAnswermap = questionAnswermap;
      _questions = questions;
      total = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          actions: <Widget>[
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
                            text: "总得分",
                            style: hintb,
                          ),
                        ])),
                      ),
                      new Container(
                        child: Text(
                          total.toString(),
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
    if (!question.is_objective) return <Widget>[];
    List<String> options = new List<String>.from(question.answer["options"]);
    List<bool> answer = new List<bool>.from(_questionAnswermap[question.id].student_question_answer);

    return options
        .map((option) => new Container(
//            margin: const EdgeInsets.all(16.0),
        alignment: Alignment(-1.0, 1),
        child: Row(
          children: <Widget>[
            Checkbox(
              value: answer[options.indexOf(option)],
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
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 15.0, right: 15),
                                alignment: Alignment(-1.0, 0),
                                child: Text("你的回答: " + _questionAnswermap[q.id].student_question_answer[0].toString()),
                              ),
                              offstage: q.is_objective,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 15.0, bottom: 15.0, right: 15),
                              child: Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: "* ",
                                  style: hintr,
                                ),
                                TextSpan(
                                  text: "得分: ",
                                  style: hintb,
                                ),
                                TextSpan(
                                  text: _questionAnswermap[q.id].grade.toString(),
                                  style: hintb,
                                ),
                              ])),),
                          ],
                        )),
                  ],
                ),
              ],
            ))
                .toList()));
  }

}
