import 'package:easy_class/models/homework.dart';
import 'package:easy_class/util/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessageItem extends StatefulWidget {
  MessageItem(this.clas) : super(key: ValueKey(clas.id));

  final Homework clas;

  @override
  _MessageItemState createState() => _MessageItemState(this.clas);
}

class _MessageItemState extends State<MessageItem> {

  _MessageItemState(Homework clas) {
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
              title: Text(
                widget.clas.classname,
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                getTimeDiff(widget.clas.gmt_create),
                textScaleFactor: 0.9,
              ),
            ),
            Container(
              color: Colors.red,
              padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
              child: Text(
                widget.clas.classname,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
