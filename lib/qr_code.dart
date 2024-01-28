import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

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
      setState(() {
        result = scanData.code!;
      });
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
            child: QRView(
              key: qrkey,
              onQRViewCreated: _onQrViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Scan Result: $result',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (result.isNotEmpty) {
                      //Clipboard to copy the result data
                      Clipboard.setData(
                        ClipboardData(text: result),
                      );
                      //copied message under the screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "تم النسخ إلى الحافظة",
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text("Copy"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (result.isNotEmpty) {
                      //convert the result to url and (launchUrl) open it in brouser
                      final Uri _uri = Uri.parse(result);
                      await launchUrl(_uri);
                    }
                  },
                  child: const Text("Open"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
