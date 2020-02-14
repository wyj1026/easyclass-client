import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';

class Home extends StatefulWidget {

  @override
  _HomeeState createState() => new _HomeeState();

}

class _HomeeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('课程'),
          ),
          body: InfiniteListView<>(
            onRetrieveData: (int page, List<> items, bool refresh) async {
              var data = await get_records();
              print(data.toString());
              items.addAll(data);
              return false;
            },
            itemBuilder: (List list, int index, BuildContext ctx) {
              return GestureDetector(
                child: RecordItem(list[index]),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => new RecordDetail(
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