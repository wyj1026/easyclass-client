import 'package:easy_class/models/class.dart';
import 'package:easy_class/util/common.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClassItem extends StatefulWidget {
  ClassItem(this.clas) : super(key: ValueKey(clas.id));

  final Class clas;

  @override
  _ClassItemState createState() => _ClassItemState(this.clas);
}

class _ClassItemState extends State<ClassItem> {

  _ClassItemState(Class clas) {
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalConfig.cardBackgroundColor,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Container(
//        color: GlobalConfig.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              dense: true,
              title: Text(
                widget.clas.school + "——" + widget.clas.classname,
                textScaleFactor: 1.3,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                getTimeDiff(widget.clas.gmt_start),
                textScaleFactor: 1.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
              child: Text(
                widget.clas.description,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    const paddingWidth = 10;
    return IconTheme(
      data: IconThemeData(
        color: Colors.grey,
        size: 20,
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.grey, fontSize: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(builder: (context) {
            var children = <Widget>[
              IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.red),
                onPressed: null,
              ),
              Text(" ".padRight(paddingWidth)),
              Icon(Icons.chat_bubble_outline),
              Text(" " +
                  widget.clas.class_duration.toString().padRight(paddingWidth)),
            ];

            return Row(children: children);
          }),
        ),
      ),
    );
  }
}
