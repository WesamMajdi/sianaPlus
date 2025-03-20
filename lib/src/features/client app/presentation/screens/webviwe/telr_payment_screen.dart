import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TelrPaymentScreen extends StatefulWidget {
  @override
  _TelrPaymentScreenState createState() => _TelrPaymentScreenState();
}

class _TelrPaymentScreenState extends State<TelrPaymentScreen> {
  WebViewController? controller;
  String? paymentUrl;

  @override
  void initState() {
    super.initState();
    _loadPaymentUrl();
  }

  Future<void> _loadPaymentUrl() async {
    setState(() {
      paymentUrl = "https://example.com/payment";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إتمام الدفع")),
      body: paymentUrl == null
          ? const Center(child: CircularProgressIndicator())
          : WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..loadRequest(Uri.parse(paymentUrl!))),
    );
  }
}
