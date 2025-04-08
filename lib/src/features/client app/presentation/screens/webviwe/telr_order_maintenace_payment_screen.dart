import 'package:flutter/material.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TelrMaihtenancePaymentScreen extends StatefulWidget {
  final String? paymentUrl;
  final CreateOrderRequest createOrder;

  const TelrMaihtenancePaymentScreen(
      {super.key, this.paymentUrl, required this.createOrder});

  @override
  _TelrMaihtenancePaymentScreenState createState() =>
      _TelrMaihtenancePaymentScreenState();
}

class _TelrMaihtenancePaymentScreenState
    extends State<TelrMaihtenancePaymentScreen> {
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
                                .read<OrderCubit>()
                                .createOrderMaintenance(widget.createOrder);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const SuccessPage(
                                        message: "تم طلب بنجاح!!",
                                      )),
                            );
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
