import 'dart:async';

import 'package:flutter/material.dart';

class AppNavigators {
  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  static pushNamed(BuildContext context, String page) {
    Navigator.pushNamed(context, page);
  }

  static pushNamedReplace(BuildContext context, String page) {
    Navigator.pushReplacementNamed(context, page);
  }

  static removeAll(BuildContext context, String page) {
    Navigator.popUntil(
      context,
      (route) => route.isFirst,
    );
  }

  static replacePageTime(BuildContext context, String page, int? seconds) {
    Timer(
      Duration(seconds: seconds ?? 2),
      () {
        pushNamedReplace(context, page);
      },
    );
  }
}
