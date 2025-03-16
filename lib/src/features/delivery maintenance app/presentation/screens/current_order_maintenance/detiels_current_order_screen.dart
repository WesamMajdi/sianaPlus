import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/order_maintenances_details_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/receive_order_maintenance_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/current_order_maintenance/current_order_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/current_order/current_order_screen.dart';

class CurrentMaintenanceOrdersDetailsScreen extends StatefulWidget {
  final int handReceiptId;
  final int orderMaintenancId;

  const CurrentMaintenanceOrdersDetailsScreen({
    Key? key,
    required this.handReceiptId,
    required this.orderMaintenancId,
  }) : super(key: key);

  @override
  State<CurrentMaintenanceOrdersDetailsScreen> createState() =>
      _CurrentMaintenanceOrdersDetailsScreenState();
}

class _CurrentMaintenanceOrdersDetailsScreenState
    extends State<CurrentMaintenanceOrdersDetailsScreen> {
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
              builder: (context) => const CurrentTakeOrderMaintenanceScreen(),
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
                final ordersCurrent = state.selectedOrderDetilesItems[index];

                return _buildOrderItem(context, ordersCurrent);
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
                          text: orderItem.item.toString() ?? "غير محدد",
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
                                  text:
                                      orderItem.color.toString() ?? "غير محدد",
                                ),
                                CustomStyledText(
                                    text:
                                        "الشركة:  ${orderItem.company.toString() ?? "غير محدد"}")
                              ],
                            ),
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
        buildProccesOrderButtonWidget(context),
      ],
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
                  final order = state.selectedOrderDetilesItems;

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
                        ...getItemsBasedOnStatus(context, order[0].orderStatus),
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

  List<Widget> getItemsBasedOnStatus(
    BuildContext context,
    int status,
  ) {
    if (status == 1) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "استلام من الزبون",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(onConfirm: () async {
                  final cubit = context.read<DeliveryMaintenanceCubit>();
                  try {
                    await cubit.updateOrderMaintenance(
                        orderMaintenancId: widget.orderMaintenancId, status: 2);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CurrentMaintenanceOrdersDetailsScreen(
                          handReceiptId: widget.handReceiptId,
                          orderMaintenancId: widget.orderMaintenancId,
                        ),
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
    } else if (status == 2) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "توصيل الطلب لفرع",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ShowDilogDeliveringOrderToBranch(
                  orderMaintenanceId: widget.orderMaintenancId,
                );
              },
            );
          },
        ),
      ];
    } else if (status == 3) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "انتظار انتهاء الصيانة",
            fontSize: 20,
          ),
          onTap: () {},
        ),
      ];
    } else if (status == 4) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "تم إبلاغ العميل بالتكلفة",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(onConfirm: () async {
                  final cubit = context.read<DeliveryMaintenanceCubit>();
                  try {
                    await cubit.updateOrderMaintenance(
                        orderMaintenancId: widget.orderMaintenancId, status: 5);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CurrentMaintenanceOrdersDetailsScreen(
                          handReceiptId: widget.handReceiptId,
                          orderMaintenancId: widget.orderMaintenancId,
                        ),
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
    } else if (status == 5) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "انتهاء الصيانة",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(onConfirm: () async {
                  final cubit = context.read<DeliveryMaintenanceCubit>();
                  try {
                    await cubit.updateOrderMaintenance(
                        orderMaintenancId: widget.orderMaintenancId, status: 6);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CurrentMaintenanceOrdersDetailsScreen(
                          handReceiptId: widget.handReceiptId,
                          orderMaintenancId: widget.orderMaintenancId,
                        ),
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
            text: "استلام من الفرع",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(onConfirm: () async {
                  final cubit = context.read<DeliveryMaintenanceCubit>();
                  try {
                    await cubit.updateOrderMaintenance(
                        orderMaintenancId: widget.orderMaintenancId, status: 7);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CurrentMaintenanceOrdersDetailsScreen(
                          handReceiptId: widget.handReceiptId,
                          orderMaintenancId: widget.orderMaintenancId,
                        ),
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
    } else if (status == 7) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "إرجاع للعميل",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(onConfirm: () async {
                  final cubit = context.read<DeliveryMaintenanceCubit>();
                  try {
                    await cubit.updateOrderMaintenance(
                        orderMaintenancId: widget.orderMaintenancId, status: 8);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CurrentMaintenanceOrdersDetailsScreen(
                          handReceiptId: widget.handReceiptId,
                          orderMaintenancId: widget.orderMaintenancId,
                        ),
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
    } else if (status == 8) {
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
                    await cubit.updateOrderMaintenance(
                        orderMaintenancId: widget.orderMaintenancId, status: 9);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CurrentMaintenanceOrdersDetailsScreen(
                          handReceiptId: widget.handReceiptId,
                          orderMaintenancId: widget.orderMaintenancId,
                        ),
                      ),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CurrentTakeOrderMaintenanceScreen(),
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
    }

    return [];
  }
}

class ShowDilogDeliveringOrderToBranch extends StatelessWidget {
  final int? orderMaintenanceId;
  const ShowDilogDeliveringOrderToBranch({super.key, this.orderMaintenanceId});

  @override
  Widget build(BuildContext context) {
    context.read<DeliveryMaintenanceCubit>().fetchBranch();
    print(orderMaintenanceId);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              margin: const EdgeInsets.only(bottom: 15, top: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            alignment: Alignment.topRight,
            child: const CustomStyledText(
              text: 'توصيل الطلب للفرع',
              fontSize: 20,
              textColor: AppColors.secondaryColor,
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.grey,
            height: 0.5,
          ),
        ],
      ),
      content: SizedBox(
        height: 200,
        width: 300,
        child: BlocBuilder<DeliveryMaintenanceCubit, DeliveryMaintenanceState>(
          builder: (context, state) {
            if (state.deliveryMaintenanceStatus ==
                DeliveryMaintenanceStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.deliveryMaintenanceStatus ==
                DeliveryMaintenanceStatus.failure) {
              return const Center(child: Text('فشلت العملية'));
            } else if (state.deliveryMaintenanceStatus ==
                DeliveryMaintenanceStatus.success) {
              final branches = state.branch;
              return ListView.builder(
                itemCount: branches.length,
                itemBuilder: (context, index) {
                  final branch = branches[index];
                  return Card(
                    elevation: 0,
                    child: ListTile(
                      title: CustomStyledText(text: branch.name),
                      onTap: () async {
                        final branchId = branch.id;
                        await context
                            .read<DeliveryMaintenanceCubit>()
                            .selectBranch(
                                orderMaintenancId: orderMaintenanceId!,
                                branchId: branchId);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CurrentTakeOrderMaintenanceScreen(),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            return const Center(child: CustomStyledText(text: 'لا توجد فروع'));
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[500],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const CustomStyledText(
            text: "إلغاء",
          ),
        ),
      ],
    );
  }
}
