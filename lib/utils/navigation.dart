import 'package:flutter/cupertino.dart';

void toScreen(BuildContext context, Widget newScreen) {
  Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) => newScreen));
}

void back(BuildContext context) {
  Navigator.pop(context);
}
