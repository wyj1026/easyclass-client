import 'package:easy_class/homework/homework_detail.dart';
import 'package:easy_class/homework/homework_item.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/models/index.dart';
import 'package:easy_class/network/homework.dart';
import 'package:easy_class/network/question.dart';
import 'package:easy_class/util/config.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class HomeworkPage extends StatefulWidget {

  HomeworkPage(this.stat) :super();

  final int stat;

  @override
  _HomeworkeState createState() => new _HomeworkeState(this.stat);

}

class _HomeworkeState extends State<HomeworkPage> {
  final int stat;

  _HomeworkeState(this.stat) : super();

  @override
  Widget build(BuildContext context) {
    return new InfiniteListView<Homework>(
      onRetrieveData: (int page, List<Homework> items, bool refresh) async {
        items.addAll(await HomeworkClient.getHomework(stat));
        return false;
      },
      itemBuilder: (List<Homework> list, int index, BuildContext ctx) {
        return GestureDetector(
          child: HomeworkItem(list[index]),
          onTap: ()  async {
            var qs = await QuestionClient.getQuestionsByHomeworkId(list[index].id);
            print(qs.toString());
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => new HomeworkDetail(
                homework: list[index], questions: qs),
              ));
          }
        );
      },
    );
  }
}