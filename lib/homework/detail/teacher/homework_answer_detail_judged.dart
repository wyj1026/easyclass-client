import 'package:easy_class/models/answer.dart';
import 'package:easy_class/models/homework.dart';
import 'package:easy_class/models/question.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeworkAnswerDetailJudged extends StatefulWidget {
  HomeworkAnswerDetailJudged(
      {Key key,
      @required this.homework,
      @required this.questions,
      @required this.answers})
      : super(key: key);

  final Homework homework;
  final List<Question> questions;
  final List<Answer> answers;

  @override
  _HomeworkAnswerDetailJudgedState createState() {
    return new _HomeworkAnswerDetailJudgedState(questions, answers);
  }
}

TextStyle hintr = new TextStyle(color: Colors.red);
TextStyle hintb = new TextStyle(color: Colors.blue);
TextStyle title = new TextStyle(fontSize: 18);
TextStyle value = new TextStyle(fontSize: 16);

class _HomeworkAnswerDetailJudgedState
    extends State<HomeworkAnswerDetailJudged> {
  List<Question> _questions;
  Map<int, Answer> _questionAnswermap = new Map();

  _HomeworkAnswerDetailJudgedState(
      List<Question> questions, List<Answer> answers) {
    for (int i = 0; i < questions.length; i++) {
      for (int j = 0; j < answers.length; j++) {
        if (answers[j].homework_question_id == questions[i].id) {
          _questionAnswermap[questions[i].id] = answers[j];
        }
      }
    }
    _questions = questions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
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
    List<bool> content = new List<bool>.from(
        _questionAnswermap[question.id].student_question_answer);

    return options
        .map((option) => new Container(
//            margin: const EdgeInsets.all(16.0),
            alignment: Alignment(-1.0, 1),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: content[options.indexOf(option)],
                  onChanged: (value) {
                    setState(() {
                      content[options.indexOf(option)] = value;
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
