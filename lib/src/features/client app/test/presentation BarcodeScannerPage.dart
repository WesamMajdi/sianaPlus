import 'package:maintenance_app/src/core/utilities/barcode%20scanner%20service.dart';
import '../../../core/export file/exportfiles.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String barcodeResult = "لم يتم مسح الباركود";
  final BarcodeScannerService barcodeScannerService = BarcodeScannerService();

  Future<void> initiateScanBarcode() async {
    String barcode = await barcodeScannerService.scanBarcode();
    setState(() {
      barcodeResult = barcode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: initiateScanBarcode,
              child: const CustomStyledText(
                text: "مسح الباركود",
                textColor: Colors.white,
              ),
            ),
            CustomStyledText(
              text: "نتيجة البحث : $barcodeResult",
              fontSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
