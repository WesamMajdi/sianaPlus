import 'package:flutter/material.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/services/telr_service_xml_order.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/failedScreen.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';

class TelrMaintenancePaymentScreen extends StatefulWidget {
  final String paymentUrl;
  final String closeUrl;
  final String abortUrl;
  final String transactionCode;
  final int orderMaintenanceId;
  const TelrMaintenancePaymentScreen(
      {super.key,
      required this.paymentUrl,
      required this.closeUrl,
      required this.abortUrl,
      required this.transactionCode,
      required this.orderMaintenanceId});

  @override
  State<TelrMaintenancePaymentScreen> createState() =>
      _TelrMaintenancePaymentScreenState();
}

class _TelrMaintenancePaymentScreenState
    extends State<TelrMaintenancePaymentScreen> {
  late WebViewController controller;
  bool _isLoading = true;
  bool _paymentHandled = false;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onUrlChange: (urlChange) {
            final url = urlChange.url ?? '';
            _handleUrlChange(url);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _handleUrlChange(String url) async {
    if (_paymentHandled) return;

    debugPrint("🔗 URL changed: $url");

    if (url == widget.closeUrl) {
      _paymentHandled = true;
      await _confirmPayment();
    } else if (url == widget.abortUrl || url.contains("payment-cancelled")) {
      _paymentHandled = true;
      _navigateToFailed("تم إلغاء الطلب أو فشلت العملية.");
    }
  }

  Future<void> _confirmPayment() async {
    setState(() => _isLoading = true);

    final result = await TelrServiceXMLOrder.completePayment(
      orderRef: widget.transactionCode,
    );

    setState(() => _isLoading = false);

    String message = 'فشل تأكيد الدفع.';

    if (result != null) {
      message = telrMessagesAr[result['message']] ??
          telrMessagesAr[result['status']] ??
          result['message'] ??
          message;
    }

    if (result != null && result['status'] == 'A') {
      _navigateToSuccess();
    } else {
      _navigateToFailed(message);
    }
  }

  void _navigateToSuccess() async {
    await context.read<OrderCubit>().payWithApp(widget.orderMaintenanceId);
    print(
        "ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (_) =>
              const SuccessPage(message: "تم دفع سعر الصيانة بنجاح")),
      (route) => false,
    );
  }

  void _navigateToFailed(String message) {
    print(
        "ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => FailedScreen(message: message)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!_paymentHandled) {
          _paymentHandled = true;
          _navigateToFailed("تم إلغاء العملية من قبل المستخدم.");
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBarApplicationArrow(
          text: "إتمام الدفع",
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: controller),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

final Map<String, String> telrMessagesAr = {
  'Authorised': 'تم الدفع بنجاح.',
  'Declined': 'تم رفض الدفع.',
  'Cancelled': 'تم إلغاء الدفع.',
  'Error': 'حدث خطأ أثناء عملية الدفع.',
  'A': 'تم الدفع بنجاح.',
  'D': 'تم رفض الدفع.',
  'C': 'تم إلغاء الدفع.',
  'E': 'حدث خطأ أثناء عملية الدفع.',
};
