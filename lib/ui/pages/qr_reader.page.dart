import 'dart:convert';

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
        print(value);
        this._company = Company.fromJson(jsonDecode(value));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('hola hola');
    return WillPopScope(
      onWillPop: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: constant.primaryColor,
          title: Text("Scan QR"),
          actions: <Widget>[
            FlatButton(
              child: Icon(
                Icons.settings,
                color: Colors.white70,
              ),
              onPressed: () {},
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
                      borderColor: Colors.red,
                      borderRadius: 10,
                      borderLength: 20,
                      borderWidth: 5,
                      cutOutSize: 200,
                      overlayColor: Color.fromRGBO(0, 0, 0, 30)),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Align the QR code within \n the frame to scan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
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

        if (_company.type == 'Organizer') {
        } else {
          // first parameter logistic / feria / sponsors
          // second parameter almuerzo / startup_1 / jala
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
      height: 150.0,
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CustomButton(
              icon: Icons.filter_1, addFunction: _updateTicket, value: 1),
          CustomButton(
              icon: Icons.filter_3, addFunction: _updateTicket, value: 3),
          CustomButton(
              icon: Icons.filter_5, addFunction: _updateTicket, value: 5),
        ],
      ),
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

  @override
  void dispose() {
    this.controller?.dispose();
    super.dispose();
  }
}
