import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/models/homework.dart';
import 'package:easy_class/util/common.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeworkItem extends StatefulWidget {
  HomeworkItem(this.homework) : super(key: ValueKey(homework.id));

  final Homework homework;

  @override
  _HomeworkItemState createState() => _HomeworkItemState(this.homework);
}

class _HomeworkItemState extends State<HomeworkItem> {

  _HomeworkItemState(Homework clas) {
  }


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
                widget.homework.id.toString() + widget.homework.classname,
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                getTimeDiff(widget.homework.gmt_create),
                textScaleFactor: 0.9,
              ),
            ),
            Container(
              color: Colors.red,
              padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
              child: Text(
                widget.homework.classname,
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
