// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/services.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customInputDialog.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/showTopSnackBar.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/hand_receip_maintenance_parts/hand_receipt_model.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/cubit/hand_receipt_maintenance_parts/maintenance_parts_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/maintenance_parts_hand_receipt/maintenance_parts_screen.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/state/handReceipt_state.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/transferred_maintenance_parts/transferred_maintenance_parts_screen.dart';

class TransferredMaintenancePartsDetailsPage extends StatefulWidget {
  final int partId;

  const TransferredMaintenancePartsDetailsPage(
      {super.key, required this.partId});

  @override
  State<TransferredMaintenancePartsDetailsPage> createState() =>
      _TransferredMaintenancePartsDetailsPageState();
}

class _TransferredMaintenancePartsDetailsPageState
    extends State<TransferredMaintenancePartsDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<HandReceiptCubit>().getHandReceiptItem(widget.partId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarApplicationArrow(
          text: "تفاصيل القطعة ",
          onBackTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TransferredMaintenancePartsPage(),
              ),
            );
          },
        ),
        body: BlocBuilder<HandReceiptCubit, HandReceiptState>(
          builder: (context, state) {
            final handReceiptItem = state.handReceiptItem;
            if (state.handReceiptStatus == HandReceiptStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.handReceiptStatus == HandReceiptStatus.failure) {
              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            if (state.handReceiptStatus == HandReceiptStatus.success) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(2),
                          },
                          border: TableBorder.all(
                              color: Colors.grey,
                              width: 1,
                              borderRadius: BorderRadius.circular(15)),
                          children: [
                            buildTableRow(
                                'رقم القطعة', widget.partId.toString()),
                            buildTableRow('اسم العميل',
                                handReceiptItem?.customer?.name ?? "غير متوفر"),
                            buildTableRow(
                              'رقم العميل',
                              InkWell(
                                onLongPress: () {
                                  String phoneNumber =
                                      handReceiptItem?.customer?.phoneNumber ??
                                          "";
                                  if (phoneNumber.isNotEmpty &&
                                      phoneNumber != "غير متوفر") {
                                    Clipboard.setData(
                                        ClipboardData(text: phoneNumber));
                                    showTopSnackBar(
                                        context,
                                        'تم نسخ رقم العميل',
                                        Colors.green.shade800);
                                  }
                                },
                                child: CustomStyledText(
                                  text:
                                      handReceiptItem?.customer?.phoneNumber ??
                                          "",
                                ),
                              ),
                            ),
                            buildTableRow('اسم القطعة',
                                handReceiptItem?.item ?? "غير متوفر"),
                            buildTableRow('الشركة',
                                handReceiptItem?.company ?? "غير متوفر"),
                            buildTableRow(
                                'اللون', handReceiptItem?.color ?? "غير متوفر"),
                            buildTableRow('الوصف',
                                handReceiptItem?.description ?? "غير متوفر"),
                            buildTableRow(
                                'عدد أيام الضمان',
                                handReceiptItem?.warrantyDaysNumber
                                        ?.toString() ??
                                    "غير متوفر"),
                            buildTableRow(
                                'الباركود',
                                handReceiptItem?.itemBarcode?.toString() ??
                                    "غير متوفر"),
                            buildTableRow(
                                'السعر',
                                handReceiptItem?.specifiedCost?.toString() ??
                                    "غير متوفر"),
                            buildTableRow(
                                'مستعجل',
                                handReceiptItem?.urgent?.toString() ??
                                    "غير متوفر"),
                          ],
                        ),
                        AppSizedBox.kVSpace20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (handReceiptItem!.maintenanceRequestStatus !=
                                14) ...[
                              buildOperationsButtonWidget(context),
                              AppSizedBox.kWSpace10,
                              buildSuspensButtonWidget(context),
                            ] else if (handReceiptItem
                                    .maintenanceRequestStatus ==
                                14) ...[
                              buildReopenButtonWidget(context)
                            ]
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Center(
                child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
          },
        ));
  }

  TableRow buildTableRow(String label, dynamic value) {
    return TableRow(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: CustomStyledText(
              text: label,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: value is Widget
                ? value
                : CustomStyledText(
                    text: value.toString(),
                    fontSize: 16,
                  ),
          ),
        ),
      ],
    );
  }

  Widget buildOperationsButtonWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          builder: (BuildContext context) {
            return BlocBuilder<HandReceiptCubit, HandReceiptState>(
              builder: (context, state) {
                if (state.handReceiptStatus == HandReceiptStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.handReceiptStatus == HandReceiptStatus.failure) {
                  return Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
                if (state.handReceiptStatus == HandReceiptStatus.success) {
                  final handReceiptItem = state.handReceiptItem;
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
                            context,
                            handReceiptItem!.maintenanceRequestStatus!,
                            handReceiptItem.notifyCustomerOfTheCost!,
                            handReceiptItem.warrantyDaysNumber != null
                                ? handReceiptItem.warrantyDaysNumber!
                                : 0,
                            handReceiptItem.maintenanceRequestStatus!),
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

  Widget buildSuspensButtonWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          builder: (BuildContext context) {
            return BlocBuilder<HandReceiptCubit, HandReceiptState>(
              builder: (context, state) {
                if (state.handReceiptStatus == HandReceiptStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.handReceiptStatus == HandReceiptStatus.failure) {
                  return Center(
                      child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ));
                }
                if (state.handReceiptStatus == HandReceiptStatus.success) {
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
                        getSuspendMaintenanceTile(context)
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
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColors.secondaryColor,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.lock,
                      size: 20,
                    ),
                    AppSizedBox.kWSpace10,
                    CustomStyledText(text: "تعليق")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReopenButtonWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          builder: (BuildContext context) {
            return BlocBuilder<HandReceiptCubit, HandReceiptState>(
              builder: (context, state) {
                if (state.handReceiptStatus == HandReceiptStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.handReceiptStatus == HandReceiptStatus.failure) {
                  return Center(
                      child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ));
                }
                if (state.handReceiptStatus == HandReceiptStatus.success) {
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
                        getReopenMaintenanceTile(context)
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
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColors.secondaryColor,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.unlock,
                      size: 20,
                    ),
                    AppSizedBox.kWSpace10,
                    CustomStyledText(text: "فك تعليق")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getReopenMaintenanceTile(BuildContext context) {
    return ListTile(
      title: const CustomStyledText(
        text: 'فك تعليق',
        fontSize: 20,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomSureDialog(
              onConfirm: () async {
                await context
                    .read<HandReceiptCubit>()
                    .reopenMaintenanceHandReceiptItem(
                      receiptItemId: widget.partId,
                    );
                context.read<HandReceiptCubit>().fetchConvertFromBranch(
                      refresh: true,
                    );
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TransferredMaintenancePartsDetailsPage(
                            partId: widget.partId),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget getSuspendMaintenanceTile(BuildContext context) {
    return ListTile(
      title: const CustomStyledText(
        text: 'تعليق',
        fontSize: 20,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomInputDialog(
              titleDialog: 'تحديد سبب تعليق',
              text: 'سبب تعليق:',
              hintText: 'ادخل تعليق',
              validators: (value) {
                if (value == null || value.isEmpty) {
                  return 'عفواً. التعليق مطلوب';
                }
                return null;
              },
              onConfirm: () async {
                String suspensionReason = 'wesam';
                if (suspensionReason.isNotEmpty) {
                  print(widget.partId);
                  await context
                      .read<HandReceiptCubit>()
                      .suspendMaintenanceForHandReceiptItem(
                          receiptItemId: widget.partId,
                          maintenanceSuspensionReason: suspensionReason);
                  context.read<HandReceiptCubit>().fetchConvertFromBranch(
                        refresh: true,
                      );
                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TransferredMaintenancePartsDetailsPage(
                              partId: widget.partId),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }

  List<Widget> getItemsBasedOnStatus(
      BuildContext context,
      int status,
      bool? notifyCustomerOfTheCost,
      int? warrantyDaysNumber,
      int? maintenanceRequestStatus) {
    if (status != 14) {
      if (status == 1) // new
      {
        return [
          ListTile(
            title: const CustomStyledText(
              text: "فحص القطعة",
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(onConfirm: () async {
                    final cubit = context.read<HandReceiptCubit>();
                    try {
                      await cubit.updateStatusForHandReceiptItem(
                          receiptItemId: widget.partId, status: 2);
                      context.read<HandReceiptCubit>().fetchConvertFromBranch(
                            refresh: true,
                          );
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TransferredMaintenancePartsDetailsPage(
                                  partId: widget.partId),
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
      } else if (status == 2) // CheckItem
      {
        return [
          ListTile(
            title: const CustomStyledText(
              text: "تحديد العطل",
              fontSize: 20,
            ),
            onTap: () {
              final TextEditingController descriptionController =
                  TextEditingController();
              final FocusNode _descriptionFocusNode = FocusNode();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomInputDialog(
                    titleDialog: 'تحديد العطل',
                    focusNode: _descriptionFocusNode,
                    text: 'الوصف:',
                    hintText: 'ادخل الوصف',
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.الوصف مطلوب';
                      }
                      return null;
                    },
                    controller: descriptionController,
                    onConfirm: () async {
                      if (descriptionController.text.isNotEmpty) {
                        try {
                          await context
                              .read<HandReceiptCubit>()
                              .defineMalfunctionForHandReceiptItem(
                                receiptItemId: widget.partId,
                                description: descriptionController.text,
                              );
                          context
                              .read<HandReceiptCubit>()
                              .fetchConvertFromBranch(
                                refresh: true,
                              );
                          Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TransferredMaintenancePartsDetailsPage(
                                      partId: widget.partId),
                            ),
                          );
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('فشل في تحديد العطل: $e')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('الرجاء إدخال الوصف')),
                        );
                      }
                    },
                  );
                },
              );
            },
          ),
          ListTile(
            title: const CustomStyledText(
              text: 'لا يمكن صيانة القطعة',
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<HandReceiptCubit>();
                      try {
                        await cubit.updateStatusForHandReceiptItem(
                            receiptItemId: widget.partId, status: 8);
                        context.read<HandReceiptCubit>().fetchConvertFromBranch(
                              refresh: true,
                            );
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransferredMaintenancePartsDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Failed to update status: $e')),
                        );
                      }
                    }, //UpdateStatusForHandReceiptItem
                  );
                },
              );
            },
          ),
        ];
      } else if (status == 3 && notifyCustomerOfTheCost!) //DefineMalfunction
      {
        return [
          ListTile(
            title: const CustomStyledText(
              text: "إبلاغ العميل بالتكلفة",
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<HandReceiptCubit>();
                      try {
                        cubit.updateStatusForHandReceiptItem(
                            receiptItemId: widget.partId, status: 4);
                        context.read<HandReceiptCubit>().fetchConvertFromBranch(
                              refresh: true,
                            );
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransferredMaintenancePartsDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Failed to update status: $e')),
                        );
                      }
                    }, //UpdateStatusForHandReceiptItem
                  );
                },
              );
            },
          ),
        ];
      } else if (status == 3 &&
          // ignore: dead_code
          !notifyCustomerOfTheCost!)
      //DefineMalfunction
      {
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
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<HandReceiptCubit>();
                      try {
                        cubit.updateStatusForHandReceiptItem(
                            receiptItemId: widget.partId, status: 11);
                        context.read<HandReceiptCubit>().fetchConvertFromBranch(
                              refresh: true,
                            );
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransferredMaintenancePartsDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Failed to update status: $e')),
                        );
                      }
                    }, //UpdateStatusForHandReceiptItem
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
              text: "موافقة العميل",
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<HandReceiptCubit>();
                      try {
                        cubit.updateStatusForHandReceiptItem(
                            receiptItemId: widget.partId, status: 5);
                        context.read<HandReceiptCubit>().fetchConvertFromBranch(
                              refresh: true,
                            );
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransferredMaintenancePartsDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Failed to update status: $e')),
                        );
                      }
                    }, //UpdateStatusForHandReceiptItem
                  );
                },
              );
            },
          ),
          ListTile(
            title: const CustomStyledText(
              text: "رفض العميل",
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomInputDialog(
                    titleDialog: 'رفض العميل',
                    text: 'سبب رفض العميل للصيانة:',
                    hintText: 'ادخل سبب رفض العميل للصيانة',
                    // controller: ,
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.سبب مطلوب';
                      }
                      return null;
                    },
                    onConfirm: () {},
                  );
                },
              );
            },
          ),
          ListTile(
            title: const CustomStyledText(
              text: "لم يرد العميل",
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<HandReceiptCubit>();
                      try {
                        cubit.updateStatusForHandReceiptItem(
                          receiptItemId: widget.partId,
                          status: 7,
                        );
                        context.read<HandReceiptCubit>().fetchConvertFromBranch(
                              refresh: true,
                            );
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransferredMaintenancePartsDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Failed to update status: $e')),
                        );
                      }
                    }, //UpdateStatusForHandReceiptItem
                  );
                },
              );
            },
          ),
        ];
      } else if (status == 7) {
        return [
          ListTile(
            title: const CustomStyledText(
              text: "موافقة العميل",
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<HandReceiptCubit>();
                      try {
                        await cubit.updateStatusForHandReceiptItem(
                            receiptItemId: widget.partId, status: 5);
                        context.read<HandReceiptCubit>().fetchConvertFromBranch(
                              refresh: true,
                            );
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransferredMaintenancePartsDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Failed to update status: $e')),
                        );
                      }
                    }, //UpdateStatusForHandReceiptItem
                  );
                },
              );
            },
          ),
          ListTile(
            title: const CustomStyledText(
              text: "رفض العميل",
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm:
                        () {}, //CustomerRefuseMaintenanceForHandReceiptItem
                  );
                },
              );
            },
          ),
        ];
      } else if (status == 5 && notifyCustomerOfTheCost!) //CustomerApproved
      {
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
                    onConfirm: () async {
                      if (priceController.text.isNotEmpty) {
                        final double price =
                            double.tryParse(priceController.text) ?? 0.0;

                        await context
                            .read<HandReceiptCubit>()
                            .enterMaintenanceCostForHandReceiptItem(
                              receiptItemId: widget.partId,
                              costNotifiedToTheCustomer: price,
                              warrantyDaysNumber: warrantyDaysNumber ?? 0,
                            );

                        context.read<HandReceiptCubit>().fetchConvertFromBranch(
                              refresh: true,
                            );
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransferredMaintenancePartsDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
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
      } else if ((status == 5 && !notifyCustomerOfTheCost!) || status == 10) {
        return [
          ListTile(
            title: const CustomStyledText(
              text: 'مكتمل',
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<HandReceiptCubit>();
                      try {
                        cubit.updateStatusForHandReceiptItem(
                            receiptItemId: widget.partId, status: 11);
                        context.read<HandReceiptCubit>().fetchConvertFromBranch(
                              refresh: true,
                            );
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransferredMaintenancePartsDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Failed to update status: $e')),
                        );
                      }
                    },
                  );
                },
              );
            },
          ),
        ];

        ///UpdateStatusForHandReceiptItem
      } else if (status == 11) {
        return [
          ListTile(
            title: const CustomStyledText(
              text: 'ابلاغ العميل بانتهاء الصيانة',
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<HandReceiptCubit>();
                      try {
                        await cubit.updateStatusForHandReceiptItem(
                            receiptItemId: widget.partId, status: 12);
                        context.read<HandReceiptCubit>().fetchConvertFromBranch(
                              refresh: true,
                            );
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransferredMaintenancePartsDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const TransferredMaintenancePartsPage(),
                          ),
                        );
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Failed to update status: $e')),
                        );
                      }
                    }, //UpdateStatusForHandReceiptItem
                  );
                },
              );
            },
          ),
        ];
      } else if (status == 8) {
        return [
          ListTile(
            title: const CustomStyledText(
              text: 'ابلاغ العميل بعدم امكانية صيانة',
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<HandReceiptCubit>();
                      try {
                        await cubit.updateStatusForHandReceiptItem(
                            receiptItemId: widget.partId, status: 9);
                        context.read<HandReceiptCubit>().fetchConvertFromBranch(
                              refresh: true,
                            );
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransferredMaintenancePartsDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const TransferredMaintenancePartsPage(),
                          ),
                        );
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Failed to update status: $e')),
                        );
                      }
                    }, //UpdateStatusForHandReceiptItem
                  );
                },
              );
            },
          ),
        ];
      }
      return [];
    }
    return [];
  }
}
