import 'package:easy_class/homework/detail/teacher/answer_item.dart';
import 'package:easy_class/models/homework.dart';
import 'package:easy_class/models/index.dart';
import 'package:easy_class/models/question.dart';
import 'package:easy_class/network/answer.dart';
import 'package:easy_class/network/question.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homework_answer_detail2judge.dart';

class HomeworkDetail2Judge extends StatefulWidget {
  HomeworkDetail2Judge(
      {Key key, @required this.homework, @required this.questions, this.stat})
      : super(key: key);

  final Homework homework;
  final List<Question> questions;
  final int stat;

  @override
  _HomeworkDetail2JudgeState createState() {
    return new _HomeworkDetail2JudgeState(questions);
  }
}

class _HomeworkDetail2JudgeState extends State<HomeworkDetail2Judge> {
  _HomeworkDetail2JudgeState(List<Question> questions) {
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('全部提交'),
        actions: <Widget>[
        ],
      ),
      body: new InfiniteListView<User>(
        onRetrieveData: (int page, List<User> items, bool refresh) async {
          items.addAll(
              await AnswerClient.getUsersByHomeworkId(widget.homework.id, 1));
          return false;
        },
        itemBuilder: (List<User> list, int index, BuildContext ctx) {
          return GestureDetector(
              child: AnswerItem(list[index]),
              onTap: () async {
                var as = await AnswerClient.getAnswersByHomeworkIdAndUserId(
                    widget.homework.id, list[index].id);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      HomeworkAnswerDetail2Judge(homework: widget.homework,
                        questions: widget.questions,
                        answers: as,),
                ));
              }
          );
        },
      )
    );
  }
}
