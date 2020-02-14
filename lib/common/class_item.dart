import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_class/util/common.dart';
import 'package:easy_class/util/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClassItem extends StatefulWidget {
  ClassItem(this.rec) : super(key: ValueKey(rec.id));

  final Rec rec;

  @override
  _ClassItemState createState() => _ClassItemState(this.rec);
}

class _ClassItemState extends State<ClassItem> {
  List<String> images = new List();
  _RecordItemState(Rec rec) {
    if (rec.pics != null && rec.pics != "") {
      images.addAll(rec.pics.split("|"));
    }
  }

  Widget buildGridView() {
    if (images.length == 0) {
      return SizedBox(
        height: 1,
      );
    }
    else if (images.length == 1) {
      return Image.network(GlobalConfig.serverUrl + "pics/" + images[0],  width: MediaQuery.of(context).size.width);
    }

    var height;
    if (images.length <= 3) {
      height = MediaQuery.of(context).size.width / 3;
    }
    else if (images.length <= 6){
      height = MediaQuery.of(context).size.width / 3 * 2;
    }
    else {
      height = MediaQuery.of(context).size.width;
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          String asset = GlobalConfig.serverUrl + "pics/" + images[index];
          return CachedNetworkImage(
            imageUrl: asset,
            placeholder: (context, url) =>null,
            errorWidget: (context, url, error) =>null,
          );
        }),
      ),
    );
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
                    widget.rec.avatar_url,
                    width: 40.0,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(
                    widget.rec.by,
                    textScaleFactor: 1.1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    getTimeDiff(int.parse(widget.rec.created_at) * 1000),
                    textScaleFactor: 0.9,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
                  child: Text(
                    widget.rec.content,
                  ),
                ),
                  buildGridView(),
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
                  widget.rec.comment_count.toString().padRight(paddingWidth)),
            ];

            return Row(children: children);
          }),
        ),
      ),
    );
  }
}
