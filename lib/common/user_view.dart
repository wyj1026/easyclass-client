import 'package:easy_class/models/user.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserView extends StatelessWidget {
  UserView({Key key, @required this.user}): super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: new Center(
          child: new Text(this.user.nickname),
        )
    );
  }
}