import 'package:flutter/material.dart';
import 'package:control_eventos_qr/data/constants.dart' as constant;
import 'package:control_eventos_qr/ui/pages/auth.dart';
import 'package:control_eventos_qr/ui/widgets/common.dart' as common;
import 'package:control_eventos_qr/ui/pages/choose_user.dart';
import 'package:flutter/services.dart';

class Login extends StatelessWidget {
  Widget _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      color: Colors.white,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: constant.userType.length,
        itemBuilder: (context, item) {
          var _values = constant.keyNameUser.values.toList();
          var _keys = constant.keyNameUser.keys.toList();
          var _icons = constant.iconsUser.values.toList();
          return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => item != 0
                        ? ChooseUser(
                            code: item,
                            name: _values[item],
                            forward: '\"Seleccionar Usuario\"',
                          )
                        : Auth(
                            imageUrl: "assets/images/gdg.png",
                            company: constant.companyOrganizer,
                            forward: '\"Seleccionar Usuario\"',
                          ))),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              leading: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                    color: constant.colorsDefault[item % 6],
                    borderRadius: BorderRadius.circular(25.0)),
                child: Icon(_icons[item], size: 28.0, color: Colors.black),
              ),
              title: Text(
                _keys[item],
                style: TextStyle(fontSize: 20.0),
              ),
              subtitle: Text(constant.userType[item]),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return;    //verfied
      },
      child: Scaffold(
        appBar: common.appBarLogin(
            context: context,
            titleAppBar: "Bienvenido",
            subtitleAppBar: "Elige tu tipo de usuario"),
        body: _body(context),
      ),
    );
  }
}
