// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customInputDialog.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/maintenance_parts/maintenance_parts_model.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/cubit/recovered_maintenance_parts/recovered_maintenance_parts_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/recovered_maintenance_parts/recovered_maintenance_parts_page.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/state/returnHandReceipt_state.dart';

class RecoveredMaintenancePartsDetailsPage extends StatefulWidget {
  final int partId;

  const RecoveredMaintenancePartsDetailsPage({super.key, required this.partId});
  @override
  State<RecoveredMaintenancePartsDetailsPage> createState() =>
      _RecoveredMaintenancePartsDetailsPageState();
}

class _RecoveredMaintenancePartsDetailsPageState
    extends State<RecoveredMaintenancePartsDetailsPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<ReturnHandReceiptCubit>()
        .getReturnHandReceiptItem(widget.partId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarApplicationArrow(
          text: "تفاصيل القطعة ",
        ),
        body: BlocBuilder<ReturnHandReceiptCubit, ReturnHandReceiptState>(
          builder: (context, state) {
            if (state.returnHandReceiptStatus ==
                ReturnHandReceiptStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.returnHandReceiptStatus ==
                ReturnHandReceiptStatus.failure) {
              return const Center(child: Text('فشلت العملية'));
            }
            if (state.returnHandReceiptStatus ==
                ReturnHandReceiptStatus.success) {
              final handReceiptItem = state.returnHandReceiptItem;

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
                                handReceiptItem?.customer?.phoneNumber ??
                                    "غير متوفر"),
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
                                'عدد أيام الضمان',
                                handReceiptItem?.collectedAmount?.toString() ??
                                    "غير متوفر"),
                            buildTableRow(
                                'عدد أيام الضمان',
                                handReceiptItem?.collectionDate?.toString() ??
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
                                17) ...[
                              buildOperationsButtonWidget(context),
                              AppSizedBox.kWSpace10,
                              buildSuspensButtonWidget(context),
                            ] else if (handReceiptItem
                                    .maintenanceRequestStatus ==
                                17) ...[
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
            return BlocBuilder<ReturnHandReceiptCubit, ReturnHandReceiptState>(
              builder: (context, state) {
                if (state.returnHandReceiptStatus ==
                    ReturnHandReceiptStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.returnHandReceiptStatus ==
                    ReturnHandReceiptStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.returnHandReceiptStatus ==
                    ReturnHandReceiptStatus.success) {
                  final handReceiptItem = state.returnHandReceiptItem;
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
                            handReceiptItem.warrantyDaysNumber!,
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
            return BlocBuilder<ReturnHandReceiptCubit, ReturnHandReceiptState>(
              builder: (context, state) {
                if (state.returnHandReceiptStatus ==
                    ReturnHandReceiptStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.returnHandReceiptStatus ==
                    ReturnHandReceiptStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.returnHandReceiptStatus ==
                    ReturnHandReceiptStatus.success) {
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
            return BlocBuilder<ReturnHandReceiptCubit, ReturnHandReceiptState>(
              builder: (context, state) {
                if (state.returnHandReceiptStatus ==
                    ReturnHandReceiptStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.returnHandReceiptStatus ==
                    ReturnHandReceiptStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.returnHandReceiptStatus ==
                    ReturnHandReceiptStatus.success) {
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
                    .read<ReturnHandReceiptCubit>()
                    .reopenMaintenanceForReturnHandReceiptItem(
                      receiptItemId: widget.partId,
                    );
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecoveredMaintenancePartsDetailsPage(
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
                      .read<ReturnHandReceiptCubit>()
                      .suspendReturnMaintenanceForReceiptItem(
                          receiptItemId: widget.partId,
                          suspensionReason: suspensionReason);

                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RecoveredMaintenancePartsDetailsPage(
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
    if (status != 17) {
      if (status == 4) // new
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
                    final cubit = context.read<ReturnHandReceiptCubit>();
                    try {
                      await cubit.updateReturnStatusForReceiptItem(
                          receiptItemId: widget.partId, status: 2);
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecoveredMaintenancePartsDetailsPage(
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
      } else if (status == 5) // CheckItem
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomInputDialog(
                    titleDialog: 'تحديد العطل',
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
                              .read<ReturnHandReceiptCubit>()
                              .defineReturnMalfunctionForReceiptItem(
                                receiptItemId: widget.partId,
                                description: descriptionController.text,
                              );
                          Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RecoveredMaintenancePartsDetailsPage(
                                      partId: widget.partId),
                            ),
                          );
                        } catch (e) {
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
                      final cubit = context.read<ReturnHandReceiptCubit>();
                      try {
                        await cubit.updateReturnStatusForReceiptItem(
                            receiptItemId: widget.partId, status: 8);
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecoveredMaintenancePartsDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                        Navigator.of(context).pop();
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
      } else if (status == 6 && notifyCustomerOfTheCost!) //DefineMalfunction
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
                      final cubit = context.read<ReturnHandReceiptCubit>();
                      try {
                        await cubit.updateReturnStatusForReceiptItem(
                            receiptItemId: widget.partId);
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecoveredMaintenancePartsDetailsPage(
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
      } else if (status == 6 &&
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
                      final cubit = context.read<ReturnHandReceiptCubit>();
                      try {
                        await cubit.updateReturnStatusForReceiptItem(
                            receiptItemId: widget.partId, status: 11);
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecoveredMaintenancePartsDetailsPage(
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
      } else if (status == 7) {
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
                  return ShowDilogInformCustomerOfTheCost(
                      status: maintenanceRequestStatus!,
                      receiptItemId: widget.partId);
                },
              );
            },
          ),
        ];
      } else if (status == 10) {
        return [
          ListTile(
            title: const CustomStyledText(
              text: "لا يوجد استجابة من العميل",
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<ReturnHandReceiptCubit>();
                      try {
                        await cubit.updateReturnStatusForReceiptItem(
                            receiptItemId: widget.partId, status: 7);
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecoveredMaintenancePartsDetailsPage(
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
      } else if (status == 8 && notifyCustomerOfTheCost!) //CustomerApproved
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
                            .read<ReturnHandReceiptCubit>()
                            .enterReturnMaintenanceCostForItem(
                              receiptItemId: widget.partId,
                              costNotifiedToTheCustomer: price,
                              warrantyDaysNumber: warrantyDaysNumber!,
                            );

                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecoveredMaintenancePartsDetailsPage(
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
      } else if ((status == 8 && !notifyCustomerOfTheCost!) || status == 10) {
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
                      final cubit = context.read<ReturnHandReceiptCubit>();
                      try {
                        await cubit.updateReturnStatusForReceiptItem(
                            receiptItemId: widget.partId);
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecoveredMaintenancePartsDetailsPage(
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
      } else if (status == 14) {
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
                      final cubit = context.read<ReturnHandReceiptCubit>();
                      try {
                        await cubit.updateReturnStatusForReceiptItem(
                            receiptItemId: widget.partId, status: 12);
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecoveredMaintenancePartsDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const RecoveredMaintenancePartsPage(),
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
      } else if (status == 11) {
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
                      final cubit = context.read<ReturnHandReceiptCubit>();
                      try {
                        await cubit.updateReturnStatusForReceiptItem(
                            receiptItemId: widget.partId, status: 9);
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecoveredMaintenancePartsDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const RecoveredMaintenancePartsPage(),
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

class ShowDilogInformCustomerOfTheCost extends StatefulWidget {
  final int status;
  final int receiptItemId;
  const ShowDilogInformCustomerOfTheCost({
    super.key,
    required this.status,
    required this.receiptItemId,
  });

  @override
  State<ShowDilogInformCustomerOfTheCost> createState() =>
      _ShowDilogInformCustomerOfTheCostState();
}

class _ShowDilogInformCustomerOfTheCostState
    extends State<ShowDilogInformCustomerOfTheCost> {
  StatusEnum? statusEnum = StatusEnum.EnterMaintenanceCost;

  @override
  Widget build(BuildContext context) {
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
              text: 'اختر العملية',
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
        height: 150,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio<StatusEnum>(
                  value: StatusEnum.CustomerApproved,
                  groupValue: statusEnum,
                  onChanged: (StatusEnum? value) {
                    setState(() {
                      statusEnum = value;
                    });
                  },
                  fillColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.secondaryColor;
                      }
                      return Colors.grey;
                    },
                  ),
                ),
                const CustomStyledText(
                  text: 'موافقة العميل',
                  fontSize: 17,
                ),
              ],
            ), // UpdateStatusForHandReceiptItem '&Status=5
            Row(
              children: [
                Radio<StatusEnum>(
                  value: StatusEnum.CustomerRefused,
                  groupValue: statusEnum,
                  onChanged: (StatusEnum? value) {
                    setState(() {
                      statusEnum = value;
                    });
                  },
                  fillColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.secondaryColor;
                      }
                      return Colors.grey;
                    },
                  ),
                ),
                const CustomStyledText(
                  text: 'رفض العميل',
                  fontSize: 17,
                ),
              ],
            ), //CustomerRefuseMaintenanceForHandReceiptItem
            Row(
              children: [
                Radio<StatusEnum>(
                  value: StatusEnum.NoResponseFromTheCustomer,
                  groupValue: statusEnum,
                  onChanged: (StatusEnum? value) {
                    setState(() {
                      statusEnum = value;
                    });
                  },
                  fillColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.secondaryColor;
                      }
                      return Colors.grey;
                    },
                  ),
                ),
                const CustomStyledText(
                  text: 'لا يوجد رد من العميل',
                  fontSize: 17,
                ),
              ],
            ), // UpdateStatusForHandReceiptItem '&Status=7 // بدي احط حالتين موافقة العميل ورفض
          ],
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
        TextButton(
          onPressed: () {
            if (widget.status == 8) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<ReturnHandReceiptCubit>();
                      try {
                        await cubit.updateReturnStatusForReceiptItem(
                            receiptItemId: widget.receiptItemId, status: 5);

                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecoveredMaintenancePartsDetailsPage(
                                    partId: widget.receiptItemId),
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
            } else if (widget.status == 9) {
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
            } else if (widget.status == 10) //NoResponseFromTheCustomer
            {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<ReturnHandReceiptCubit>();
                      try {
                        await cubit.updateReturnStatusForReceiptItem(
                          receiptItemId: widget.receiptItemId,
                          status: 7,
                        );
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecoveredMaintenancePartsDetailsPage(
                                    partId: widget.receiptItemId),
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
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: AppColors.secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const CustomStyledText(text: "تأكيد", textColor: Colors.white),
        ),
      ],
    );
  }
}
