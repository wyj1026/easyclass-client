import 'package:easy_class/homework/homework.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/material.dart';

class HomeworkIndex extends StatefulWidget {

  @override
  _HomeworkIndexState createState() => new _HomeworkIndexState();

}

class _HomeworkIndexState extends State<HomeworkIndex> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: new Scaffold(

        appBar: new AppBar(
          title: new Text('作业'),
          backgroundColor: GlobalConfig.themeData.primaryColor,
          bottom: new TabBar(
            labelColor: GlobalConfig.dark == true ? new Color(0xFF63FDD9) : Colors.blue,
            unselectedLabelColor: GlobalConfig.dark == true ? Colors.white : Colors.black,
            tabs: [
              new Tab(text: "待提交"),
              new Tab(text: "未批阅"),
              new Tab(text: "已批阅"),
            ],
          ),
        ),
        body: new TabBarView(
            children: [
              new HomeworkPage(0),
              new HomeworkPage(1),
              new HomeworkPage(2)
            ]
        ),
      ),
    );

//    return new MaterialApp(
//        home: new Scaffold(
//          appBar: new AppBar(
//            title: new Text('课程'),
//          ),
//          body: DefaultTabController(
//            length: 2,
//            child: new Scaffold(
//              appBar: new AppBar(
////                title: new Text('课程'),
//                bottom: new TabBar(
//                  labelColor: GlobalConfig.dark == true ? new Color(0xFF63FDD9) : Colors.blue,
//                  unselectedLabelColor: GlobalConfig.dark == true ? Colors.white : Colors.black,
//                  tabs: [
//                    new Tab(text: "待提交"),
//                    new Tab(text: "已完成"),
//                  ],
//                ),
//              ),
//              body: new TabBarView(
//                  children: [
//                    new Homework(),
//                    new Homework(),
//                  ]
//              ),
//            ),
//          )
//        ),
//        theme: GlobalConfig.themeData
//    );
  }
}