import 'package:flutter/material.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/failedScreen.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late WebViewController controller;
  bool _isLoading = true;
  bool _paymentCompleted = false;
  bool _isPaymentCancelled = false;

  @override
  void initState() {
    super.initState();
    print("Starting payment process...");
    print("Payment URL: ${widget.paymentUrl}");
    _initializeWebView();
  }

  void _initializeWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
            _checkUrlForPaymentResult(url);
          },
          onUrlChange: (urlChange) {
            final changedUrl = urlChange.url ?? '';
            debugPrint('URL Changed: $changedUrl');
            _checkUrlForPaymentResult(changedUrl);
          },
          onNavigationRequest: (navigation) {
            final navUrl = navigation.url;

            // التحقق من روابط الإلغاء أو الفشل
            if (navUrl.contains('payment-cancelled') ||
                navUrl.contains('cancel')) {
              _handleCancellation();
              return NavigationDecision.prevent;
            }
            if (navUrl.contains('payment-failed') || navUrl.contains('fail')) {
              _handleFailure();
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl!));
  }

  void _checkUrlForPaymentResult(String url) {
    if (_paymentCompleted || _isPaymentCancelled) return;

    debugPrint('Checking URL for payment result: $url');

    if (url.contains('webview_close')) {
      _handleSuccess();
    } else if (url.contains('payment-cancelled') || url.contains('cancel')) {
      _handleCancellation();
    } else if (url.contains('payment-failed') || url.contains('fail')) {
      _handleFailure();
    }
  }

  void _handleSuccess() {
    if (_paymentCompleted || _isPaymentCancelled) return;

    setState(() {
      _paymentCompleted = true;
    });

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

    setState(() {
      _paymentCompleted = true;
      _isPaymentCancelled = true;
    });

    context.read<CategoryCubit>().clearCart();
    context.read<CategoryCubit>().resetOrderStatus();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const FailedScreen(message: "تم إلغاء الطلب!"),
      ),
    );
  }

  void _handleFailure() {
    if (_paymentCompleted) return;

    setState(() {
      _paymentCompleted = true;
    });

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
        appBar: AppBarApplicationArrow(
            text: "إتمام الدفع", onBackTap: _handleCancellation),
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
