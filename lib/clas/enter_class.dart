import 'package:easy_class/common/user_view.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/models/index.dart';
import 'package:easy_class/network/role.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'class_item.dart';

class EnterClass extends StatefulWidget {
  EnterClass({Key key, @required this.rec}) : super(key: key);

  final Class rec;
  List<User> teachers = new List();

  @override
  _EnterClassState createState() {
    return new _EnterClassState();
  }
}

class _EnterClassState extends State<EnterClass> {
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
//                  ClassItem(widget.rec),
                  buildTeachers(),
                ],
              ),
            ),
          ],
        ),
      ),
        bottomNavigationBar: RaisedButton(
          color: Colors.white,
          child: Text("确认加入"),
          onPressed: () {
            ClassRole classRole = new ClassRole();
            classRole.classname = widget.rec.classname;
            classRole.user_id = GlobalConfig.user.id;
            classRole.class_id = widget.rec.id;
            classRole.username = GlobalConfig.user.nickname;
            classRole.role = "student";
            classRole.school = "";
            RoleClient.enterClass(classRole);
            Navigator.of(context).pop();
          },
        ));
  }
}
