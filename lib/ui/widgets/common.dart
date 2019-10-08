import 'package:flutter/material.dart';
import 'package:control_eventos_qr/data/constants.dart' as constant;

Widget appBarLogin({
  BuildContext context,
  String titleAppBar,
  String subtitleAppBar,
  bool center = false,
  bool leading = false,
}) {
  return AppBar(
      automaticallyImplyLeading: false,
      brightness: Brightness.dark,
      backgroundColor: constant.primaryColor,
      elevation: 0.0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(36.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: <Widget>[
                leading
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      )
                    : Container(),
                leading
                    ? SizedBox(
                        width: 32.0,
                      )
                    : Container(),
                Column(
                  crossAxisAlignment: !center
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      titleAppBar,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    subtitleAppBar != null
                        ? Text(
                            subtitleAppBar,
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 18.0),
                          )
                        : SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ));
}

class NoItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text("No hay elementos que mostrar")],
        ),
      ),
    );
  }
}

class ForwardBoton extends StatelessWidget {
  final String forward;
  ForwardBoton({this.forward});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            "Volver a $forward",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

void showSnackBar({BuildContext context, String text}) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(text, style: TextStyle(color: Colors.white)),
  ));
}

Widget imageCompany({String imageUrl}) {
  return Container(
    width: 150.0,
    height: 150.0,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0)),
    child: imageUrl != null
        ? Image.asset(imageUrl)
        : Icon(
            Icons.account_circle,
            size: 150.0,
            color: Colors.grey,
          ),
  );
}
