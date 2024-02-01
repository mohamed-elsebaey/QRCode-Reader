import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomModalCard extends StatelessWidget {
  const CustomModalCard({
    super.key,
    required this.result,
  });

  final String result;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Scan Result: ',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              '$result',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                  ),
                  onPressed: () {
                    if (result.isNotEmpty) {
                      //Clipboard to copy the result data
                      Clipboard.setData(
                        ClipboardData(text: result),
                      );
                      //
                      Navigator.pop(context);
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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                  ),
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
          ],
        ),
      ),
    );
  }
}
