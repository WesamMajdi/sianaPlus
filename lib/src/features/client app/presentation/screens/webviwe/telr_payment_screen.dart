import 'package:flutter/material.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TelrPaymentScreen extends StatefulWidget {
  final String? paymentUrl;

  const TelrPaymentScreen({super.key, this.paymentUrl});

  @override
  _TelrPaymentScreenState createState() => _TelrPaymentScreenState();
}

class _TelrPaymentScreenState extends State<TelrPaymentScreen> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarApplication(
          text: "إتمام الدفع",
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
          return widget.paymentUrl == null
              ? const Center(child: CircularProgressIndicator())
              : WebViewWidget(
                  controller: WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setNavigationDelegate(
                      NavigationDelegate(
                        onPageStarted: (url) {
                          if (url.contains("webview_close.html")) {
                            context
                                .read<CategoryCubit>()
                                .createOrder(state.cartItems);
                            Navigator.pop(context, "success");
                          } else if (url.contains("webview_abort.html")) {
                            Navigator.pop(context, "cancelled");
                          } else {}
                        },
                      ),
                    )
                    ..loadRequest(Uri.parse(widget.paymentUrl!)),
                );
        }));
  }
}
