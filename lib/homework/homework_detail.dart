import 'package:easy_class/homework/homework_item.dart';
import 'package:easy_class/models/class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeworkDetail extends StatefulWidget {
  HomeworkDetail({Key key, @required this.rec}) : super(key: key);

  final Class rec;

  @override
  _HomeworkDetailState createState() {
    return new _HomeworkDetailState();
  }


}

class _HomeworkDetailState extends State<HomeworkDetail> {
  TextEditingController _commentController = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body:
      ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: <Widget>[
                    HomeworkItem(widget.rec),
                  ],
                )
            ),
            //buildGridView(),
            // Transform.translate(offset: Offset(0.0,   MediaQuery.of(context).viewInsets.bottom),
//            Positioned(
//                bottom: 0.0,
//                left: 0.0,
//                right: 0.0,
//                child: BottomAppBar(
//                    color: Colors.white,
//                    child: Row(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: [
//                          Flexible(
//                            child: new TextField(
//                              style: Theme.of(context).textTheme.body1,
//                              decoration: InputDecoration(
//                                border: InputBorder.none
//                              ),
//                              focusNode: focusNode,
//                              onSubmitted: (value) {
//
//
//                              },
//                              textInputAction: TextInputAction.done,
//                              controller: _commentController,
//                            ),
//                          ),
//                          IconButton(icon: Icon(Icons.insert_emoticon)),
//                          IconButton(icon: Icon(Icons.send), onPressed: () => {
//                            FocusScope.of(context).requestFocus(FocusNode()),
////                            this.render(_commentController.text),
////                            _commentController.text = ""
//                          },),
//                        ])))
          ],
        ),
      ),
      bottomNavigationBar: null,
    );
  }

//  void render(String text) {
//    Map newComment = new Map();
//    newComment["avatar_url"] = Main.avatarUrl;
//    newComment["by"] = Main.user_name;
//    newComment["content"] = text;
//    newComment["timestamp"] = DateTime.now().millisecondsSinceEpoch.toString();
//    widget.rec.comments.add(newComment);
//    widget.rec.comment_count++;
//    add_comment(widget.rec.id, Main.user_name, Main.avatarUrl, text, newComment["timestamp"]);
//  }
}