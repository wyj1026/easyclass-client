import 'package:easy_class/common/self_view.dart';
import 'package:easy_class/main.dart';
import 'package:easy_class/search/search_page.dart';
import 'package:easy_class/util/config.dart';
import 'package:easy_class/my/self_image.dart';
import 'package:easy_class/util/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const titleFont = const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold
);
const subTitleFont = const TextStyle(
    fontSize: 17,
);

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Widget barSearch() {
    return new Container(
        child: new FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (context) {
                return new SearchPage();
              }));
            },
            child: new Row(
              children: <Widget>[
                new Container(
                  child: new Icon(
                    Icons.search,
                    size: 18.0,
                  ),
                  margin: const EdgeInsets.only(right: 26.0),
                ),
                new Expanded(
                    child: new Container(
                  child: new Text("搜索内容"),
                )),
                new Container(
                  child: new FlatButton(
                    onPressed: () {},
                    child: new Icon(Icons.settings_overscan, size: 18.0),
                  ),
                  width: 40.0,
                ),
              ],
            )),
        decoration: new BoxDecoration(
            borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
            color: GlobalConfig.searchBackgroundColor));
  }

  Widget myInfoCard() {
    return new Container(
      color: GlobalConfig.cardBackgroundColor,
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: new Column(
        children: <Widget>[
          new Container(
            margin:
                const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 6.0),
            decoration: new BoxDecoration(
                color: GlobalConfig.dark == true
                    ? Colors.white10
                    : new Color(0xFFF5F5F5),
                borderRadius: new BorderRadius.all(new Radius.circular(6.0))),
            child: new Container(
              child: new ListTile(
                leading: new Container(
                  child: GestureDetector(
                    child: new ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(GlobalConfig.user.avatar_url),
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => new SingleImageView(),
                    )),
                  ),
                ),
                title: new Container(
                  margin: const EdgeInsets.only(bottom: 2.0),
                  child: new Text(GlobalConfig.user.nickname, style: titleFont,),
                ),
                subtitle: new Container(
                  margin: const EdgeInsets.only(top: 2.0),
                  child: new Text(GlobalConfig.user.email, style: subTitleFont,),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => new SelfView()));
                  },
                ),
              ),
            )
          ),
        ],
      ),
    );
  }

  bool _push = true;

  Widget settings() {
    return new Container(
      color: GlobalConfig.cardBackgroundColor,
      margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
      child: new Column(
        children: <Widget>[
          new MergeSemantics(
            child: ListTile(
              title: Text('教师模式'),
              leading: new Container(
                margin: const EdgeInsets.only(bottom: 6.0),
                child: new CircleAvatar(
                  radius: 20.0,
                  child: new Icon(Icons.school, color: Colors.white),
                  backgroundColor: new Color(0xFFCD853F),
                ),
              ),
              trailing: CupertinoSwitch(
                value: !GlobalConfig.stuMode,
                onChanged: (bool value) {
                  setState(() {
                    GlobalConfig.stuMode = !GlobalConfig.stuMode;
                    Storage.saveUserMode(!value);
                    Provider.of<UserMode>(context, listen: false).change();
                  });
                },
              ),
              onTap: () {
                setState(() {
                  //_lights = !_lights;
                });
              },
            ),
          ),
          new Divider(
            thickness: 0.5,
            indent: 50,
          ),
          new MergeSemantics(
            child: ListTile(
              title: Text('夜间模式'),
              leading: new Container(
                margin: const EdgeInsets.only(bottom: 6.0),
                child: new CircleAvatar(
                  radius: 20.0,
                  child: new Icon(Icons.brightness_2, color: Colors.white),
                  backgroundColor: new Color(0xFFB86A0D),
                ),
              ),
              trailing: CupertinoSwitch(
                value: GlobalConfig.dark,
                onChanged: (bool value) {
                  setState(() {
                    if (GlobalConfig.dark == true) {
                      GlobalConfig.themeData = new ThemeData(
                        primaryColor: Colors.white,
                        scaffoldBackgroundColor: new Color(0xFFEBEBEB),
                      );
                      GlobalConfig.searchBackgroundColor =
                          new Color(0xFFEBEBEB);
                      GlobalConfig.cardBackgroundColor = Colors.white;
                      GlobalConfig.fontColor = Colors.black54;
                    } else {
                      GlobalConfig.themeData =
                          new ThemeData(brightness: Brightness.dark);
                      GlobalConfig.searchBackgroundColor = Colors.white10;
                      GlobalConfig.cardBackgroundColor = new Color(0xFF222222);
                      GlobalConfig.fontColor = Colors.white30;
                    }
                    GlobalConfig.dark =  !GlobalConfig.dark;
                  });
                },
              ),
              onTap: () {
                setState(() {
                  //_lights = !_lights;
                });
              },
            ),
          ),
          new Divider(
            thickness: 0.5,
            indent: 50,
          ),
          new MergeSemantics(
            child: ListTile(
              title: Text('通知推送'),
              leading: new Container(
                margin: const EdgeInsets.only(bottom: 6.0),
                child: new CircleAvatar(
                  radius: 20.0,
                  child: new Icon(Icons.message, color: Colors.white),
                  backgroundColor: new Color(0xFFCD853F),
                ),
              ),
              trailing: CupertinoSwitch(
                value: _push,
                onChanged: (bool value) {
                  setState(() {
                    _push = !_push;
                  });
                },
              ),
              onTap: () {
                setState(() {
                  //_lights = !_lights;
                });
              },
            ),
          ),
          new Divider(
            thickness: 0.5,
            indent: 50,
          ),
          new MergeSemantics(
            child: ListTile(
              title: Text('意见反馈'),
              leading: new Container(
                margin: const EdgeInsets.only(bottom: 6.0),
                child: new CircleAvatar(
                  radius: 20.0,
                  child: new Icon(Icons.golf_course, color: Colors.white),
                  backgroundColor: new Color(0xFF63616D),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  showDialog<Null>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: new Text('很抱歉给您带来困扰,'),
                        content: new SingleChildScrollView(
                          child: new ListBody(
                            children: <Widget>[
                              new Text('烦请将反馈内容发送至:'),
                              new Text('wangyijieim@outlook.com'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text('确定'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  ).then((val) {
                    print(val);
                  });
                },
              ),
              onTap: () {
                setState(() {
                  //_lights = !_lights;
                });
              },
            ),
          ),
          new Divider(
            thickness: 0.5,
            indent: 50,
          ),
          new MergeSemantics(
            child: ListTile(
              title: Text('切换账号'),
              leading: new Container(
                margin: const EdgeInsets.only(bottom: 6.0),
                child: new CircleAvatar(
                  radius: 20.0,
                  child: new Icon(Icons.refresh, color: Colors.white),
                  backgroundColor: new Color(0xFFDEB887),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Storage.delete();
                  Navigator.pushAndRemoveUntil(context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) {
                          return MyApp();
                        },
                      ), (route) => route == null);
                },
              ),
              onTap: () {
                setState(() {
                  //_lights = !_lights;
                });
              },
            ),
          ),
          new Divider(
            thickness: 0.5,
            indent: 50,
          ),
          new MergeSemantics(
            child: ListTile(
              title: Text('注销'),
              leading: new Container(
                margin: const EdgeInsets.only(bottom: 6.0),
                child: new CircleAvatar(
                  radius: 20.0,
                  child: new Icon(Icons.delete, color: Colors.white),
                  backgroundColor: new Color(0xFF63616D),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Storage.delete();
                  Navigator.pushAndRemoveUntil(context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) {
                          return MyApp();
                        },
                      ), (route) => route == null);
                },
              ),
              onTap: () {
                setState(() {
                  //_lights = !_lights;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget settingCard() {
    return new Container(
      color: GlobalConfig.cardBackgroundColor,
      margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            width: MediaQuery.of(context).size.width / 4,
            child: new FlatButton(
                onPressed: () {},
                child: new Container(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(bottom: 6.0),
                        child: new CircleAvatar(
                          radius: 20.0,
                          child: new Icon(Icons.invert_colors,
                              color: Colors.white),
                          backgroundColor: new Color(0xFFB88800),
                        ),
                      ),
                      new Container(
                        child: new Text("社区建设",
                            style: new TextStyle(
                                color: GlobalConfig.fontColor, fontSize: 14.0)),
                      )
                    ],
                  ),
                )),
          ),
          new Container(
            width: MediaQuery.of(context).size.width / 4,
            child: new FlatButton(
                onPressed: () {},
                child: new Container(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(bottom: 6.0),
                        child: new CircleAvatar(
                          radius: 20.0,
                          child:
                              new Icon(Icons.golf_course, color: Colors.white),
                          backgroundColor: new Color(0xFF63616D),
                        ),
                      ),
                      new Container(
                        child: new Text("反馈",
                            style: new TextStyle(
                                color: GlobalConfig.fontColor, fontSize: 14.0)),
                      )
                    ],
                  ),
                )),
          ),
          new Container(
            width: MediaQuery.of(context).size.width / 4,
            child: new FlatButton(
                onPressed: () {
                  setState(() {
                    if (GlobalConfig.dark == true) {
                      GlobalConfig.themeData = new ThemeData(
                        primaryColor: Colors.white,
                        scaffoldBackgroundColor: new Color(0xFFEBEBEB),
                      );
                      GlobalConfig.searchBackgroundColor =
                          new Color(0xFFEBEBEB);
                      GlobalConfig.cardBackgroundColor = Colors.white;
                      GlobalConfig.fontColor = Colors.black54;
                      GlobalConfig.dark = false;
                    } else {
                      GlobalConfig.themeData =
                          new ThemeData(brightness: Brightness.dark);
                      GlobalConfig.searchBackgroundColor = Colors.white10;
                      GlobalConfig.cardBackgroundColor = new Color(0xFF222222);
                      GlobalConfig.fontColor = Colors.white30;
                      GlobalConfig.dark = true;
                    }
                  });
                },
                child: new Container(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(bottom: 6.0),
                        child: new CircleAvatar(
                          radius: 20.0,
                          child: new Icon(
                              GlobalConfig.dark == true
                                  ? Icons.wb_sunny
                                  : Icons.brightness_2,
                              color: Colors.white),
                          backgroundColor: new Color(0xFFB86A0D),
                        ),
                      ),
                      new Container(
                        child: new Text(
                            GlobalConfig.dark == true ? "日间模式" : "夜间模式",
                            style: new TextStyle(
                                color: GlobalConfig.fontColor, fontSize: 14.0)),
                      )
                    ],
                  ),
                )),
          ),
          new Container(
            width: MediaQuery.of(context).size.width / 4,
            child: new FlatButton(
                onPressed: () {},
                child: new Container(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(bottom: 6.0),
                        child: new CircleAvatar(
                          radius: 20.0,
                          child: new Icon(Icons.perm_data_setting,
                              color: Colors.white),
                          backgroundColor: new Color(0xFF636269),
                        ),
                      ),
                      new Container(
                        child: new Text("设置",
                            style: new TextStyle(
                                color: GlobalConfig.fontColor, fontSize: 14.0)),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: GlobalConfig.themeData,
      home: new Scaffold(
          appBar: new AppBar(
            title: barSearch(),
          ),
          body: new SingleChildScrollView(
            child: new Container(
              child: new Column(
                children: <Widget>[
                  myInfoCard(),
//                  settingCard(),
                  settings(),
                ],
              ),
            ),
          )),
    );
  }
}
