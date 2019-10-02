import 'package:flutter/material.dart';
import 'package:control_eventos_qr/data/constants.dart' as constant;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: constant.primaryColor,
        accentColor: constant.accentColor,
        primarySwatch: constant.primaryColor,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Demo"),
        ),
        body: Container(),
      ),
    );
  }
}
