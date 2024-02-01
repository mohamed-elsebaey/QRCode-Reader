import 'package:flutter/material.dart';
import 'package:qr_code_app/CustomModalCard.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// QRCode Reader Widget

class QRCodeWidget extends StatefulWidget {
  const QRCodeWidget({super.key});
  @override
  State<QRCodeWidget> createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {
  // GlobalKey is a unique key for class
  final GlobalKey qrkey = GlobalKey(debugLabel: "QR");

  // after read the QRCode the first result saved here
  QRViewController? controller;

  //the final url result
  String result = '';

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  //the function that responsed to take the result from controller and the result into result
  void _onQrViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData.code!;
      // when result is taken Navigate the screen
      Navigator.pop(context);
      // show Modal
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return CustomModalCard(result: result);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            // QrView the widget for Qr camera scan
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
              child: QRView(
                key: qrkey,
                onQRViewCreated: _onQrViewCreated,
                // try the overlay "the camera"
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.cyan,
                  borderRadius: 12,
                  borderLength: 36,
                  // overlayColor: Colors.amber,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
