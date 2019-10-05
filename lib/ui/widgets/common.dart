import 'package:flutter/material.dart';

Widget appBarLogin(
    {BuildContext context,
    String titleAppBar,
    String subtitleAppBar,
    bool center = false}) {
  return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      elevation: 0.0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(36.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: !center
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  titleAppBar,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0),
                ),
                SizedBox(
                  height: 4.0,
                ),
                subtitleAppBar != null
                    ? Text(
                        subtitleAppBar,
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 18.0),
                      )
                    : SizedBox(),
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
            color: Colors.grey[600],
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            "Volver a $forward",
            style: TextStyle(color: Colors.grey[600]),
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


