import 'package:control_eventos_qr/models/company.dart';
import 'package:flutter/material.dart';
import 'package:control_eventos_qr/ui/widgets/common.dart' as common;

class Auth extends StatelessWidget {
  final String forward;
  final Company company;
  Auth({this.company, this.forward});

  Widget _imageCompany() {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0)),
      child: company.linkLogo != null
          ? Image.asset("link")
          : Icon(
              Icons.account_circle,
              size: 150.0,
              color: Colors.grey,
            ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageCompany(),
            SizedBox(
              height: 32.0,
            ),
            Text(
              "Coloca a continuación el código de autenticación que se te proporcionó",
              style: TextStyle(color: Colors.black54, fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.all(32.0),
              height: 50.0,
              width: 200.0,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(8.0)),
            ),
            Text(
              "En caso de no tener uno, solicitalo a los organizadores del evento",
              style: TextStyle(color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            RaisedButton(
              child: Text('scan'),
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>));
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _bottom(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            child: common.ForwardBoton(
              forward: forward,
            ),
            onTap: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: common.appBarLogin(
          context: context,
          titleAppBar: "Bienvenido",
          center: true,
          subtitleAppBar: "${company.name}"),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _body(context),
          ),
          _bottom(context)
        ],
      ),
    );
  }
}
