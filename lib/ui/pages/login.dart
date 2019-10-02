import 'package:flutter/material.dart';
import 'package:control_eventos_qr/data/constants.dart' as constant;

class Login extends StatelessWidget {
  Widget _appBar(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Bienvenido",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  "Elige tu tipo de usuario",
                  style: TextStyle(color: Colors.grey[600], fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 36.0
      ),
      color: Colors.white,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: constant.userType.length,
        itemBuilder: (context, item) {
          var _values = constant.userType.values.toList();
          var _keys = constant.userType.keys.toList();
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 16.0),
            leading: Icon(constant.userTypeIcon[item]),
            title: Text(_keys[item],style: TextStyle(
              fontSize: 20.0
            ),),
            subtitle: Text(_values[item]),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }
}
