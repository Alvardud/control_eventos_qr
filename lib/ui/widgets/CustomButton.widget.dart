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
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: RaisedButton(
          child: Column(
            children: <Widget>[
              Icon(
                this.icon,
                size: this.size,
                color: constant.secundaryColor,
              ),
              //Text(this.valueOrganizer)
            ],
          ),
          onPressed: () {
            addFunction(this.value);
            Navigator.pop(context);
          },
        ),
      );
    Widget buttonContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          this.icon,
          size: this.size,
          color: constant.secundaryColor,
        ),
        Text(this.valueOrganizer)
      ],
    );
    if (isEnable) {
      buttonContent = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Icon(
                this.icon,
                size: this.size,
                color: constant.tertiaryColor,
              ),
              Icon(
                Icons.check,
                size: this.size,
                color: Colors.green[800],
              ),
            ],
          ),
          Text(this.valueOrganizer)
        ],
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Center(
        child: RaisedButton(
          disabledColor: Colors.amber,
          onPressed: isEnable
              ? null
              : () {
                  addFunction(this.valueOrganizer);
                  Navigator.pop(context);
                },
          child: Container(child: buttonContent),
        ),
      ),
    );
  }
}
