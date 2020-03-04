import 'package:easy_class/models/index.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/material.dart';

class NewObjQuestionPage extends StatefulWidget {
  @override
  NewObjQuestionPageState createState() => new NewObjQuestionPageState();
}

class NewObjQuestionPageState extends State<NewObjQuestionPage> {
  final TextEditingController _title = new TextEditingController();
  TextEditingController _duration = new TextEditingController();
  TextEditingController _answer = new TextEditingController();
  bool is_multity = false;
  List<String> options = new List();
  List<bool> content = new List();

  List<TextEditingController> _controllers = new List();
  List<bool> _checkbox = new List();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("添加客观题"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                options.addAll(_controllers.map((f) => f.text).toList());
                //add_record(Main.user_name, Main.avatarUrl, _controller.text, images),
                Question q = new Question();
                q.question = _title.text;
                q.gmt_create = DateTime.now().millisecondsSinceEpoch;
                q.is_objective = true;
                q.grade = int.parse(_duration.text);
                q.answer = {"options": options, "content": _checkbox};
                q.is_multity = is_multity;
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 2, 0, 5),
                    padding: const EdgeInsets.only(top: 0.0, bottom: 15.0),
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
                              maxLines: 3,
                              autofocus: true,
                            ),
                          ),
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        ),
                      ],
                    ),
                  ),
                ]
                  ..add(Container(
                    margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                    padding: const EdgeInsets.only(top: 0.0, bottom: 15.0),
                    color: GlobalConfig.cardBackgroundColor,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            color: GlobalConfig.cardBackgroundColor,
                            margin: const EdgeInsets.fromLTRB(20, 15, 0, 5),
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                text: "* ",
                                style: TextStyle(color: Colors.red),
                              ),
                              TextSpan(
                                text: "选项",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ])),
                          )
                        ]
                          ..addAll(_controllers
                              .map((controller) =>
                                  get(_controllers.indexOf(controller)))
                              .toList())
                          ..add(
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                              alignment: Alignment(0, 0),
                              child: RaisedButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                icon: Icon(Icons.add),
                                color: Colors.lightBlue,
                                label: Text("添加选项"),
                                highlightColor: Colors.blue[700],
                                colorBrightness: Brightness.dark,
                                splashColor: Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    _controllers = List.from(_controllers)
                                      ..add(new TextEditingController());
                                    _checkbox = List.from(_checkbox)
                                      ..add(false);
                                  });
                                },
                              ),
                            ),
                          )),
                  ))
                  ..add(
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                      color: GlobalConfig.cardBackgroundColor,
                      child:                     ListTile(
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
                                  await _showDialog(
                                      _duration, TextInputType.number);
                                  setState(() {});
                                }),
                          ],
                        ),
                      ),
                    )
                  ))));
  }

  Widget get(int index) {
    return new Container(
        margin: const EdgeInsets.all(0.0),
        alignment: Alignment(-1.0, 1),
//                color: Colors.blue,
        child: Row(
          children: <Widget>[
            Checkbox(
              value: _checkbox[index],
              onChanged: (value) {
                setState(() {
                  _checkbox[index] = value;
                });
              },
            ),
            new Expanded(
              child: TextField(
                controller: _controllers[index],
                decoration: new InputDecoration(
                    hintText: "请输入选项...", hintStyle: new TextStyle()),
              ),
            )
          ],
        ));
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
