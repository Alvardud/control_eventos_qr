import 'package:control_eventos_qr/models/company.dart';
import 'package:control_eventos_qr/ui/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:control_eventos_qr/ui/widgets/common.dart' as common;
import 'package:control_eventos_qr/utils/preferences.dart' as preferences;
import 'package:control_eventos_qr/data/constants.dart' as constant;

class Settings extends StatefulWidget {
  final Company company;
  Settings({this.company});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String imageUrl;

  Widget _footer() {
    return Container(
      height: 75.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Desarrollado por', style: TextStyle(color: Colors.white)),
            SizedBox(width: 32.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: Image.asset(
                  'assets/images/gdg.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logOutBoton() {
    return SizedBox(
      height: 100.0,
      child: Center(
          child: RaisedButton(
        onPressed: () => _logOut(),
        child: Text('LogOut'),
      )),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: common.imageCompany(
              imageUrl: imageUrl,
            ),
          ),
          Expanded(child: SizedBox()),
          _logOutBoton(),
          _footer()
        ],
      ),
    );
  }

  void _logOut() {
    preferences.addBool(key: 'login', value: false);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  void _getImageUrl() {
    preferences.getString(key: 'link').then((value) {
      setState(() {
        imageUrl = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: common.appBarLogin(
        leading: true,
        center: true,
        titleAppBar: 'Configuración',
        subtitleAppBar: "${widget.company.name}",
        context: context,
      ),
      backgroundColor: constant.primaryColor,
      body: _body(context),
    );
  }
}
