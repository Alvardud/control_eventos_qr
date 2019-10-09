import 'package:flutter/material.dart';
import 'package:control_eventos_qr/data/constants.dart' as constant;

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
        child: Icon(
          this.icon,
          size: this.size,
          color: constant.secundaryColor,
        ),
        onPressed: () {
          addFunction(this.value);
          Navigator.pop(context);
        },
      );
    Widget buttonContent = Icon(
      this.icon,
      size: this.size,
      color: constant.secundaryColor,
    );
    if (isEnable) {
      buttonContent = Stack(
        children: <Widget>[
          Icon(
            this.icon,
            size: this.size,
            color: constant.tertiaryColor,
          ),
          Icon(
            Icons.check,
            size: this.size,
            color: Colors.green[400],
          ),
        ],
      );
    }
    return FlatButton(
      child: buttonContent,
      onPressed: isEnable
          ? null
          : () {
              addFunction(this.valueOrganizer);
              Navigator.pop(context);
            },
    );
  }
}
