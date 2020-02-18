import 'package:easy_class/models/user.dart';
import 'package:easy_class/network/login.dart';
import 'package:easy_class/util/config.dart';
import 'package:easy_class/util/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelfView extends StatefulWidget {
  @override
  State createState() {
    return new SelfViewState();
  }
}
class SelfViewState extends State<SelfView> {

  TextEditingController _name = new TextEditingController(text: GlobalConfig.user.name);
  TextEditingController _nickname = new TextEditingController(text: GlobalConfig.user.nickname);
  TextEditingController _email = new TextEditingController(text: GlobalConfig.user.email);
  TextEditingController _phone = new TextEditingController(text: GlobalConfig.user.phone);
  TextStyle titleStyle = new TextStyle(fontSize: 20);
  TextStyle valueStyle = new TextStyle(fontSize: 15);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: new Container(
        color: GlobalConfig.cardBackgroundColor,
          margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
          padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: new Container(
                  margin: const EdgeInsets.only(bottom: 6.0),
                  child: new Text("名字", style: titleStyle,)
              ),
              trailing: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(_name.text, style: valueStyle,),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () async {
                        await _showDialog(_name);
                        GlobalConfig.user.name = _name.text;
                        LoginClient.update();
                      }
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              leading: new Container(
                  margin: const EdgeInsets.only(bottom: 6.0),
                  child: new Text("昵称", style: titleStyle,)
              ),
              trailing: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(_nickname.text, style: valueStyle,),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () async {
                        await _showDialog(_nickname);
                        GlobalConfig.user.nickname = _nickname.text;
                        LoginClient.update();
                      }
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              leading: new Container(
                  margin: const EdgeInsets.only(bottom: 6.0),
                  child: new Text("邮件", style: titleStyle,)
              ),
              trailing: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(_email.text, style: valueStyle,),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () async {
                        await _showDialog(_email);
                        GlobalConfig.user.email = _email.text;
                        LoginClient.update();
                      }
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              leading: new Container(
                  margin: const EdgeInsets.only(bottom: 6.0),
                  child: new Text("手机", style: titleStyle,)
              ),
              trailing: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(_phone.text, style: valueStyle,),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () async {
                        await _showDialog(_phone);
                        GlobalConfig.user.phone = _phone.text;
                        print(GlobalConfig.user.phone);
                        LoginClient.update();
                      }
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }


  _showDialog(TextEditingController controller) async {
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
