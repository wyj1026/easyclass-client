import 'package:easy_class/index/index.dart';
import 'package:easy_class/models/index.dart';
import 'package:easy_class/network/login.dart';
import 'package:easy_class/util/config.dart';
import 'package:easy_class/util/storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen1 extends StatelessWidget {

  final Color primaryColor;
  final Color backgroundColor;
  final AssetImage backgroundImage;
  TextEditingController _emailController = new TextEditingController(text: "test@qq.com");
  TextEditingController _pwdController = new TextEditingController(text: "test");

  LoginScreen1({
    Key key,
    this.primaryColor, this.backgroundColor, this.backgroundImage
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: this.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new ClipPath(
            clipper: MyClipper(),
            child: Container(
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: this.backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 150.0, bottom: 100.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "易则课程",
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: this.primaryColor),
                  ),
                  Text(
                    "书到用时方恨少",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: this.primaryColor),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              "邮箱",
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                new Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 30.0,
                  width: 1.0,
                  color: Colors.grey.withOpacity(0.5),
                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                ),
                new Expanded(
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              "密码",
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: <Widget>[
                new Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Icon(
                    Icons.lock_open,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 30.0,
                  width: 1.0,
                  color: Colors.grey.withOpacity(0.5),
                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                ),
                new Expanded(
                  child: TextField(
                    controller: _pwdController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    splashColor: this.primaryColor,
                    color: this.primaryColor,
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "登陆/注册",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        new Expanded(
                          child: Container(),
                        ),
                        new Transform.translate(
                          offset: Offset(15.0, 0.0),
                          child: new Container(
                            padding: const EdgeInsets.all(5.0),
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(28.0)),
                              splashColor: Colors.white,
                              color: Colors.white,
                              child: Icon(
                                Icons.arrow_forward,
                                color: this.primaryColor,
                              ),
                              onPressed: () async {
                                User usr;
                                usr = await LoginClient.tryLogin(_emailController.text, _pwdController.text);
                                if (usr == null) {
                                  Fluttertoast.showToast(msg: "为您创建账号～");
                                  usr = await LoginClient.signUp(_emailController.text, _pwdController.text);
                                  Fluttertoast.showToast(msg: usr.id.toString());
                                }
                                Storage.save(usr);
                                GlobalConfig.user = usr;
                                Navigator.pushAndRemoveUntil(context,
                                  new MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return new Index();
                                    },
                                  ), (route) => route == null);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
          ),
//          Container(
//            margin: const EdgeInsets.only(top: 10.0),
//            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//            child: new Row(
//              children: <Widget>[
//                new Expanded(
//                  child: FlatButton(
//                    shape: new RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(30.0)),
//                    splashColor: Color(0xFF3B5998),
//                    color: Color(0xff3B5998),
//                    child: new Row(
//                      children: <Widget>[
//                        new Padding(
//                          padding: const EdgeInsets.only(left: 20.0),
//                          child: Text(
//                            "LOGIN WITH FACEBOOK",
//                            style: TextStyle(color: Colors.white),
//                          ),
//                        ),
//                        new Expanded(
//                          child: Container(),
//                        ),
//                        new Transform.translate(
//                          offset: Offset(15.0, 0.0),
//                          child: new Container(
//                            padding: const EdgeInsets.all(5.0),
//                            child: FlatButton(
//                              shape: new RoundedRectangleBorder(
//                                  borderRadius:
//                                  new BorderRadius.circular(28.0)),
//                              splashColor: Colors.white,
//                              color: Colors.white,
//                              child: Icon(
//                                const IconData(0xea90, fontFamily: 'icomoon'),
//                                color: Color(0xff3b5998),
//                              ),
//                              onPressed: () => {},
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//                    onPressed: () => {},
//                  ),
//                ),
//              ],
//            ),
//          ),


//          Container(
//            margin: const EdgeInsets.only(top: 20.0),
//            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//            child: new Row(
//              children: <Widget>[
//                new Expanded(
//                  child: FlatButton(
//                    shape: new RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(30.0)),
//                    color: Colors.transparent,
//                    child: Container(
//                      padding: const EdgeInsets.only(left: 20.0),
//                      alignment: Alignment.center,
//                      child: Text(
//                        "还没有账号？",
//                        style: TextStyle(color: this.primaryColor),
//                      ),
//                    ),
//                    onPressed: () => {},
//                  ),
//                ),
//              ],
//            ),
//          ),


        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
