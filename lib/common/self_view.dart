import 'package:easy_class/models/user.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelfView extends StatefulWidget {
  final User user;

  @override
  State createState() {
    return new SelfViewState(user: this.user);
  }

  SelfView(this.user) : super();
}
class SelfViewState extends State<SelfView> {
  SelfViewState({Key key, @required this.user}) {
    _nickname.text = this.user.nickname;;
  }

  final User user;
  TextEditingController _nickname = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: new Center(
        child: ListTile(
          title: Text(_nickname.text),
          leading: new Container(
            margin: const EdgeInsets.only(bottom: 6.0),
            child: new CircleAvatar(
              radius: 20.0,
              child: new Icon(Icons.message, color: Colors.white),
              backgroundColor: new Color(0xFFCD853F),
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              _showDialog();
            }
          ),
        ),
      ),
    );
  }

  _showDialog() async {
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
                    controller: _nickname,
                    decoration: new InputDecoration(
                        labelText: 'Full Name', hintText: 'eg. John Smith'),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              new FlatButton(
                  child: const Text('OPEN'),
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
