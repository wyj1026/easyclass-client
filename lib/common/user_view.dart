import 'package:easy_class/models/user.dart';
import 'package:easy_class/my/self_image.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const titleFont = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
const subTitleFont = const TextStyle(
  fontSize: 14,
);

class UserView extends StatefulWidget {
  final User user;

  UserView({Key key, @required this.user}) : super(key: key);

  @override
  State createState() {
    return new UserViewState(user: user);
  }
}

class UserViewState extends State<UserView> {
  UserViewState({Key key, @required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
//          color: GlobalConfig.cardBackgroundColor,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                decoration: new BoxDecoration(
                    color: GlobalConfig.cardBackgroundColor,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(6.0))),
                child: myInfoCard(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                        color: GlobalConfig.cardBackgroundColor,
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(6.0))),
                    constraints: BoxConstraints(minWidth: double.infinity),
                    padding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    child: Text(
                      "介绍:",
                      textScaleFactor: 1.3,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: double.infinity),
                    decoration: new BoxDecoration(
                        color: GlobalConfig.cardBackgroundColor,
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(6.0))),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    padding: const EdgeInsets.only(
                        top: 0, left: 10, right: 10, bottom: 20),
                    child: Text(
                      user.description,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget myInfoCard() {
    return Column(children: <Widget>[
      //Flex的两个子widget按1：2来占据水平空间
      Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 8.0, left: 25, right: 20),
//              color: Colors.red,
                child: GestureDetector(
                  child: new ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(user.avatar_url),
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => new SingleImageView(),
                  )),
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                height: 90,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: new Container(
                        constraints: BoxConstraints(minWidth: double.infinity),
//                      color: Colors.blue,
                        margin: const EdgeInsets.only(bottom: 3.0),
                        child: new Text(
                          user.name,
                          style: titleFont,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: new Container(
                        constraints: BoxConstraints(minWidth: double.infinity),
//                      color: Colors.green,
                        margin: const EdgeInsets.only(bottom: 3.0),
                        child: new Text(
                          "昵称: " + user.nickname,
                          style: subTitleFont,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: new Container(
                        constraints: BoxConstraints(minWidth: double.infinity),
//                      color: Colors.red,
                        margin: const EdgeInsets.only(bottom: 3.0),
                        child: new Text(
                          "邮箱: " + user.email,
                          style: subTitleFont,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      )
    ]);
  }
}
