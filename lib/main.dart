import 'package:flutter/material.dart';
import 'package:control_eventos_qr/data/constants.dart' as constant;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: constant.primaryColor,
          title: Text("Demo"),
        ),
        body: Container(),
      ),
    );
  }
}
