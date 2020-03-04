import 'package:easy_class/models/index.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/material.dart';

class NewNobjQuestionPage extends StatefulWidget {
  @override
  NewNobjQuestionPageState createState() => new NewNobjQuestionPageState();
}

class NewNobjQuestionPageState extends State<NewNobjQuestionPage> {
  final TextEditingController _title = new TextEditingController();
  TextEditingController _duration = new TextEditingController();
  TextEditingController _answer = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("添加主观题"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                //add_record(Main.user_name, Main.avatarUrl, _controller.text, images),
                Question q = new Question();
                q.question = _title.text;
                q.gmt_create = DateTime.now().millisecondsSinceEpoch;
                q.is_objective = false;
                q.grade = int.parse(_duration.text);
                q.answer = {
                  "options": [_answer.text],
                  "content": [true]
                };
                q.is_multity = false;
                Navigator.of(context).pop(q);
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
            child: Container(
              color: GlobalConfig.cardBackgroundColor,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.fromLTRB(20, 15, 0, 5),
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "* ",
                    style: TextStyle(color: Colors.red),
                  ),
                  TextSpan(
                    text: "题目",
                    style: TextStyle(color: Colors.blue),
                  ),
                ])),
              ),
              new Container(
//                color: Colors.amber,
                child: Theme(
                  data: new ThemeData(
                      primaryColor: Colors.lightBlueAccent,
                      hintColor: Colors.black),
                  child: new TextField(
                    decoration: InputDecoration(
                        hintText: "请输入题目...",
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
//            borderSide: BorderSide(color: Colors.red, width: 3.0, style: BorderStyle.solid)//没什么卵效果
                        )),
                    controller: _title,
                    maxLines: 4,
                    autofocus: true,
                  ),
                ),
                margin: const EdgeInsets.all(16.0),
              ),
              new Container(
                margin: const EdgeInsets.fromLTRB(20, 15, 0, 5),
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "* ",
                    style: TextStyle(color: Colors.red),
                  ),
                  TextSpan(
                    text: "题目",
                    style: TextStyle(color: Colors.blue),
                  ),
                ])),
              ),
              new Container(
//                color: Colors.amber,
                  margin: const EdgeInsets.all(16.0),
                  child: Theme(
                    data: new ThemeData(
                        primaryColor: Colors.lightBlueAccent,
                        hintColor: Colors.black),
                    child: new TextField(
                      decoration: InputDecoration(
                          hintText: "请输入参考答案...",
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
//            borderSide: BorderSide(color: Colors.red, width: 3.0, style: BorderStyle.solid)//没什么卵效果
                          )),
                      controller: _answer,
                      maxLines: 6,
                      autofocus: true,
                    ),
                  )),
              Divider(),
              ListTile(
                leading: new Container(
                    margin: const EdgeInsets.only(bottom: 6.0),
                    child: new Text(
                      "分值",
                        style: TextStyle(fontSize: 16),
                    )),
                trailing: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(_duration.text),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () async {
                          await _showDialog(_duration, TextInputType.number);
                          setState(() {});
                        }),
                  ],
                ),
              ),
            ],
          ),
        )));
  }

  _showDialog(TextEditingController controller, TextInputType kbt) async {
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
                  }),
              new FlatButton(
                  child: const Text('确定'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        );
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
