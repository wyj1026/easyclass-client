import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class SingleImageView extends StatelessWidget {

  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: PhotoView(
              imageProvider: NetworkImage(url),
            )
        ),
        bottomNavigationBar: null
    );
  }

  SingleImageView(this.url);
}