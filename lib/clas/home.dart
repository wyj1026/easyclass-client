import 'package:easy_class/clas/new_class.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/network/class.dart';
import 'package:easy_class/util/config.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'class_detail.dart';
import 'class_item.dart';

class Home extends StatefulWidget {

  @override
  _HomeeState createState() => new _HomeeState();

}

class _HomeeState extends State<Home> with TickerProviderStateMixin {
  static const List<String> barOption = <String>["加入课程", "新增课程"];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('课程'),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: onSelectedOption,
                itemBuilder: (BuildContext context) {
                  return barOption.map( (String option) {
                    return PopupMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList();
                }
              )
            ],
          ),
          body: InfiniteListView<Class>(
            onRetrieveData: (int page, List<Class> items, bool refresh) async {
//              var data = new Class();
//              data.class_duration = 16;
//              data.classname = '数据机构';
//              data.avatar_url = 'https://b-ssl.duitang.com/uploads/item/201810/18/20181018162951_kgwzm.thumb.700_0.jpeg';
//              data.id = 1;
//              data.class_date = '周一上午第二节';
//              data.gmt_start = 1579610044222;
              var data = await ClassClient.getAllMyClass();
              items.addAll(data);
              return false;
            },
            itemBuilder: (List list, int index, BuildContext ctx) {
              return GestureDetector(
                child: ClassItem(list[index]),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => new ClassDetail(
                      rec: list[index],
                    ))),
              );
            },
          ),
        ),
        theme: GlobalConfig.themeData

    );
  }

  void onSelectedOption(String option) {
    if (option == "新增课程") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => new NewClass()
      ));
    }
  }
}