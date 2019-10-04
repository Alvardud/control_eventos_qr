import 'package:control_eventos_qr/models/company.dart';
import 'package:control_eventos_qr/ui/pages/auth.dart';
import 'package:flutter/material.dart';
import 'package:control_eventos_qr/ui/widgets/common.dart' as common;

class ChooseUser extends StatefulWidget {
  final String forward;
  final int code;
  final String name;
  ChooseUser({this.code, this.name, this.forward});

  @override
  _ChooseUserState createState() => _ChooseUserState();
}

class _ChooseUserState extends State<ChooseUser> {
  List<Company> _companies = [
    Company(name: "JalaSoft", type: "Empresa de Software", linkLogo: null),
    Company(name: "TopTal", type: "Empresa de Software", linkLogo: null),
    Company(name: "Ultra Casas", type: "Startup Boliviana", linkLogo: null),
    Company(
        name: "Google Developers",
        type: "Comunidad de desarrolladores",
        linkLogo: null),
  ];

  @override
  void initState() {
    super.initState();
    //firebase request list
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      color: Colors.white,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _companies.length,
        itemBuilder: (context, item) {
          if (_companies.length != 0) {
            return InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Auth(
                    name: _companies[item].name,
                    forward: '\"Seleccionar ${widget.name}\"',
                  ))),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
                leading: Container(
                  height: 75.0,
                  width: 75.0,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(75.0)),
                  child: _companies[item].linkLogo != null
                      ? Image.asset("assets")
                      : Icon(Icons.account_circle,size: 50.0,),
                ),
                title: Text(
                  "${_companies[item].name}",
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text("${_companies[item].type}"),
              ),
            );
          } else {
            return common.NoItemsWidget();
          }
        },
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: common.appBarLogin(
          context: context,
          titleAppBar: "Siguiente paso",
          subtitleAppBar: "Selecciona tu ${widget.name}"),
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
