import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/services/telr_service_xml.dart';
import 'package:maintenance_app/src/core/services/telr_service_xml_order.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customInputDialog.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/orders_maintenance/maintenance_requests_for_approval_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/webviwe/telr_order_maintenace_payment_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/webviwe/telr_payment_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/order_maintenances_details_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';

class MaintenanceOrdersDetailsScreen extends StatefulWidget {
  final int handReceiptId;
  final int orderMaintenancId;
  final bool isTab;
  final bool? isPayid;

  final int? total;

  const MaintenanceOrdersDetailsScreen(
      {Key? key,
      required this.handReceiptId,
      required this.orderMaintenancId,
      required this.isTab,
      this.isPayid,
      this.total})
      : super(key: key);

  @override
  State<MaintenanceOrdersDetailsScreen> createState() =>
      _MaintenanceOrdersDetailsScreenState();
}

final TextEditingController desController = TextEditingController();

class _MaintenanceOrdersDetailsScreenState
    extends State<MaintenanceOrdersDetailsScreen> {
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
          if (widget.isTab) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrdersMaintenancePage(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const MaintenanceRequestsForApprovalScreen(),
              ),
            );
          }
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
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.selectedOrderDetilesItems.length,
                  itemBuilder: (context, index) {
                    final ordersCurrent =
                        state.selectedOrderDetilesItems[index];
                    return _buildOrderItem(context, ordersCurrent);
                  },
                ),
                if (state.selectedOrderDetilesItems[0].orderStatus == 5 &&
                    widget.isPayid == false)
                  isPadButton(context)
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
                                    text: orderItem.item ?? "غير محدد",
                                    fontSize: 18,
                                    textColor: AppColors.lightGrayColor,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: getStatusOrderColor(
                                          orderItem.maintenanceRequestStatus!),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 10),
                                      child: CustomStyledText(
                                        text: getStatusOrder(orderItem
                                            .maintenanceRequestStatus!),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                                            "لون القطعة: ${orderItem.color ?? "غير محدد"}",
                                        fontSize: 14,
                                      ),
                                      CustomStyledText(
                                        text:
                                            "الشركة: ${orderItem.company ?? "غير محدد"}",
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                  CustomStyledText(
                                    text:
                                        "الوصف: ${orderItem.description ?? "غير محدد"}",
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ),
                            orderItem.maintenanceRequestStatus == 4
                                ? buildProccesOrderButtonWidget(
                                    context,
                                  )
                                : const SizedBox.shrink(),
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

  Widget buildProccesOrderButtonWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final TextEditingController desController = TextEditingController();
        bool isApproved = true;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const CustomStyledText(
                        text: 'هل تريد الموافقة على الطلب؟',
                        fontSize: 18,
                        textColor: AppColors.secondaryColor,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: double.infinity,
                        color: Colors.grey,
                        height: 0.5,
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectableOption(
                            text: 'موافقة',
                            isActive: isApproved,
                            width: 120,
                            onTap: () {
                              setState(() {
                                isApproved = true;
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          SelectableOption(
                            text: 'رفض',
                            isActive: !isApproved,
                            width: 120,
                            onTap: () {
                              setState(() {
                                isApproved = false;
                              });
                            },
                          ),
                        ],
                      ),
                      if (isApproved == false)
                        Column(
                          children: [
                            AppSizedBox.kVSpace20,
                            SizedBox(
                              height: 190,
                              width: 350,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomStyledText(
                                    text: 'سبب الرفض',
                                    fontSize: 17,
                                  ),
                                  AppSizedBox.kVSpace10,
                                  Texteara(
                                    hintText: 'ادخل سبب الرفض',
                                    validators: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'عفوا.سبب مطلوب';
                                      }
                                      return null;
                                    },
                                    controller: desController,
                                  ),
                                  AppSizedBox.kVSpace10,
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
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
                    TextButton(
                      onPressed: () async {
                        final reason = desController.text.trim();

                        if (!isApproved && reason.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: CustomStyledText(
                                    text: 'الرجاء إدخال سبب الرفض')),
                          );
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: CustomStyledText(
                              text: isApproved
                                  ? 'تمت الموافقة على الطلب بنجاح'
                                  : 'تم رفض الطلب مع السبب: $reason',
                            ),
                            backgroundColor:
                                isApproved ? Colors.green : Colors.red,
                            duration: const Duration(seconds: 2),
                          ),
                        );

                        Future.delayed(const Duration(milliseconds: 500));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MaintenanceOrdersDetailsScreen(
                              handReceiptId: widget.handReceiptId,
                              orderMaintenancId: widget.orderMaintenancId,
                              isTab: false,
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const CustomStyledText(
                        text: "تأكيد",
                        textColor: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
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

  Widget isPadButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FutureBuilder<String?>(
              future: TelrServiceXMLOrder.createPayment(widget.total!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  return TelrPaymentScreen(
                    paymentUrl: snapshot.data!,
                  );
                } else {
                  return const Center(child: Text('Payment creation failed'));
                }
              },
            ),
          ),
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
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const CustomStyledText(
                          text: 'دفع سعر الصيانة',
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

  String getStatusOrder(int orderStatus) {
    return OrderMaintenanceStatus.values[orderStatus - 1].nameAr.toString();
  }

  Color getStatusOrderColor(int orderStatus) {
    return OrderMaintenanceStatus.values[orderStatus - 1].statusColor;
  }
}

class SelectableOption extends StatelessWidget {
  final String text;
  final double width;
  final bool isActive;
  final Function() onTap;

  const SelectableOption(
      {required this.text,
      required this.isActive,
      required this.onTap,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          border: Border.all(
              color: isActive
                  ? AppColors.secondaryColor
                  : Colors.grey.withOpacity(0.2),
              width: 1.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: CustomStyledText(
            text: text,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
