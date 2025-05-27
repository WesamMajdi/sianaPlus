import 'package:flutter/material.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/failedScreen.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';

class TelrDeliveryMaintenancePaymentScreen extends StatefulWidget {
  final String? paymentUrl;
  final CreateOrderRequest createOrder;
  const TelrDeliveryMaintenancePaymentScreen({
    super.key,
    this.paymentUrl,
    required this.createOrder,
  });

  @override
  _TelrDeliveryMaintenancePaymentScreenState createState() =>
      _TelrDeliveryMaintenancePaymentScreenState();
}

class _TelrDeliveryMaintenancePaymentScreenState
    extends State<TelrDeliveryMaintenancePaymentScreen> {
  late final WebViewController controller;
  bool _isLoading = true;
  bool _paymentCompleted = false;

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
          onPageStarted: (url) => setState(() => _isLoading = true),
          onPageFinished: (url) => setState(() => _isLoading = false),
          onUrlChange: (urlChange) {
            debugPrint('Payment URL changed: ${urlChange.url}');
            _handlePaymentResult(urlChange.url ?? '');
          },
          onNavigationRequest: (navigation) {
            if (navigation.url.contains('payment-cancelled')) {
              _handleCancellation();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl!));
  }

  void _handlePaymentResult(String url) {
    if (_paymentCompleted) return;

    if (url.contains("pp2_acs_return")) {
      _handleSuccess();
    } else if (url.contains("payment-cancelled")) {
      _handleCancellation();
    } else if (url.contains("payment-failed")) {
      _handleFailure();
    }
  }

  Future<void> _handleSuccess() async {
    _paymentCompleted = true;
    try {
      context.read<OrderCubit>().createOrderMaintenance(widget.createOrder);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const SuccessPage(message: "تم دفع سعر توصيل بنجاح"),
        ),
      );
    } catch (e) {
      debugPrint('Payment error: $e');
      if (!mounted) return;
      _handleFailure();
    }
  }

  void _handleCancellation() {
    _paymentCompleted = true;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const FailedScreen(message: "تم إلغاء عملية الدفع"),
      ),
    );
  }

  void _handleFailure() {
    _paymentCompleted = true;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const FailedScreen(message: "فشل عملية الدفع"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!_paymentCompleted) {
          _handleCancellation();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBarApplicationArrow(
            text: "اتمام الدفع", onBackTap: _handleCancellation),
        body: Stack(
          children: [
            if (widget.paymentUrl == null)
              const Center(child: CircularProgressIndicator())
            else
              WebViewWidget(controller: controller),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
