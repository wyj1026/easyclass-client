import 'dart:io';

import 'package:easy_class/models/class.dart';
import 'package:easy_class/models/class_role.dart';
import 'package:easy_class/network/class.dart';
import 'package:easy_class/network/file.dart';
import 'package:easy_class/network/role.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class NewClass extends StatefulWidget {
  @override
  State createState() {
    return new NewClassState();
  }
}
class NewClassState extends State<NewClass> {

  TextEditingController _name = new TextEditingController();
  TextEditingController _date = new TextEditingController();
  TextEditingController _start = new TextEditingController();
  TextEditingController _duration = new TextEditingController();
  TextEditingController _description = new TextEditingController();
  TextEditingController _school = new TextEditingController();
  String avatar_url;
  File _image;
  TextStyle titleStyle = new TextStyle(fontSize: 20);
  TextStyle valueStyle = new TextStyle(fontSize: 15);
  DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                Class aclass = new Class();
                aclass.class_date = _date.text;
                aclass.classname = _name.text;
                aclass.gmt_start = selectedDate.millisecondsSinceEpoch;
                aclass.class_duration = _duration.text;
                aclass.description = _description.text;
                aclass.avatar_url = avatar_url;
                aclass.school = _school.text;
                Class addClass = await ClassClient.addClass(aclass);

                ClassRole classRole = new ClassRole();
                classRole.classname = aclass.classname;
                classRole.user_id = GlobalConfig.user.id;
                classRole.class_id = addClass.id;
                classRole.username = GlobalConfig.user.nickname;
                classRole.role = "teacher";
                classRole.school = aclass.school;
                RoleClient.enterClass(classRole);
                Navigator.of(context).pop();
              }
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: new Container(
          color: GlobalConfig.cardBackgroundColor,
          margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
          padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: new Container(
                    margin: const EdgeInsets.only(bottom: 6.0),
                    child: new Text("课程名", style: titleStyle,)
                ),
                trailing: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(_name.text, style: valueStyle,),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () async {
                          await _showDialog(_name, TextInputType.text);
                          setState(() {});
                        }
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1.0,),
              ListTile(
                leading: new Container(
                    margin: const EdgeInsets.only(bottom: 6.0),
                    child: new Text("课程介绍图", style: titleStyle,)
                ),
                trailing: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _image == null? new Text(""):
                    new ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.file(_image),
                    ),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () async {
                          _image = await ImagePicker.pickImage(source: ImageSource.gallery);
                          avatar_url = await FileClient.send(_image);
                          setState(() {});
                        }
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1.0,),
              ListTile(
                leading: new Container(
                    margin: const EdgeInsets.only(bottom: 6.0),
                    child: new Text("上课时间", style: titleStyle,)
                ),
                trailing: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(_date.text, style: valueStyle,),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () async {
                          await _showDialog(_date, TextInputType.text);
                          setState(() {});
                        }
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1.0,),
              ListTile(
                leading: new Container(
                    margin: const EdgeInsets.only(bottom: 6.0),
                    child: new Text("学校", style: titleStyle,)
                ),
                trailing: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(_school.text, style: valueStyle,),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () async {
                          await _showDialog(_school, TextInputType.text);
                          setState(() {});
                        }
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1.0,),
              ListTile(
                leading: new Container(
                    margin: const EdgeInsets.only(bottom: 6.0),
                    child: new Text("开课时间", style: titleStyle,)
                ),
                trailing: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(_start.text, style: valueStyle,),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () async {
                          var date = DateTime.now();
                          selectedDate = await showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: date.subtract(Duration(days: 60)),
                            lastDate: date.add( //未来30天可选
                              Duration(days: 60),
                            ),
                          );
                          DateFormat format = new DateFormat("yyyy-MM-dd hh:mm");
                          _start.text = format.format(selectedDate).toString();
                          setState(() {

                          });
//                          await _showDialog(_start, TextInputType.text);
                        }
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1.0,),
              ListTile(
                leading: new Container(
                    margin: const EdgeInsets.only(bottom: 6.0),
                    child: new Text("课程周数", style: titleStyle,)
                ),
                trailing: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(_duration.text, style: valueStyle,),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () async {
                          await _showDialog(_duration, TextInputType.number);
                          setState(() {});
                        }
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1.0,),
              ListTile(
                leading: new Container(
                    margin: const EdgeInsets.only(bottom: 6.0),
                    child: new Text("课程描述", style: titleStyle,)
                ),
                trailing: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(_description.text, style: valueStyle,),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () async {
                          await _showDialog(_description, TextInputType.text);
                          setState(() {});
                        }
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
      ),
    );
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
