import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_class/models/class.dart';
import 'package:easy_class/util/common.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClassItem extends StatefulWidget {
  ClassItem(this.clas) : super(key: ValueKey(clas.id));

  final Class clas;

  @override
  _ClassItemState createState() => _ClassItemState(this.clas);
}

class _ClassItemState extends State<ClassItem> {

  _ClassItemState(Class clas) {
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 10),
      child: Material(
          color: Colors.white,
          shape: BorderDirectional(

            
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: .5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  dense: true,
                  leading: gmAvatar(
                    widget.clas.avatar_url,
                    width: 40.0,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(
                    widget.clas.classname,
                    textScaleFactor: 1.1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    getTimeDiff(widget.clas.class_duration * 1000),
                    textScaleFactor: 0.9,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
                  child: Text(
                    widget.clas.classname,
                  ),
                ),
//                Positioned(
//                  top: 150,
//                  child:
//                  SizedBox(
//                    width: MediaQuery.of(context).size.width,
//                    height: MediaQuery.of(context).size.width,
//                    child: buildGridView(),
//                  ),
//                ),

                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: _buildBottom(),
                )
              ],
            ),
          )),
    );
    //return Text(widget.rec.content);
  }

  Widget _buildBottom() {
    const paddingWidth = 10;
    return IconTheme(
      data: IconThemeData(
        color: Colors.grey,
        size: 20,
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.grey, fontSize: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(builder: (context) {
            var children = <Widget>[
              IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.red),
                onPressed: null,
              ),
              Text(" ".padRight(paddingWidth)),
              Icon(Icons.chat_bubble_outline),
              Text(" " +
                  widget.clas.class_duration.toString().padRight(paddingWidth)),
            ];

            return Row(children: children);
          }),
        ),
      ),
    );
  }
}
