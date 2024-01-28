import 'package:flutter/material.dart';
import 'package:qr_code_app/qr_code.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qr Code Scanner',
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: const mainScreen(),
    );
  }
}

class mainScreen extends StatelessWidget {
  const mainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 60,
              child: Text(
                'QRCode Reader',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset(
              'assets/qr-code.png',
              width: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton.icon(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
                // iconColor: MaterialStateProperty.all(Colors.black),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                ),
                textStyle: MaterialStateProperty.all(
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.black12),
                iconSize: MaterialStateProperty.all(35),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const QRCodeWidget();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scan Now'),
            ),
          ],
        ),
      ),
    );
  }
}
