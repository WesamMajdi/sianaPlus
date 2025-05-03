import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/orders_maintenance/details_orders_screen.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/hand_receip_maintenance_parts/hand_receipt_model.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/online_maintenance_parts/online_maintenance_parts.dart';

class MaintenanceOrders extends StatelessWidget {
  final OrderEntity orderEntity;
  final OrderState state;
  final bool isTab;

  const MaintenanceOrders(
      {Key? key,
      required this.orderEntity,
      required this.state,
      required this.isTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MaintenanceOrdersDetailsScreen(
                      orderMaintenancId: orderEntity.id!,
                      handReceiptId: orderEntity.handReceiptId!,
                      isTab: isTab,
                      isPayid: orderEntity.isPayid!,
                      total: orderEntity.total),
                ));
          },
          child: Padding(
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
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.largePadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomStyledText(
                                  text: "طلب #${orderEntity.id}",
                                  fontSize: 18,
                                  textColor: AppColors.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: getColorStatusOnline(
                                        orderEntity.orderMaintenanceStatus!),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    child: CustomStyledText(
                                      text: getTextStatusOnline(
                                          orderEntity.orderMaintenanceStatus!),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppSizedBox.kVSpace20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomStyledText(
                                      text:
                                          'تاريخ الطلب: ${orderEntity.createdAt!.toString().split(' ')[0]}',
                                      fontSize: 16,
                                      textColor: Colors.grey,
                                    ),
                                    AppSizedBox.kVSpace5,
                                    Row(
                                      children: [
                                        CustomStyledText(
                                          text:
                                              'سعر الصيانة: ${orderEntity.totalAfterDiscount == 0 ? "لم يحدد بعد" : orderEntity.total}',
                                          fontSize: 16,
                                          textColor: Colors.grey,
                                        ),
                                        AppSizedBox.kWSpace10,
                                        if (orderEntity.totalAfterDiscount != 0)
                                          Image.asset(
                                            "assets/images/logoRiyal.png",
                                            width: 16,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                          )
                                      ],
                                    ),
                                    AppSizedBox.kVSpace5,
                                    Row(
                                      children: [
                                        const CustomStyledText(
                                          text: 'هل تم دفع:',
                                          fontSize: 16,
                                          textColor: Colors.grey,
                                        ),
                                        CustomStyledText(
                                          text:
                                              ' ${orderEntity.isPayid! ? 'تم الدفع' : 'لم يتم دفعه'}',
                                          fontSize: 16,
                                          textColor: orderEntity.isPayid!
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )))),
        ),
      ],
    );
  }

  String getStatusOrder(int orderStatus) {
    return OrderMaintenanceStatus.values[orderStatus - 1].nameAr.toString();
  }

  Color getStatusOrderColor(int orderStatus) {
    return OrderMaintenanceStatus.values[orderStatus - 1].statusColor;
  }
}
