import 'package:flutter/material.dart';

import 'package:control_eventos_qr/data/constants.dart' as constant;
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  var qrText = "";

  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
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
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    //this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        controller.pauseCamera();
        print(scanData);
        setState(() {
          qrText = scanData;
        });
        Future<void> future = showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            height: 50.0,
            width: 50.0,
            color: Colors.red,
          ),
        );

        future.then((void value) => controller.resumeCamera());
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
