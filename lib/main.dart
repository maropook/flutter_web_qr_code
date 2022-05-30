import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_qr_code/error.dart';
import 'package:flutter_web_qr_code/qr_scan.dart';
import 'package:flutter_web_qr_code/qr_detail.dart';

void main() {
  runApp(
    ProviderScope(
      child: QRApp(),
    ),
  );
}

class QRApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => QRScanPage(),
        '/qr_detail': (BuildContext context) => QRDetailPage(),
        '/error': (BuildContext context) => ErrorPage(),
      },
      title: 'QRコード',
    );
  }
}
