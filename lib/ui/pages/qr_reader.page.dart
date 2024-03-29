import 'dart:convert';

import 'package:control_eventos_qr/ui/pages/logout.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_eventos_qr/data/constants.dart' as constant;
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:control_eventos_qr/ui/widgets/CustomButton.widget.dart';
import 'package:control_eventos_qr/ui/widgets/CustomSnackBar.widget.dart'
    as csb;
import 'package:control_eventos_qr/models/company.dart';
import 'package:control_eventos_qr/utils/preferences.dart' as preferences;

class QrReaderPage extends StatefulWidget {
  @override
  _QrReaderPageState createState() => _QrReaderPageState();
}

class _QrReaderPageState extends State<QrReaderPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final databaseReference = Firestore.instance;

  var qrText = "";

  var options = [];

  Company _company;
  DocumentSnapshot ticket;

  QRViewController controller;

  @override
  void initState() {
    super.initState();

    _getCompany();
  }

  void _getCompany() async {
    await preferences.getString(key: 'name').then((value) {
      setState(() {
        this._company = Company.fromJson(jsonDecode(value));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: constant.primaryColor,
          title: Text("Scan QR"),
          actions: <Widget>[
            FlatButton(
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Logout(
                            company: this._company,
                          ))),
            )
          ],
        ),
        body: Builder(
          builder: (context) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: (Stack(
              children: <Widget>[
                QRView(
                  key: qrKey,
                  onQRViewCreated: (QRViewController controller) {
                    _onQRViewCreated(controller, context);
                  },
                  overlay: QrScannerOverlayShape(
                    borderColor: constant.accentColor,
                    borderRadius: 10,
                    borderLength: 20,
                    borderWidth: 10,
                    cutOutSize: MediaQuery.of(context).size.width - 100.0,
                    overlayColor: constant.primaryColor.withOpacity(0.7),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Text(
                      'Align the QR code within \n the frame to scan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) async {
        controller.pauseCamera();

        await _searchForTicket(scanData);

        setState(() {
          qrText = scanData;
        });

        if (this.ticket == null) {
          Scaffold.of(context)
              .showSnackBar(csb.customSnackBar(title: 'Ticket no registrado!'));
          controller.resumeCamera();
          return;
        }

        switch (ticket.data['paquete']) {
          case 'Full Access':
            options = constant.FullAccess;
            break;
          case 'Saturday Access':
            options = constant.SaturdayAccess;
            break;
          case 'Friday Access':
            options = constant.FridayAccess;
            break;
        }

        if (_company.type == 'Organizer') {
          Future<void> future = showModalBottomSheet(
              context: context,
              builder: (context) => _customOrganizerBottomSheet());

          future.then((void value) => controller.resumeCamera());
        } else {
          // first parameter logistic / feria / sponsors
          if (this.ticket.data[_company.type][_company.name] == null) {
            Future<void> future = showModalBottomSheet(
                context: context, builder: (context) => _customBottomSheet());

            future.then((void value) => controller.resumeCamera());
          } else {
            Scaffold.of(context)
                .showSnackBar(csb.customSnackBar(title: 'Ticket registrado!'));
            controller.resumeCamera();
          }
        }
      },
    );
  }

  _customBottomSheet() {
    return Container(
      padding: EdgeInsets.all(12.0),
      height: MediaQuery.of(context).size.height / 3,
      color: constant.primaryColor,
      child: Column(
        children: <Widget>[
          _getGuestInfo(),
          Divider(
            color: Colors.white,
          ),
          Container(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              'Seleccione los puntos a dar al asistente:',
              style: TextStyle(
                color: constant.secundaryColor,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CustomButton(
                      icon: Icons.filter_1,
                      addFunction: _updateTicket,
                      value: 1),
                  CustomButton(
                      icon: Icons.filter_3,
                      addFunction: _updateTicket,
                      value: 3),
                  CustomButton(
                      icon: Icons.filter_5,
                      addFunction: _updateTicket,
                      value: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _customOrganizerBottomSheet() {
    return Container(
      padding: EdgeInsets.all(12.0),
      height: MediaQuery.of(context).size.height / 3,
      color: constant.primaryColor,
      child: Column(
        children: <Widget>[
          _getGuestInfo(),
          Divider(
            color: Colors.white,
          ),
          Container(
            padding: EdgeInsets.only(top: 2.0, bottom: 12.0),
            child: Text(
              'Seleccione la logistica a entregar:',
              style: TextStyle(
                color: constant.secundaryColor,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext builContext, int i) {
                  return CustomButton(
                    icon: constant.iconsSouvenir[options[i].toLowerCase()],
                    addFunction: _updateTicketOrganizer,
                    valueOrganizer: options[i],
                    isEnable: this.ticket.data['logistic'][options[i]],
                  );
                },
                itemCount: options.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getGuestInfo() {
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            ticket.data['nombre'],
            style: TextStyle(
              fontSize: 24.0,
              color: constant.secundaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 2.0,
        ),
        Container(
          child: Text(
            ticket.data['email'],
            style: TextStyle(
              fontSize: 12.0,
              color: constant.secundaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 2.0,
        ),
        Container(
          child: Text(
            'Número ticket: ${ticket.data['ticket'].toString()}',
            style: TextStyle(
              fontSize: 16.0,
              color: constant.secundaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 2.0,
        ),
        Container(
          child: Text(
            'Paquete: ${ticket.data['paquete']}',
            style: TextStyle(
              fontSize: 16.0,
              color: constant.secundaryColor,
            ),
          ),
        ),
      ],
    );
  }

  //Firebase call query
  Future<void> _searchForTicket(String scanData) async {
    QuerySnapshot _t = await databaseReference
        .collection(constant.collectionDefault)
        .where('hash', isEqualTo: scanData)
        .getDocuments();
    if (_t.documents.length == 0) {
      // Lunch qr no register
      this.ticket = null;
    }
    if (_t.documents.length == 1) {
      // Lunch qr register Assign points or meals
      this.ticket = _t.documents[0];
    }
    return Future.value(0);
  }

  _updateTicket(int value) async {
    var x = this.ticket.data;
    x[_company.type][_company.name] = value;
    await databaseReference
        .collection(constant.collectionDefault)
        .document(this.ticket.documentID)
        .updateData(x);
  }

  _updateTicketOrganizer(String organizer) async {
    var x = this.ticket.data;
    x['logistic'][organizer] = true;
    await databaseReference
        .collection(constant.collectionDefault)
        .document(this.ticket.documentID)
        .updateData(x);
  }

  @override
  void dispose() {
    this.controller?.dispose();
    super.dispose();
  }
}
