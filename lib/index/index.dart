
import 'package:easy_class/clas/home.dart';
import 'package:easy_class/homework/homework.dart';
import 'package:easy_class/homework/homework_index.dart';
import 'package:easy_class/message/message.dart' as prefix0;
import 'package:easy_class/models/homework.dart';
import 'package:easy_class/my/my_page.dart';
import 'package:easy_class/network/homework.dart';
import 'package:easy_class/util/config.dart';
import 'package:easy_class/util/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'navigation_icon_view.dart';

class Index extends StatefulWidget {

  @override
  State<Index> createState() => new _IndexState();
}

class _IndexState extends State<Index> with TickerProviderStateMixin{

  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;
  List<StatefulWidget> _pageList;
  StatefulWidget _currentPage;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool showedNotice = false;

  @override
  void initState() {
    super.initState();
    initNotifications();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: new Icon(Icons.assignment),
        title: new Text("课程"),
        vsync: this,
      ),
      new NavigationIconView(
        icon: new Icon(Icons.all_inclusive),
        title: new Text("作业"),
        vsync: this,
      ),
      new NavigationIconView(
        icon: new Icon(Icons.add_alert),
        title: new Text("消息"),
        vsync: this,
      ),
      new NavigationIconView(
        icon: new Icon(Icons.perm_identity),
        title: new Text("我的"),
        vsync: this,
      ),
    ];
    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }
    _pageList = <StatefulWidget>[
      new Home(),
      new HomeworkIndex(),
      new prefix0.Message(),
      new MyPage()
    ];
    _currentPage = _pageList[_currentIndex];
  }

  void _rebuild() {
    setState((){});
  }

  @override
  void dispose() {
    super.dispose();
    for (NavigationIconView view in _navigationViews) {
      view.controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    showNotice();
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
        items: _navigationViews
            .map((NavigationIconView navigationIconView) => navigationIconView.item)
            .toList(),
        currentIndex: _currentIndex,
        fixedColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState((){
            _navigationViews[_currentIndex].controller.reverse();
            _currentIndex = index;
            _navigationViews[_currentIndex].controller.forward();
            _currentPage = _pageList[_currentIndex];
          });
        }
    );
    return
      ChangeNotifierProvider(
        create: (context) => UserMode(),
        child: new MaterialApp(
            home: new Scaffold(
                body: new Center(
                    child: _currentPage
                ),
                bottomNavigationBar: bottomNavigationBar
            ),
            theme: GlobalConfig.themeData
        ),
      );
  }

  void initNotifications() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
    setState(() {
      _navigationViews[_currentIndex].controller.reverse();
      _currentIndex = 2;
      _navigationViews[_currentIndex].controller.forward();
      _currentPage = _pageList[_currentIndex];
    });
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => SecondScreen(payload),
//                ),
//              );
            },
          )
        ],
      ),
    );
  }

  Future _showNotification(String title, String content, String payload) async {
    //安卓的通知配置，必填参数是渠道id, 名称, 和描述, 可选填通知的图标，重要度等等。
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    //IOS的通知配置
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    //显示通知，其中 0 代表通知的 id，用于区分通知。
    await flutterLocalNotificationsPlugin.show(
        0, title, content, platformChannelSpecifics,
        payload: payload);
  }

  void showNotice() async {
    if (showedNotice) return;
    showedNotice = true;
    bool stuMode = await Storage.getUserMode();
    if (stuMode) {
      int lastLogin = await Storage.get_timestamp();
      int near = DateTime
          .now()
          .millisecondsSinceEpoch + GlobalConfig.near;
      List<Homework> newHomeworks = await HomeworkClient
          .getHomeworkAfterDate(lastLogin);
      List<Homework> nearHomeworks = await HomeworkClient
          .getHomeworkNearDate(near);
      if (!newHomeworks.isEmpty) {
        _showNotification("您有新的作业了，快来看看吧～", "", "new");
      }
      if (!nearHomeworks.isEmpty) {
        _showNotification("您有作业即将截止，快来看看吧～", "", "unfinished");
      }

    }
    else {
      List<Homework> stopped = await HomeworkClient
          .getHomeworkStoppedUpload(DateTime.now().millisecondsSinceEpoch);
      if (!stopped.isEmpty) {
        _showNotification("您有发布的作业已截止提交，快来看看吧～", "", "stopped");
      }
    }


  }
}