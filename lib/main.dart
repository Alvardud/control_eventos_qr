import 'package:control_eventos_qr/ui/pages/qr_reader.page.dart';
import 'package:flutter/material.dart';
import 'package:control_eventos_qr/ui/pages/login.dart';
import 'package:flutter/services.dart';
import 'package:control_eventos_qr/utils/preferences.dart' as preferences;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  bool _isLogin = await preferences.getBool(key: 'login');
  runApp(MyApp(isLogin: _isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  MyApp({this.isLogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: isLogin ? QrReaderPage() : Login(),
    );
  }
}
