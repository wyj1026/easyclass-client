import 'package:easy_class/home/home.dart';
import 'package:easy_class/index/index.dart';
import 'package:easy_class/my/my_page.dart';
import 'package:easy_class/splash/splash_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/login_screen.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
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

  void initState(){
    super.initState();
    _validateLogin();
  }

  @override
  Widget build(BuildContext context){
    if(loginState == 0){
      return SplashWidget();
    }else{
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
    Future<dynamic> future = Future(()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.containsKey("isLogin");
    });
    future.then((val){
      if(val == true){
        setState(() {
          loginState = 0;
        });
      }else{
        setState(() {
          loginState = 1;
        });
      }
    }).catchError((e){
      print(e.toString());
      print("catchError");
    });

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
