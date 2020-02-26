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
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Container(
        color: Colors.grey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              dense: true,
//              leading: gmAvatar(
//                widget.homework.,
//                width: 40.0,
//                borderRadius: BorderRadius.circular(20),
//              ),
              title: Text(
                widget.user.id.toString() + widget.user.name,
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "123",
                textScaleFactor: 0.9,
              ),
            ),
            Container(
              color: Colors.red,
              padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
              child: Text(
                widget.user.nickname,
              ),
            ),
//                Positioned(
//                  top: 150,
//                  child:
//                  SizedBox(
//                    width: MediaQuery.of(context).size.width,
//                    height: MediaQuery.of(context).size.width,
//                    child: buildGridView(),
//                  ),
//                ),

//                Padding(
//                  padding: const EdgeInsets.only(top: 5),
//                  child: _buildBottom(),
//                )
          ],
        ),
      ),
    );
  }
}
