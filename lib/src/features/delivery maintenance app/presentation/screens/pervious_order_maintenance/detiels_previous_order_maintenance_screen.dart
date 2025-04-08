import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/order_maintenances_details_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/pervious_order/pervious_order_screen.dart';

class PerviousOrdersDetailsScreen extends StatefulWidget {
  final int handReceiptId;
  final int orderMaintenancId;

  const PerviousOrdersDetailsScreen({
    Key? key,
    required this.handReceiptId,
    required this.orderMaintenancId,
  }) : super(key: key);

  @override
  State<PerviousOrdersDetailsScreen> createState() =>
      _PerviousOrdersDetailsScreenState();
}

class _PerviousOrdersDetailsScreenState
    extends State<PerviousOrdersDetailsScreen> {
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
              builder: (context) => const PerviousOrderScreen(),
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
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.orders!.length,
              itemBuilder: (context, index) {
                final orderItem = order.orders![index];
                return Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: CustomStyledText(
                        text: "رقم الطلب #${orderItem.id.toString()}",
                        fontSize: 16,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSizedBox.kVSpace10,
                          CustomStyledText(
                            text: " ${orderItem.item.toString()}",
                            textColor: AppColors.secondaryColor,
                          ),
                          AppSizedBox.kVSpace10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomStyledText(
                                text:
                                    "لون الجهاز: ${orderItem.color.toString()}",
                              ),
                              CustomStyledText(
                                  text:
                                      "الشركة:  ${orderItem.company.toString() ?? "غير محدد"}")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
