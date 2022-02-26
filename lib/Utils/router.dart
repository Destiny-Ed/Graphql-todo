import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageNavigator {
  PageNavigator({this.ctx});
  BuildContext? ctx;


  ///Navigator to next page
  void nextPage({Widget? page}) {
    Navigator.push(ctx!, CupertinoPageRoute(builder: ((context) => page!)));
  }
}
