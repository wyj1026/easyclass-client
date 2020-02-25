import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

Widget gmAvatar(String url, {
  double width = 30,
  double height,
  BoxFit fit,
  BorderRadius borderRadius,
}) {
  var placeholder = Image.asset(
      "images/a.jpg", //头像占位图，加载过程中显示
      width: width,
      height: height
  );

  return ClipRRect(
    borderRadius: borderRadius ?? BorderRadius.circular(2),
    child: CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>null,
      errorWidget: (context, url, error) =>null,
    ),
  );
}

String getTimeDiff(int timeStamp) {
  var now = new DateTime.now();
  var dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  var diff = now.difference(dateTime);
  var format = new DateFormat('MM月dd日HH:mm');

  if (diff.inDays > 0) {
    return format.format(dateTime);
  }
  else if (diff.inHours > 0) {
    return diff.inHours.toString() + '小时前';
  }
  else if (diff.inMinutes > 0) {
    return diff.inMinutes.toString() + '分钟前';
  }
  else {
    return '刚刚';
  }
}

Widget getPhotoViewFromAsset(String name) {
  Container(
      child: PhotoView(
        imageProvider: AssetImage("assets/" + name),
      )
  );
}

Widget getPhotoViewFromNet(String url) {
  Container(
      child: PhotoView(
        imageProvider: NetworkImage(url),
      )
  );
}