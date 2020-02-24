import 'package:easy_class/homework/homework.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeworkIndex extends StatefulWidget {

  @override
  _HomeworkIndexState createState() => new _HomeworkIndexState();

}

class _HomeworkIndexState extends State<HomeworkIndex> {
  List<String> user_tabs = <String>["待提交", "未批阅", "已批阅"];
  List<String> teacher_tabs = <String>["已发布", "待批阅", "已批阅"];

  @override
  Widget build(BuildContext context) {
    List<String> tabs = Provider.of<UserMode>(context, listen: false).get()? teacher_tabs:user_tabs;
    int base = Provider.of<UserMode>(context, listen: false).get()? 3: 0;
    return DefaultTabController(
      length: 3,
      child: new Scaffold(

        appBar: new AppBar(
          title: new Text('作业'),
          backgroundColor: GlobalConfig.themeData.primaryColor,
          bottom: new TabBar(
            labelColor: GlobalConfig.dark == true ? new Color(0xFF63FDD9) : Colors.blue,
            unselectedLabelColor: GlobalConfig.dark == true ? Colors.white : Colors.black,
            tabs: tabs.map((t) => new Tab(text: t,)).toList(),
          ),
        ),
        body: new TabBarView(
            children: [
              new HomeworkPage(base + 0),
              new HomeworkPage(base + 1),
              new HomeworkPage(base + 2)
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