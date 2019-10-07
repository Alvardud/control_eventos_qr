import 'package:control_eventos_qr/models/company.dart';
import 'package:control_eventos_qr/ui/pages/qr_reader.page.dart';
import 'package:flutter/material.dart';
import 'package:control_eventos_qr/ui/widgets/common.dart' as common;
import 'package:control_eventos_qr/data/constants.dart' as constant;

class Auth extends StatefulWidget {
  final String forward;
  final Company company;
  final String imageUrl;
  Auth({this.company, this.forward, this.imageUrl});

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool _isVerified;
  TextEditingController _textEditingController = TextEditingController();

  void _verified(String password) {
    if (password == widget.company.pass) {
      setState(() {
        _isVerified = true;
      });
    } else {
      setState(() {
        _isVerified = false;
      });
    }
  }

  void _logIn(BuildContext context) {
    if (_isVerified) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  QrReaderPage(company: widget.company)));
    } else {
      common.showSnackBar(context: context, text: constant.errorLoginText);
    }
  }

  Widget _imageCompany() {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0)),
      child: widget.imageUrl != null
          ? Image.asset(widget.imageUrl)
          : Icon(
              Icons.account_circle,
              size: 150.0,
              color: Colors.grey,
            ),
    );
  }

  Widget _passwordBox(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(32.0),
      height: 50.0,
      width: 200.0,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(8.0)),
      child: TextField(
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent))),
        textAlign: TextAlign.center,
        cursorColor: Colors.black,
        style: TextStyle(
            color: _isVerified ? Colors.green : Colors.red, fontSize: 24.0),
        controller: _textEditingController,
        onChanged: (String str) => _verified(str),
        onSubmitted: (str) {
          Future.delayed(Duration(milliseconds: 200), () => _logIn(context));
        },
      ),
    );
  }

  Widget _sendPasswordBoton(BuildContext context) {
    return InkWell(
      onTap: () => _logIn(context),
      child: Container(
        margin: EdgeInsets.all(16.0),
        height: 50.0,
        width: 150.0,
        decoration: BoxDecoration(
            color: constant.secundaryColor,
            borderRadius: BorderRadius.circular(50.0)),
        child: Center(
          child: Text(
            "INGRESAR",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
      color: Colors.white,
      child: SingleChildScrollView(
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
            _passwordBox(context),
            Text(
              "En caso de no tener uno, solicítalo a los organizadores del evento",
              style: TextStyle(color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            _sendPasswordBoton(context)
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
              forward: widget.forward,
            ),
            onTap: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _isVerified = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: common.appBarLogin(
            context: context,
            titleAppBar: "Bienvenido",
            center: true,
            subtitleAppBar: "${widget.company.name}"),
        body: Builder(
          builder: (context) => Column(
            children: <Widget>[
              Expanded(
                child: _body(context),
              ),
              _bottom(context)
            ],
          ),
        ),
      ),
    );
  }
}
