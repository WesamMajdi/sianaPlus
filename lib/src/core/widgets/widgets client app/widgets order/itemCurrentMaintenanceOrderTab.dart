import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/data/data_sources/orders/orders_data_source.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/orders_maintenance/details_orders_screen.dart';

class CurrentMaintenanceOrdersTab extends StatelessWidget {
  final ItemsEntity itemEntity;
  final OrderState state;

  const CurrentMaintenanceOrdersTab(
      {Key? key, required this.itemEntity, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (currentOrders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CustomStyledText(text: 'لا توجد طلبات حالية')],
        ),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.mediumPadding,
              vertical: AppPadding.smallPadding),
          child: Container(
              decoration: BoxDecoration(
                color: (Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.white),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrdersDetailsPage(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.mediumPadding,
                      vertical: AppPadding.mediumPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSizedBox.kVSpace10,
                          CustomStyledText(
                            text: "طلب #${""}",
                            fontSize: 16,
                          ),
                          AppSizedBox.kVSpace5,
                          CustomStyledText(
                            text: itemEntity.item!.name!,
                            textColor: AppColors.secondaryColor,
                            fontSize: 20,
                          ),
                          AppSizedBox.kVSpace5,
                        ],
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomStyledText(
                                text: "السعر: ",
                                textColor: AppColors.secondaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                              CustomStyledText(
                                text: "${'order.price'}\$",
                                fontSize: 14,
                              ),
                            ],
                          ),
                          AppSizedBox.kVSpace5,
                          Row(
                            children: [
                              CustomStyledText(
                                text: "الحالة: ",
                                textColor: AppColors.secondaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                              CustomStyledText(
                                text: "${'order.status'} ",
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )));
    }
  }
}
