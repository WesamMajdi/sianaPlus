import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customInputDialog.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/receipt_item_convert_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/receive_order_Maintenance_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/outSide_order_maintenance/outside_current_order_maintenance_screen.dart';

class ItemsCurrentMaintenanceOutSidePart extends StatelessWidget {
  final ReceiptItemConvertModel item;
  const ItemsCurrentMaintenanceOutSidePart({super.key, required this.item});

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
              buildProccesOrderButtonWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProccesOrderButtonWidget(BuildContext context) {
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
                if (state.deliveryMaintenanceCurrentOutSideStatus ==
                    DeliveryMaintenanceCurrentOutSideStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.deliveryMaintenanceCurrentOutSideStatus ==
                    DeliveryMaintenanceCurrentOutSideStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.deliveryMaintenanceCurrentOutSideStatus ==
                    DeliveryMaintenanceCurrentOutSideStatus.success) {
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
                        ...getItemsBasedOnStatus(
                            context, item.receiptItemConvertStatus),
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
                width: 150,
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
                          fontSize: 18,
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

  List<Widget> getItemsBasedOnStatus(
    BuildContext context,
    int status,
  ) {
    if (status == 1) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "اخذ من الفرع",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(onConfirm: () async {
                  final cubit = context.read<DeliveryMaintenanceCubit>();
                  try {
                    await cubit.updateOrderMaintenanceOutSide(
                        orderMaintenancId: item.id, status: 2);

                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CurrentTakeOrderMaintenanceOutSideScreen(),
                      ),
                    );
                    BlocProvider.of<DeliveryMaintenanceCubit>(context)
                        .fetchAllTakeDeliveryOutSide(refresh: true);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update status: $e')),
                    );
                  }
                });
              },
            );
          },
        ),
      ];
    } else if (status == 2) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "تحويل إلى شركة صيانة خارجية",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(onConfirm: () async {
                  final cubit = context.read<DeliveryMaintenanceCubit>();
                  try {
                    await cubit.updateOrderMaintenanceOutSide(
                        orderMaintenancId: item.id, status: 3);

                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CurrentTakeOrderMaintenanceOutSideScreen(),
                      ),
                    );
                    BlocProvider.of<DeliveryMaintenanceCubit>(context)
                        .fetchAllTakeDeliveryOutSide(refresh: true);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update status: $e')),
                    );
                  }
                });
              },
            );
          },
        ),
      ];
    } else if (status == 3) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "انتهاء عملية الصيانة",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(onConfirm: () async {
                  final cubit = context.read<DeliveryMaintenanceCubit>();
                  try {
                    await cubit.updateOrderMaintenanceOutSide(
                        orderMaintenancId: item.id, status: 5);

                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CurrentTakeOrderMaintenanceOutSideScreen(),
                      ),
                    );
                    BlocProvider.of<DeliveryMaintenanceCubit>(context)
                        .fetchAllTakeDeliveryOutSide(refresh: true);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update status: $e')),
                    );
                  }
                });
              },
            );
          },
        ),
      ];
    } else if (status == 4 && item.maintenancePrice == null) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: 'سعر صيانة',
            fontSize: 20,
          ),
          onTap: () {
            final TextEditingController priceController =
                TextEditingController();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomInputDialog(
                  titleDialog: 'تحديد السعر',
                  text: 'السعر:',
                  hintText: 'ادخل السعر',
                  controller: priceController,
                  validators: (value) {
                    if (value == null || value.isEmpty) {
                      return 'عفوا.السعر مطلوب';
                    }
                    return null;
                  },
                  onConfirm: () {
                    if (priceController.text.isNotEmpty) {
                      final double price =
                          double.tryParse(priceController.text) ?? 0.0;
                      print("ssssssssssssssssssssssssssssssssssssssssssss");
                      context
                          .read<DeliveryMaintenanceCubit>()
                          .setMaintenancePrice(
                            convertHandReceiptItemId: item.id,
                            maintenancePrice: price,
                          );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const CurrentTakeOrderMaintenanceOutSideScreen(),
                        ),
                      );
                      BlocProvider.of<DeliveryMaintenanceCubit>(context)
                          .fetchAllTakeDeliveryOutSide(refresh: true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('الرجاء إدخال السعر')),
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ];
    } else if (status == 4) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "أخذ من شركة الصيانة الخارجية",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(onConfirm: () async {
                  final cubit = context.read<DeliveryMaintenanceCubit>();
                  try {
                    await cubit.updateOrderMaintenanceOutSide(
                        orderMaintenancId: item.id, status: 6);

                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CurrentTakeOrderMaintenanceOutSideScreen(),
                      ),
                    );
                    BlocProvider.of<DeliveryMaintenanceCubit>(context)
                        .fetchAllTakeDeliveryOutSide(refresh: true);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update status: $e')),
                    );
                  }
                });
              },
            );
          },
        ),
      ];
    } else if (status == 5) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "إرجاعها  الي الفرع",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(onConfirm: () async {
                  final cubit = context.read<DeliveryMaintenanceCubit>();
                  try {
                    await cubit.updateOrderMaintenanceOutSide(
                        orderMaintenancId: item.id, status: 7);
                    BlocProvider.of<DeliveryMaintenanceCubit>(context)
                        .fetchAllTakeDeliveryOutSide(refresh: true);
                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CurrentTakeOrderMaintenanceOutSideScreen(),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update status: $e')),
                    );
                  }
                });
              },
            );
          },
        ),
      ];
    } else if (status == 6) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "مكتمل",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(onConfirm: () async {
                  final cubit = context.read<DeliveryMaintenanceCubit>();
                  try {
                    await cubit.updateOrderMaintenanceConvert(
                        orderMaintenancId: item.id, status: 7);

                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CurrentTakeOrderMaintenanceOutSideScreen(),
                      ),
                    );
                    BlocProvider.of<DeliveryMaintenanceCubit>(context)
                        .fetchAllTakeDeliveryOutSide(refresh: true);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update status: $e')),
                    );
                  }
                });
              },
            );
          },
        ),
      ];
    }

    return [];
  }
}
