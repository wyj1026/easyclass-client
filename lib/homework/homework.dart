import 'package:easy_class/homework/homework_detail.dart';
import 'package:easy_class/homework/homework_item.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/util/config.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class Homework extends StatefulWidget {

  Homework(this.stat) :super();

  final int stat;

  @override
  _HomeworkeState createState() => new _HomeworkeState(this.stat);

}

class _HomeworkeState extends State<Homework> {
  final int stat;

  _HomeworkeState(this.stat) : super();

  @override
  Widget build(BuildContext context) {
    return new InfiniteListView<Class>(
      onRetrieveData: (int page, List<Class> items, bool refresh) async {
        var data = new Class();
        data.class_duration = 16;
        data.classname = '计算机网络第一章节课后';
        data.avatar_url = 'https://b-ssl.duitang.com/uploads/item/201810/18/20181018162951_kgwzm.thumb.700_0.jpeg';
        data.id = 1;
        data.class_date = '周一上午第二节';
        data.gmt_start = 1579610044222;
        items.add(data);
        return true;
      },
      itemBuilder: (List list, int index, BuildContext ctx) {
        return GestureDetector(
          child: HomeworkItem(list[index]),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => new HomeworkDetail(
                rec: list[index],
              ))),
        );
      },
    );
  }

}