import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/services/telr_service_xml.dart';
import 'package:maintenance_app/src/core/services/telr_service_xml_order.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customInputDialog.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/basket_Model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/ordered_product/ordered_product_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/orders_maintenance/maintenance_requests_for_approval_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/webviwe/telr_order_maintenace_payment_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/webviwe/telr_payment_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/order_maintenances_details_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';

class PrductOrdersDetailsScreen extends StatefulWidget {
  final int basketId;

  const PrductOrdersDetailsScreen({
    Key? key,
    required this.basketId,
  }) : super(key: key);

  @override
  State<PrductOrdersDetailsScreen> createState() =>
      _PrductOrdersDetailsScreenState();
}

final TextEditingController desController = TextEditingController();

class _PrductOrdersDetailsScreenState extends State<PrductOrdersDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getAllItemByOrder(widget.basketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(
        text: 'تفاصيل طلب',
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OrdersProductPage(),
            ),
          );
        },
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state.orderProductStatus == OrderProductStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.orderProductStatus == OrderProductStatus.failure) {
            return const Center(child: Text('فشلت العملية'));
          }

          if (state.orderProductStatus == OrderProductStatus.success) {
            return Column(
              children: [
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.basket.length,
                    itemBuilder: (context, index) {
                      final basket = state.basket[index];
                      return _buildOrderItem(context, basket);
                    },
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: CustomStyledText(text: 'جاري التحميل...'),
          );
        },
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, BasketModel order) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.mediumPadding,
            vertical: AppPadding.smallPadding,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: (Theme.of(context).brightness == Brightness.dark
                  ? Colors.black54
                  : Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items!.length,
              itemBuilder: (context, index) {
                final orderItem = order.items![index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomStyledText(
                                    text: orderItem.productName ?? "غير محدد",
                                    fontSize: 18,
                                    textColor: AppColors.lightGrayColor,
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppSizedBox.kVSpace10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomStyledText(
                                        text:
                                            "لون القطعة: ${orderItem.productColor ?? "غير محدد"}",
                                        fontSize: 14,
                                      ),
                                      CustomStyledText(
                                        text:
                                            "الشركة: ${orderItem.productCompany ?? "غير محدد"}",
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  CustomStyledText(
                                    text:
                                        "السعر: ${orderItem.price ?? "غير محدد"}",
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
