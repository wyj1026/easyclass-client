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

class HomeworkAnswerDetail2Judge extends StatefulWidget {
  HomeworkAnswerDetail2Judge({Key key, @required this.homework, @required this.questions, @required this.answers})
      : super(key: key);

  final Homework homework;
  final List<Question> questions;
  final List<Answer> answers;

  @override
  _HomeworkAnswerDetail2JudgeState createState() {
    return new _HomeworkAnswerDetail2JudgeState(questions, answers);
  }
}

class _HomeworkAnswerDetail2JudgeState extends State<HomeworkAnswerDetail2Judge> {
  Map<int, TextEditingController>  _controllersMap = new Map();
  List<Question> _questions;
  Map<int, Answer> _questionAnswermap = new Map();

  _HomeworkAnswerDetail2JudgeState(List<Question> questions, List<Answer> answers) {
    for (int i = 0; i < questions.length; i++) {
      for (int j = 0; j < answers.length; j++) {
        if (answers[j].homework_question_id == questions[i].id) {
          _questionAnswermap[questions[i].id] = answers[j];
          _controllersMap[questions[i].id] = new TextEditingController();
        }
      }
    }
    _questions = questions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.answers.length.toString()),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.check),
                onPressed: () async {
                  for (int i = 0; i < widget.answers.length; i++) {
                    widget.answers[i].grade = int.parse(_controllersMap[widget.answers[i].homework_question_id].text);
                  }
                  AnswerClient.judgeBatch(widget.answers);
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
                                                  !q.is_objective?
                                                  Offstage(
                                                    child: new Text(_questionAnswermap[q.id].student_question_answer[0]),
                                                    offstage: q.is_objective,
                                                  ):
                                                  Offstage(
                                                    child: Column(
                                                      children: get(q),
                                                    ),
                                                    offstage: !q.is_objective,
                                                  ),
                                                  Divider(),
                                                  ListTile(
                                                    leading: new Container(
                                                        margin: const EdgeInsets.only(bottom: 6.0),
                                                        child: new Text("分值",)
                                                    ),
                                                    trailing: new Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        new Text(_controllersMap[q.id].text),
                                                        IconButton(
                                                            icon: Icon(Icons.arrow_forward_ios),
                                                            onPressed: () async {
                                                              await _showDialog(_controllersMap[q.id], TextInputType.number);
                                                            }
                                                        ),
                                                      ],
                                                    ),
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


  _showDialog(TextEditingController controller, TextInputType kbt) async {
    await showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new _SystemPadding(
          child: new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    keyboardType: kbt,
                    autofocus: true,
                    controller: controller,
//                    decoration: new InputDecoration(
//                        labelText: 'Full Name', hintText: 'eg. John Smith'),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('取消'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              new FlatButton(
                  child: const Text('确定'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),);
      },
    );
  }

  List<Widget> get(Question question) {
    List<String> options = new List<String>.from(question.answer["options"]);
    List<bool> content = new List<bool>.from(_questionAnswermap[question.id].student_question_answer);

    return options
        .map((option) => new Container(
//            margin: const EdgeInsets.all(16.0),
            alignment: Alignment(-1.0, 1),
            color: Colors.blue,
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

}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}