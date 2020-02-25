import 'package:easy_class/homework/homework_item.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/models/homework.dart';
import 'package:easy_class/models/question.dart';
import 'package:easy_class/network/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeworkDetail extends StatefulWidget {
  HomeworkDetail({Key key, @required this.homework, @required this.questions})
      : super(key: key);

  final Homework homework;
  final List<Question> questions;

  @override
  _HomeworkDetailState createState() {
    return new _HomeworkDetailState();
  }
}

class _HomeworkDetailState extends State<HomeworkDetail> {
  TextEditingController _commentController = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
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
                            children: widget.questions
                                .map((q) => new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ExpansionTile(
                                          title: new Text(
                                              (widget.questions.indexOf(q) + 1)
                                                      .toString() +
                                                  ". " +
                                                  q.question),
                                          children: <Widget>[
                                            new Container(
//                            alignment: Alignment(-1, 1),
                                              color: Colors.red,
                                              child: new Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
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
    print(question.answer);
    print(question.answer["options"]);
    List<String> options = new List<String>.from(question.answer["options"]);
    List<bool> content = new List<bool>.from(question.answer["content"]);

    return options
        .map((option) => new Container(
//            margin: const EdgeInsets.all(16.0),
            alignment: Alignment(-1.0, 1),
            color: Colors.blue,
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: content[options.indexOf(option)],
                  onChanged: (value) {},
                ),
                new Expanded(
                  child: Text(option),
                ),
              ],
            )))
        .toList();
  }
}
