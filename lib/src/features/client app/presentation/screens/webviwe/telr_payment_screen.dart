import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/failedScreen.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';

class TelrPaymentScreen extends StatefulWidget {
  final String? paymentUrl;
  final double totalAmount;

  const TelrPaymentScreen({
    Key? key,
    this.paymentUrl,
    required this.totalAmount,
  }) : super(key: key);

  @override
  _TelrPaymentScreenState createState() => _TelrPaymentScreenState();
}

class _TelrPaymentScreenState extends State<TelrPaymentScreen> {
  late final WebViewController controller;
  bool _isLoading = true;
  bool _paymentCompleted = false;
  bool _isPaymentCancelled = false;

  @override
  void initState() {
    super.initState();
    print(widget.paymentUrl);
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
            final changedUrl = urlChange.url ?? '';
            debugPrint('Payment URL changed: $changedUrl');
            _handlePaymentResult(changedUrl);
          },
          onNavigationRequest: (navigation) {
            final navUrl = navigation.url;
            if (navUrl.contains('payment-cancelled')) {
              _isPaymentCancelled = true;
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
    if (_paymentCompleted || _isPaymentCancelled) return;

    if (url.contains("payment-success")) {
      _handleSuccess();
    } else if (url.contains("payment-cancelled")) {
      _handleCancellation();
    } else if (url.contains("payment-failed")) {
      _handleFailure();
    }
  }

  void _handleSuccess() {
    if (_isPaymentCancelled || _paymentCompleted) return;

    _paymentCompleted = true;
    context.read<CategoryCubit>().createOrder(widget.totalAmount);
    context.read<CategoryCubit>().clearCart();
    context.read<CategoryCubit>().resetOrderStatus();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const SuccessPage(message: "تمت العملية بنجاح!"),
      ),
    );
  }

  void _handleCancellation() {
    if (_paymentCompleted) return;

    _paymentCompleted = true;
    _isPaymentCancelled = true;

    context.read<CategoryCubit>().clearCart();
    context.read<CategoryCubit>().resetOrderStatus();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const FailedScreen(message: "تم الغاء الطلب!"),
      ),
    );
  }

  void _handleFailure() {
    if (_paymentCompleted) return;

    _paymentCompleted = true;

    context.read<CategoryCubit>().clearCart();
    context.read<CategoryCubit>().resetOrderStatus();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const FailedScreen(message: "فشلت عملية الدفع!"),
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
        appBar: AppBar(
          title: const Text("إتمام الدفع"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _handleCancellation,
          ),
        ),
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
