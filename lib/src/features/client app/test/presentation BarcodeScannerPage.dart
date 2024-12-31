import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String barcodeResult = "لم يتم مسح الباركود";

  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        barcodeResult = result.rawContent.isEmpty
            ? "لم يتم العثور على نتيجة"
            : result.rawContent;
      });
    } catch (e) {
      setState(() {
        barcodeResult = "حدث خطأ أثناء مسح الباركود: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("قارئ الباركود"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: scanBarcode,
              child: const Text("مسح الباركود"),
            ),
            const SizedBox(height: 20),
            Text(
              "نتيجة البحث: $barcodeResult",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
