import 'package:easy_class/models/homework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MessageDetail extends StatefulWidget {
  MessageDetail({Key key, @required this.rec}) : super(key: key);

  final Homework rec;

  @override
  _MessageDetailState createState() {
    return new _MessageDetailState();
  }


}

class _MessageDetailState extends State<MessageDetail> {
  TextEditingController _commentController = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body:
      ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: <Widget>[
//                    HomeworkItem(widget.rec),
                  ],
                )
            ),
          ],
        ),
      ),
      bottomNavigationBar: null,
    );
  }
}