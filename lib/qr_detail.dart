import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_qr_code/qr_scan.dart';
import 'package:flutter_web_qr_code/qr_content.dart';

class QRDetailPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    QRContent qrContents = ref.watch(qrContentsProvider.state).state;

    return Scaffold(
        appBar: AppBar(
          title: const Text("QRコード詳細"),
        ), //AppBar
        body: Center(
          child: Text('${qrContents.id}:${qrContents.name}',
              style: const TextStyle(fontSize: 30)),
        ));
  }
}
