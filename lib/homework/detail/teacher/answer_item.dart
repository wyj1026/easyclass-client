import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_class/models/answer.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/models/homework.dart';
import 'package:easy_class/models/index.dart';
import 'package:easy_class/util/common.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnswerItem extends StatefulWidget {
  AnswerItem(this.user) : super(key: ValueKey(user.id));

//  final Answer answer;
  final User user;

  @override
  _AnswerItemState createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalConfig.cardBackgroundColor,
      margin: EdgeInsets.fromLTRB(0, 2, 0, 6),
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            dense: true,
            title: Text(
              "学生姓名: " + widget.user.name,
              textScaleFactor: 1.3,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 0, left: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Container(
//              color: Colors.red,
                  padding: const EdgeInsets.only(
                      top: 0, left: 10, right: 10, bottom: 0),
                  child: Text(
                    "昵称: " + widget.user.nickname,
                  ),
                ),
                Expanded(
//                  color: Colors.red,
                    child: Align(
                        alignment: Alignment(0.8, 0.0),
                        child: Text("邮箱: " + widget.user.email)))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
