import 'package:ai_barcode/ai_barcode.dart';
import 'package:flutter/material.dart';

//ai_barcodeのexampleを参考に最小化したコードスキャンカメラウィジェット
class BarcodeScannerWidget extends StatefulWidget {
  BarcodeScannerWidget(this.resultCallback);
  Function(String result) resultCallback;
  @override
  _BarcodeScannerWidgetState createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  late ScannerController _scannerController;

  @override
  void initState() {
    super.initState();

    _scannerController = ScannerController(scannerResult: (result) {
      widget.resultCallback(result);
    }, scannerViewCreated: () {
      _scannerController.startCamera();
      _scannerController.startCameraPreview();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scannerController.stopCameraPreview();
    _scannerController.stopCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: scanCamera(),
        )
      ],
    );
  }

  Widget scanCamera() {
    return PlatformAiBarcodeScannerWidget(
      platformScannerController: _scannerController,
    );
  }
}
