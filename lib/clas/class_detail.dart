import 'package:easy_class/common/user_view.dart';
import 'package:easy_class/homework/homework.dart';
import 'package:easy_class/homework/new_homework.dart';
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

  Widget buildFloatingButton() {
    var data = new Class();
    data.class_duration = 16;
    data.classname = '计算机网络第一章节课后';
    data.avatar_url = 'https://b-ssl.duitang.com/uploads/item/201810/18/20181018162951_kgwzm.thumb.700_0.jpeg';
    data.id = 1;
    data.class_date = '周一上午第二节';
    data.gmt_start = 1579610044222;
    return new FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => new NewHomework(rec: data) ));
      },
      tooltip: '新建作业',
      child: new Icon(Icons.add),
    );
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
      floatingActionButton: buildFloatingButton(),
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
