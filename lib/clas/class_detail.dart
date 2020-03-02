import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_class/common/user_view.dart';
import 'package:easy_class/homework/new_homework_title.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/models/index.dart';
import 'package:easy_class/network/role.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


DateFormat format = new DateFormat("yyyy-MM-dd hh:mm");

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

  @override
  void initState() {
    super.initState();
    //初始化时即进行数据请求
    getTeachers();
  }

  Widget buildFloatingButton() {
    return new IconButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => new NewHomeworkTitle(
                id: widget.rec.id, classname: widget.rec.classname)));
      },
      tooltip: '新建作业',
      icon: new Icon(Icons.add),
    );
  }

  getTeachers() async {
    widget.teachers = await RoleClient.getAllTeacher(widget.rec.id);
    print(widget.teachers.length);
    setState(() {
      widget.teachers;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool stuMode = Provider.of<UserMode>(context, listen: false).get() ? true : false;
    return Scaffold(
      appBar: stuMode
          ? AppBar(
              title: Text('课程'),
              actions: <Widget>[],
            )
          : AppBar(
              title: Text('课程'),
              actions: <Widget>[buildFloatingButton()],
            ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(minWidth: double.infinity),
                    color: GlobalConfig.cardBackgroundColor,
                    margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Container(
//        color: GlobalConfig.primaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10, bottom: 10),
                            child: Text(
                              widget.rec.classname,
                              textScaleFactor: 1.9,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            padding: const EdgeInsets.only(
                                top: 0, left: 10, right: 10, bottom: 10),
                            child: Text(
                              "开课时间: " +
                                  format
                                      .format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              widget.rec.gmt_start))
                                      .toString(),
                              textScaleFactor: 1.1,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            padding: const EdgeInsets.only(
                                top: 0, left: 10, right: 10, bottom: 20),
                            child: Text(
                              "课程周数: " + widget.rec.class_duration,
                              textScaleFactor: 1.1,
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl: widget.rec.avatar_url,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>null,
                            errorWidget: (context, url, error) =>null,
                          ),
                          Image.network("https://bkimg.cdn.bcebos.com/pic/5fdf8db1cb134954e3e575b6584e9258d0094a6d?x-bce-process=image/watermark,g_7,image_d2F0ZXIvYmFpa2U4MA==,xp_5,yp_5"),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: GlobalConfig.cardBackgroundColor,
                    margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Container(
//        color: GlobalConfig.primaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            constraints:
                                BoxConstraints(minWidth: double.infinity),
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10, bottom: 10),
                            child: Text(
                              "课程介绍",
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            padding: const EdgeInsets.only(
                                top: 0, left: 10, right: 10, bottom: 20),
                            child: Text(
                              widget.rec.description,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: GlobalConfig.cardBackgroundColor,
                    margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Container(
//        color: GlobalConfig.primaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            constraints:
                                BoxConstraints(minWidth: double.infinity),
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10, bottom: 10),
                            child: Text(
                              "学校",
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            padding: const EdgeInsets.only(
                                top: 0, left: 10, right: 10, bottom: 20),
                            child: Text(
                              widget.rec.school,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: GlobalConfig.cardBackgroundColor,
                    margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Container(
//        color: GlobalConfig.primaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            constraints:
                                BoxConstraints(minWidth: double.infinity),
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10, bottom: 10),
                            child: Text(
                              "老师",
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          new Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              padding: const EdgeInsets.only(
                                  top: 0, left: 10, right: 10, bottom: 20),
                              child: Column(
                                  children:
                                      widget.teachers.map((item) => new GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          new UserView(
                                                            user: item,
                                                          )));
                                            },
                                            child: new Text(
                                                item.name,
                                              textScaleFactor: 1.2,
                                              style: TextStyle(

                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                          ))
                                      .toList()
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: null,
    );
  }
}
