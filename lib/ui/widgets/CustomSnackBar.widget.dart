import 'package:flutter/material.dart';

Widget customSnackBar({String title}) {
  return SnackBar(
    content: Text(title),
    duration: Duration(seconds: 5),
    action: SnackBarAction(
      label: 'close',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
}
