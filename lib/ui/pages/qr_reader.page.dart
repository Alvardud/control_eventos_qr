import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:control_eventos_qr/data/constants.dart' as constant;
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrReaderPage extends StatefulWidget {
  @override
  _QrReaderPageState createState() => _QrReaderPageState();
}

class _QrReaderPageState extends State<QrReaderPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final databaseReference = Firestore.instance;

  var qrText = "";
  var ticket;

  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: constant.primaryColor,
        title: Text("Demo"),
      ),
      body: Builder(
        builder: (context) => (Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: (QRViewController controller) {
                  _onQRViewCreated(controller, context);
                },
                overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 20,
                    borderWidth: 5,
                    cutOutSize: 250,
                    overlayColor: Color.fromRGBO(0, 0, 0, 80)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text('Scan result: $qrText'),
              ),
            )
          ],
        )),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        controller.pauseCamera();

        _searchForTicket(scanData);

        setState(() {
          qrText = scanData;
        });

        if (this.ticket != null) {
          print(this.ticket['values2']['jala']);

          Future<void> future = showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              height: 50.0,
              width: 50.0,
              color: Colors.red,
              child: Text(scanData),
            ),
          );

          future.then((void value) => controller.resumeCamera());
        } else {
          final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
          controller.resumeCamera();
        }
      },
    );
  }

  @override
  void dispose() {
    this.controller?.dispose();
    super.dispose();
  }

  _searchForTicket(String scanData) {
    databaseReference
        .collection('tickets')
        .where('ticket', isEqualTo: scanData)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      if (snapshot.documents.length == 0) {
        // Lunch qr no register
        this.ticket = null;
      }
      if (snapshot.documents.length == 1) {
        // Lunch qr register Assign points or meals
        this.ticket = snapshot.documents[0].data;
        print(this.ticket);
      }
    });
  }
}
