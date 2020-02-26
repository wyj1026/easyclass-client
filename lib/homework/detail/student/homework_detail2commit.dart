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

class HomeworkDetail2Commit extends StatefulWidget {
  HomeworkDetail2Commit({Key key, @required this.homework, @required this.questions, this.stat})
      : super(key: key);

  final Homework homework;
  final List<Question> questions;
  final int stat;

  @override
  _HomeworkDetail2CommitState createState() {
    return new _HomeworkDetail2CommitState(questions);
  }
}

class _HomeworkDetail2CommitState extends State<HomeworkDetail2Commit> {
  List<TextEditingController> _controllers = new List();
  List<List<bool>> _check = new List();
  List<Question> _questions;

  _HomeworkDetail2CommitState(List<Question> questions) {
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
                    HomeworkItem(widget.homework),
                    Container(
                      color: Colors.amber,
                      child: new Text(widget.homework.homework_title),
                      margin: const EdgeInsets.all(16.0),
                    ),
                    Flexible(
                        child: ListView(
                            children: _questions
                                .map((q) => new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ExpansionTile(
                                          title: new Text(
                                              (_questions.indexOf(q) + 1)
                                                      .toString() +
                                                  ". " +
                                                  q.question),
                                          children: <Widget>[
                                            new Container(
//                            alignment: Alignment(-1, 1),
                                              child: new Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Offstage(
                                                    child: new TextField(
                                                      controller: _controllers[_questions.indexOf(q)],
                                                      maxLines: 3,
                                                      autofocus: false,
                                                      decoration: new InputDecoration(
                                                          hintText: "请输入答案...", hintStyle: new TextStyle()),
                                                    ),
                                                    offstage: q.is_objective,
                                                  ),
                                                  Offstage(
                                                    child: Column(
                                                      children: get(q),
                                                    ),
                                                    offstage: !q.is_objective,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                                .toList())),
                  ],
                )),
        bottomNavigationBar: RaisedButton(
          color: Colors.white,
          child: Text("去回答"),
          onPressed: () {},
        ));
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
                      _check[_questions.indexOf(question)][options.indexOf(option)] = value;
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

}
