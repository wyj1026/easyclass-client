import 'package:easy_class/util/config.dart';
import 'package:flutter/material.dart';

class NewNobjQuestionPage extends StatefulWidget {
  @override
  NewNobjQuestionPageState createState() => new NewNobjQuestionPageState();
}

class NewNobjQuestionPageState extends State<NewNobjQuestionPage> {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("添加问题"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () => {
                //add_record(Main.user_name, Main.avatarUrl, _controller.text, images),
                Navigator.of(context).pop()
              },
              child: Icon(
                Icons.check,
                color: Colors.black,
              ),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            )
          ],
        ),
        body: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Container(
                color: Colors.amber,
                child: new TextField(
                  maxLines: 6,
                  autofocus: true,
                  decoration: new InputDecoration(
                      hintText: "请输入题目...", hintStyle: new TextStyle()),
                ),
                margin: const EdgeInsets.all(16.0),
              ),
              new Container(
                color: Colors.amber,
                child: new TextField(
                  maxLines: 1,
                  decoration: new InputDecoration(
                      hintText: "请输入分值...", hintStyle: new TextStyle()),
                ),
                margin: const EdgeInsets.all(16.0),
              ),
              new Container(
                color: Colors.amber,
                margin: const EdgeInsets.all(16.0),
                  child: new TextField(
                maxLines: 6,
                controller: _controller,
                decoration: new InputDecoration(
                    hintText: '请输入答案...', hintStyle: new TextStyle(), border: InputBorder.none),
              )),
            ],
          ),
        ));
  }
}
