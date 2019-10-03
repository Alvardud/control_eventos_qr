import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final Function addFunction;

  CustomButton({this.icon, this.addFunction});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Icon(this.icon, size: 32.0),
      onPressed: () {
        addFunction();
      },
    );
  }
}
