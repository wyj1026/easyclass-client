import 'package:easy_class/message/message_detail.dart';
import 'package:easy_class/message/message_item.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/util/config.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {

  @override
  _MessageState createState() => new _MessageState();

}

class _MessageState extends State<Message> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('课程'),
          ),
          body: InfiniteListView<Class>(
            onRetrieveData: (int page, List<Class> items, bool refresh) async {
              var data = new Class();
              data.class_duration = "16";
              data.classname = '您有一项作业即将截止，点击查看～';
              data.avatar_url = 'https://b-ssl.duitang.com/uploads/item/201810/18/20181018162951_kgwzm.thumb.700_0.jpeg';
              data.id = 1;
              data.class_date = '周一上午第二节';
              data.gmt_start = 1579610044222;
              items.add(data);
              return true;
            },
            itemBuilder: (List list, int index, BuildContext ctx) {
              return GestureDetector(
                child: MessageItem(list[index]),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => new MessageDetail(
                      rec: list[index],
                    ))),
              );
            },
          ),
        ),
        theme: GlobalConfig.themeData
    );
  }

}