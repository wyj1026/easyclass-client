import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/models/homework.dart';
import 'package:easy_class/util/common.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class HomeworkItem extends StatefulWidget {
  HomeworkItem(this.homework) : super(key: ValueKey(homework.id));

  final Homework homework;

  @override
  _HomeworkItemState createState() => _HomeworkItemState(this.homework);
}

DateFormat format = new DateFormat("yyyy-MM-dd hh:mm");

class _HomeworkItemState extends State<HomeworkItem> {
  _HomeworkItemState(Homework clas) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalConfig.cardBackgroundColor,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              dense: true,
              title: Text(
                widget.homework.classname +
                    "——" +
                    widget.homework.homework_title,
                textScaleFactor: 1.3,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                getTimeDiff(widget.homework.gmt_create),
                textScaleFactor: 1.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 0, left: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Container(
//              color: Colors.red,
                    padding: const EdgeInsets.only(
                        top: 0, left: 10, right: 10, bottom: 0),
                    child: Text(
                      "题目数: " + widget.homework.question_number.toString(),
                    ),
                  ),
                  Expanded(
//                  color: Colors.red,
                    child: Align(
                      alignment: Alignment(0.8, 0.0),
                      child: Text("截止: " +
                          format.format(DateTime.fromMillisecondsSinceEpoch(
                              widget.homework.gmt_stop_upload))),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
