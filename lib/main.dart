import 'package:easy_class/splash/splash_widget.dart';
import 'package:easy_class/util/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/login_screen.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async {
//  SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: StartAppWidget(),
        ),
      ),
    );
  }
}

class StartAppWidget extends StatefulWidget {

  @override
  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartAppWidget>{

  var loginState = 0;

  @override
  void initState() {
    _validateLogin();
    super.initState();
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
      debugPrint('notification payload: ' + payload);
    }
//    await Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => SecondScreen(payload)),
//    );
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

  Future _showNotification() async {
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
        0, 'title', 'content', platformChannelSpecifics,
        payload: 'complete');
  }

  @override
  Widget build(BuildContext context){
    if(loginState == 0){
      _showNotification();
      return SplashWidget();
    } else{
      return Container(
        child: LoginScreen1(
          primaryColor: Color(0xFF4aa0d5),
          backgroundColor: Colors.white,
          backgroundImage: new AssetImage("assets/images/full-bloom.png"),
        )
      );
    }
  }

  Future _validateLogin() async{
    if (await Storage.is_login()) {
      setState(() {
        loginState = 0;
      });
    }
    else {
      setState(() {
        loginState = 1;
      });
    }
  }

}

///这个组件用来重新加载整个child Widget的。当我们需要重启APP的时候，可以使用这个方案
///https://stackoverflow.com/questions/50115311/flutter-how-to-force-an-application-restart-in-production-mode
class RestartWidget extends StatefulWidget {
  final Widget child;

  RestartWidget({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  static restartApp(BuildContext context) {
    final _RestartWidgetState state =
    context.ancestorStateOfType(const TypeMatcher<_RestartWidgetState>());
    state.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }
}
