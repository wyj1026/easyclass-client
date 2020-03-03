import 'package:easy_class/homework/homework_detail.dart';
import 'package:easy_class/message/message_item.dart';
import 'package:easy_class/models/homework.dart';
import 'package:easy_class/network/homework.dart';
import 'package:easy_class/network/question.dart';
import 'package:easy_class/util/config.dart';
import 'package:easy_class/util/storage.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Message extends StatefulWidget {

  @override
  _MessageState createState() => new _MessageState();

}

class _MessageState extends State<Message> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('消息'),
          ),
          body: InfiniteListView<Homework>(
            onRetrieveData: (int page, List<Homework> items, bool refresh) async {
              bool stuMode = Provider.of<UserMode>(context, listen: false).get()? true: false;
              if (stuMode) {
                int lastLogin = await Storage.get_timestamp();
                int near = DateTime
                    .now()
                    .millisecondsSinceEpoch + GlobalConfig.near;
                List<Homework> newHomeworks = await HomeworkClient
                    .getHomeworkAfterDate(lastLogin);
                List<Homework> nearHomeworks = await HomeworkClient
                    .getHomeworkNearDate(near);
                newHomeworks = newHomeworks.map((f) {f.tag=1; return f;}).toList();
                nearHomeworks = nearHomeworks.map((f) {f.tag=2; return f;}).toList();
                items.addAll(nearHomeworks);
                items.addAll(newHomeworks);
                items.sort((a, b) =>
                    a.gmt_stop_upload.compareTo(b.gmt_stop_upload));
              }
              else {
                List<Homework> stopped = await HomeworkClient
                    .getHomeworkStoppedUpload(DateTime.now().millisecondsSinceEpoch);
                stopped = stopped.map((f) {f.tag=3; return f;}).toList();
                items.addAll(stopped);
                items.sort((a, b) =>
                    a.gmt_stop_upload.compareTo(b.gmt_stop_upload));
              }
              return false;
            },
            itemBuilder: (List<Homework> list, int index, BuildContext ctx) {
              return GestureDetector(
                child: MessageItem(list[index]),
                onTap: () async {
                  var qs = await QuestionClient.getQuestionsByHomeworkId(list[index].id);
                  var stat;
                  if (list[index].tag == 1 || list[index].tag == 2) {
                    stat = 1;
                  }
                  else {
                    stat = 3;
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeworkDetail.get(stat, list[index], qs)

                  ));
    }
              );
            },
          ),
        ),
        theme: GlobalConfig.themeData
    );
  }

}