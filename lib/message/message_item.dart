import 'package:easy_class/models/homework.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

DateFormat format = new DateFormat("yyyy-MM-dd hh:mm");

class MessageItem extends StatefulWidget {
  MessageItem(this.clas) : super(key: ValueKey(clas.id));

  final Homework clas;

  @override
  _MessageItemState createState() => _MessageItemState(this.clas);
}

class _MessageItemState extends State<MessageItem> {
  _MessageItemState(Homework clas) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalConfig.cardBackgroundColor,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 45,
                    height: 45,
                    margin: EdgeInsets.fromLTRB(15, 8, 8, 0),
                    child: getCircle(),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 25,
//                            color: Colors.blue,
                            child: Text(getTitle(),
                              textScaleFactor: 1.1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                          Container(
                            height: 20,
//                            color: Colors.red,
                            child: Text(getDetail()),
                          )
                        ],
                      ),
                  ),

                  Expanded(
//                  color: Colors.red,
                    child: Align(
                      alignment: Alignment(0.8, 1.0),
                      child: Text("截止: " +
                          format.format(DateTime.fromMillisecondsSinceEpoch(widget.clas.gmt_stop_upload))),
                    ),
                  )

                ],
              ),
            ),
            Transform.scale(scale: 0.8, child: Divider(),)
//            Divider(),
          ],
        ),
      ),
    );
  }

  String getTitle() {
    String res = "";
    res += "作业: \"" + widget.clas.homework_title + "\" ";
    if (widget.clas.tag == 1) {
      res += "新发布.";
    }
    else if (widget.clas.tag == 2) {
      res += "即将截止提交.";
    }
    else if (widget.clas.tag == 3) {
      res += "已截止提交.";
    }
    return res;
  }

  String getDetail() {
    String res = "";
    res += "题目数量: " + widget.clas.question_number.toString() + " ";
    res += "分值: " + widget.clas.total_grade.toString() + " ";
    return res;
  }

  Widget getCircle() {
    if (widget.clas.tag == 1) {
      return CircleAvatar(
        radius: 20.0,
        child: new Icon(Icons.border_color, color: Colors.white),
        backgroundColor: Colors.lightGreen,
      );
    }
    else if (widget.clas.tag == 2) {
      return CircleAvatar(
        radius: 20.0,
        child: new Icon(Icons.access_time, color: Colors.white),
        backgroundColor: Colors.amber,
      );
    }
    else if (widget.clas.tag == 3) {
      return CircleAvatar(
        radius: 20.0,
        child: new Icon(Icons.school, color: Colors.white),
        backgroundColor: Colors.lightBlueAccent,
      );
    }
  }
}
