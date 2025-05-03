import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/receipt_item_convert_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/receive_order_Maintenance_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/outSide_order_maintenance/outside_order_maintenance.dart';

class ItemsMaintenanceOutSidePart extends StatelessWidget {
  final ReceiptItemConvertModel item;
  const ItemsMaintenanceOutSidePart({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.mediumPadding,
        vertical: AppPadding.smallPadding,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.largePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomStyledText(
                    text: 'رقم الطلب: #${item.id}',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.secondaryColor,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: getColorOrderStatusMaintenanceOutSide(
                              item.receiptItemConvertStatus),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CustomStyledText(
                          text: getTextOrderStatusMaintenanceOutSide(
                              item.receiptItemConvertStatus),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          textColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomStyledText(
                text: 'اسم القطعة: ${item.name}',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              CustomStyledText(
                text: 'الشركة المصنعة: ${item.company}',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textColor: Colors.grey,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.store_mall_directory,
                      size: 20, color: Colors.blueGrey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomStyledText(
                      text: 'من: ${item.convertFromBranchName}',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.store, size: 20, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomStyledText(
                      text: 'إلى: ${item.address}',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.color_lens, size: 20, color: Colors.pink),
                  const SizedBox(width: 8),
                  CustomStyledText(
                    text: 'لون القطعة: ${item.color}',
                    fontSize: 15,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              buildTakeOrderButtonWidget(context)
            ],
          ),
        ),
      ),
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
                if (state.deliveryMaintenanceOutSideStatus ==
                    DeliveryMaintenanceOutSideStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.deliveryMaintenanceOutSideStatus ==
                    DeliveryMaintenanceOutSideStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.deliveryMaintenanceOutSideStatus ==
                    DeliveryMaintenanceOutSideStatus.success) {
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
                        getTakeOrderTile(context, item.id)
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
                await context
                    .read<DeliveryMaintenanceCubit>()
                    .takeOrderMaintenanceoOutSide(
                      orderMaintenancId: orderMaintenancId,
                    );
                await context
                    .read<DeliveryMaintenanceCubit>()
                    .fetchAllForAllDeliveryOutSide(refresh: true);
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const OutSideOrderMaintenancesScreen(),
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
