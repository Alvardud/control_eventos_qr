import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final int value;
  final String valueOrganizer;
  final Function addFunction;
  final double size;
  final bool isEnable;

  CustomButton({
    this.icon,
    this.addFunction,
    this.value = 0,
    this.size = 32,
    this.valueOrganizer,
    this.isEnable = false,
  });

  @override
  Widget build(BuildContext context) {
    if (value != 0)
      return FlatButton(
        child: Icon(this.icon, size: this.size),
        onPressed: () {
          addFunction(this.value);
          Navigator.pop(context);
        },
      );
    return FlatButton(
      child: Icon(this.icon, size: this.size),
      onPressed: isEnable
          ? null
          : () {
              addFunction(this.valueOrganizer);
              Navigator.pop(context);
            },
    );
  }
}
