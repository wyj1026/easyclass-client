import 'package:easy_class/common/user_view.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/models/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'class_item.dart';

class ClassDetail extends StatefulWidget {
  ClassDetail({Key key, @required this.rec}) : super(key: key);

  final Class rec;
  List<User> teachers = new List();

  @override
  _ClassDetailState createState() {
    return new _ClassDetailState();
  }
}

class _ClassDetailState extends State<ClassDetail> {
  TextEditingController _commentController = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  FocusScopeNode focusScopeNode;

  Widget buildTeachers() {
    return new Container(
        child: Column(
            children: widget.teachers
                .map((item) => new GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => new UserView(user: item,)));
                      },
                      child: new Text(item.nickname),
                    ))
                .toList()));
  }

  @override
  Widget build(BuildContext context) {
    User u = new User();
    u.nickname = "王老师";
    widget.teachers.add(u);
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: <Widget>[
                  ClassItem(widget.rec),
                  buildTeachers(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: null,
    );
  }

//  void render(String text) {
//    Map newComment = new Map();
//    newComment["avatar_url"] = Main.avatarUrl;
//    newComment["by"] = Main.user_name;
//    newComment["content"] = text;
//    newComment["timestamp"] = DateTime.now().millisecondsSinceEpoch.toString();
//    widget.rec.comments.add(newComment);
//    widget.rec.comment_count++;
//    add_comment(widget.rec.id, Main.user_name, Main.avatarUrl, text, newComment["timestamp"]);
//  }
}
