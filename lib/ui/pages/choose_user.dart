import 'package:control_eventos_qr/models/company.dart';
import 'package:control_eventos_qr/ui/pages/auth.dart';
import 'package:flutter/material.dart';
import 'package:control_eventos_qr/ui/widgets/common.dart' as common;
import 'package:control_eventos_qr/utils/firebase_requests.dart' as firebase;
import 'package:control_eventos_qr/data/constants.dart' as constant;

class ChooseUser extends StatefulWidget {
  final String forward;
  final int code;
  final String name;
  ChooseUser({this.code, this.name, this.forward});

  @override
  _ChooseUserState createState() => _ChooseUserState();
}

class _ChooseUserState extends State<ChooseUser> {
  List<Company> _companies = [];

  @override
  void initState() {
    super.initState();
  }

  Widget _elementList({int item, String urlImage}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      leading: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50.0)),
        child: urlImage != null
            ? Image.asset(
                urlImage,
                fit: BoxFit.contain,
              )
            : Icon(
                Icons.account_circle,
                size: 50.0,
              ),
      ),
      title: Text(
        "${_companies[item].name}",
        style: TextStyle(fontSize: 20.0),
      ),
      subtitle: Text("${_companies[item].desc}"),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 36.0, left: 8.0, right: 8.0),
      color: Colors.white,
      child: FutureBuilder(
        future: firebase.getCompanies("${constant.codeUser[widget.code]}"),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (!snap.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snap.data.length,
            itemBuilder: (context, item) {
              _companies = snap.data;
              var image = constant.urlImage[widget.code - 1].values.toList();
              if (_companies.length != 0) {
                return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Auth(
                                  imageUrl: image[item],
                                  company: _companies[item],
                                  forward: '\"Seleccionar ${widget.name}\"',
                                ))),
                    child: _elementList(item: item, urlImage: image[item]));
              } else {
                return common.NoItemsWidget();
              }
            },
          );
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
