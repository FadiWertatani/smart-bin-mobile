import 'package:flutter/cupertino.dart';

//push without going back function
Future noBackPush({
  required BuildContext context,
  required Widget direction,
}) =>
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => direction,
      ),
          (Route<dynamic> route) => false,
    );

//normal push
Future normalPush({
  required BuildContext context,
  required Widget direction,
}) =>
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => direction,
      ),
    );