import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/order_maintenances_details_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/receive_maintenances_order/receive_order_maintenances_screen.dart';

class ReceiveOrdersMaintenanceDetailsScreen extends StatefulWidget {
  final int handReceiptId;
  final int orderMaintenancId;
  const ReceiveOrdersMaintenanceDetailsScreen({
    Key? key,
    required this.handReceiptId,
    required this.orderMaintenancId,
  }) : super(key: key);

  @override
  State<ReceiveOrdersMaintenanceDetailsScreen> createState() =>
      _ReceiveOrdersMaintenanceDetailsScreenState();
}

class _ReceiveOrdersMaintenanceDetailsScreenState
    extends State<ReceiveOrdersMaintenanceDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DeliveryMaintenanceCubit>().fetchAllItemByOrderDetiles(
        widget.handReceiptId, widget.orderMaintenancId);
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
              builder: (context) => const ReceiveOrderMaintenancesScreen(),
            ),
          );
        },
      ),
      body: BlocBuilder<DeliveryMaintenanceCubit, DeliveryMaintenanceState>(
        builder: (context, state) {
          if (state.deliveryMaintenanceStatus ==
              DeliveryMaintenanceStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.deliveryMaintenanceStatus ==
              DeliveryMaintenanceStatus.failure) {
            return const Center(child: Text('فشلت العملية'));
          }

          if (state.deliveryMaintenanceStatus ==
              DeliveryMaintenanceStatus.success) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: state.selectedOrderDetilesItems.length,
              itemBuilder: (context, index) {
                final order = state.selectedOrderDetilesItems[index];
                return _buildOrderItem(context, order);
              },
            );
          }

          return const Center(
            child: CustomStyledText(text: 'جاري التحميل...'),
          );
        },
      ),
    );
  }

  Widget _buildOrderItem(
      BuildContext context, OrderMaintenancesDetailsEntity order) {
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
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.largePadding),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: order.orders!.length,
                itemBuilder: (context, index) {
                  final orderItem = order.orders![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: CustomStyledText(
                          text: orderItem.item ?? "غير محدد",
                          fontSize: 16,
                          textColor: AppColors.lightGrayColor,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomStyledText(
                                  text: orderItem.color ?? "غير محدد",
                                ),
                                CustomStyledText(
                                    text:
                                        "الشركة:  ${orderItem.company ?? "غير محدد"}")
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CustomStyledText(
                                  text: "الوصف:",
                                  textColor: AppColors.lightGrayColor,
                                ),
                                CustomStyledText(
                                    text:
                                        "  ${orderItem.description ?? "غير محدد"}"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        buildTakeOrderButtonWidget(
          context,
        )
      ],
    );
  }

  Widget buildTakeOrderButtonWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          builder: (BuildContext context) {
            return BlocBuilder<DeliveryMaintenanceCubit,
                DeliveryMaintenanceState>(
              builder: (context, state) {
                final selectedOrderDetilesItems =
                    state.selectedOrderDetilesItems;

                if (state.deliveryMaintenanceStatus ==
                    DeliveryMaintenanceStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.deliveryMaintenanceStatus ==
                    DeliveryMaintenanceStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.deliveryMaintenanceStatus ==
                    DeliveryMaintenanceStatus.success) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 50,
                          height: 5,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12, left: 10),
                          alignment: Alignment.topRight,
                          child: const CustomStyledText(
                            text: 'اختر العملية:',
                            textColor: AppColors.secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        getTakeOrderTile(context, widget.orderMaintenancId)
                      ],
                    ),
                  );
                }
                return const Center(
                    child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
              },
            );
          },
        );
      },
      child: SizedBox(
        height: 80,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.secondaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.gear,
                        size: 20,
                      ),
                      AppSizedBox.kWSpace10,
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const CustomStyledText(
                          text: 'العمليات',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTakeOrderTile(BuildContext context, int orderMaintenancId) {
    return ListTile(
      title: const CustomStyledText(
        text: 'اخذ طلب',
        fontSize: 20,
      ),
      onTap: () {
        print(orderMaintenancId);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomSureDialog(
              onConfirm: () async {
                await context.read<DeliveryMaintenanceCubit>().takeOrder(
                      orderMaintenancId: orderMaintenancId,
                    );

                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ReceiveOrderMaintenancesScreen(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
