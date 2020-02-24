import 'package:easy_class/clas/enter_class.dart';
import 'package:easy_class/clas/new_class.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/network/class.dart';
import 'package:easy_class/util/config.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'class_detail.dart';
import 'class_item.dart';

class Home extends StatefulWidget {

  @override
  _HomeeState createState() => new _HomeeState();

}

class _HomeeState extends State<Home> with TickerProviderStateMixin {
//  static const List<String> barOption = <String>["加入课程", "新增课程"];

  @override
  Widget build(BuildContext context) {
    List<String> barOption = Provider.of<UserMode>(context, listen: false).get()? <String>["新增课程"] : <String>["加入课程"];
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

  TextEditingController _name = new TextEditingController();

  void onSelectedOption(String option) async {
    if (option == "新增课程") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => new NewClass()
      ));
    }
    else if (option == "加入课程") {
      bool res = await _showDialog(_name, TextInputType.number);
      if (!res) {
        return;
      }
      Class cas = await ClassClient.getById(_name.text);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => new EnterClass(rec: cas,)
      ));
    }
  }


  Future<bool> _showDialog(TextEditingController controller, TextInputType kbt) async {
    await showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new _SystemPadding(
          child: new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    keyboardType: kbt,
                    autofocus: true,
                    controller: controller,
//                    decoration: new InputDecoration(
//                        labelText: 'Full Name', hintText: 'eg. John Smith'),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('取消'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    return false;
                  }),
              new FlatButton(
                  child: const Text('确定'),
                  onPressed: () {
                    Navigator.pop(context);
                    return true;
                  })
            ],
          ),);
      },
    );
  }
}



class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}