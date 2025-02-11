// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customInputDialog.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/maintenance_parts/maintenance_parts_model.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/maintenance_parts/maintenance_parts_entitie.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/maintenance_parts/maintenance_parts_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/state/handReceipt_state.dart';

class MaintenancePartsDetailsPage extends StatefulWidget {
  final int partId;
  final HandReceiptEntity item;

  const MaintenancePartsDetailsPage(
      {super.key, required this.partId, required this.item});

  @override
  State<MaintenancePartsDetailsPage> createState() =>
      _MaintenancePartsDetailsPageState();
}

class _MaintenancePartsDetailsPageState
    extends State<MaintenancePartsDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<HandReceiptCubit>().getHandReceiptItem(widget.partId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarApplicationArrow(
          text: "تفاصيل القطعة ",
        ),
        body: BlocBuilder<HandReceiptCubit, HandReceiptState>(
          builder: (context, state) {
            final handReceiptItem = state.handReceiptItem;
            if (state.handReceiptStatus == HandReceiptStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.handReceiptStatus == HandReceiptStatus.failure) {
              return const Center(child: Text('فشلت العملية'));
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
                            buildTableRow('رقم القطعة', widget.partId),
                            buildTableRow(
                                'اسم العميل', handReceiptItem!.customer!.name),
                            buildTableRow(
                                'الحالة',
                                handReceiptItem
                                        .maintenanceRequestStatusMessage ??
                                    ""),
                            buildTableRow('رقم العميل',
                                handReceiptItem.customer!.phoneNumber),
                            buildTableRow('اسم القطعة', handReceiptItem.item!),
                            buildTableRow(
                                'الشركة', handReceiptItem.company ?? ""),
                            buildTableRow('اللون', handReceiptItem.color ?? ""),
                            buildTableRow(
                                'الوصف', handReceiptItem.description!),
                            buildTableRow('يتطلب إبلاغ العميل بالتكلفة؟',
                                handReceiptItem.costNotifiedToTheCustomer!),
                            buildTableRow('مستعجل', handReceiptItem.urgent!),
                            buildTableRow('عدد أيام الضمان',
                                handReceiptItem.warrantyDaysNumber!),
                          ],
                        ),
                        AppSizedBox.kVSpace20,
                        buildButtonWidget(context)
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

  Widget getStatusWidget(OrderStatus status) {
    return BlocBuilder<HandReceiptCubit, HandReceiptState>(
      builder: (context, state) {
        if (state.handReceiptStatus == HandReceiptStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.handReceiptStatus == HandReceiptStatus.failure) {
          return const Center(child: Text('فشلت العملية'));
        }
        if (state.handReceiptStatus == HandReceiptStatus.success) {
          final handReceiptItem = state.handReceiptItem;
          return Container(
            decoration: BoxDecoration(
              color: getColor(handReceiptItem!.maintenanceRequestStatus!),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 2,
              ),
              child: Center(
                child: CustomStyledText(
                  text: getText(handReceiptItem.maintenanceRequestStatus!),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
        return const Center(
            child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
      },
    );
  }

  Widget buildButtonWidget(BuildContext context) {
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
                  return const Center(child: Text('فشلت العملية'));
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
                        ...getItemsBasedOnStatus(context,
                            handReceiptItem!.maintenanceRequestStatus!),
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
        child: Container(
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
      ),
    );
  }

  List<Widget> getItemsBasedOnStatus(BuildContext context, int status) {
    if (status != 14) {
      ListTile(
        title: const CustomStyledText(
          text: 'سبب تعليق',
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
                    return 'عفوا.تعليق مطلوب';
                  }
                  return null;
                },
                onConfirm: () {}, // SuspenseMaintenanceForHandReceiptItem
              );
            },
          );
        },
      );
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

                      Navigator.of(context).pop();
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
                          Navigator.of(context).pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('فشل في تحديد العطل: $e')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('الرجاء إدخال الوصف')),
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
      } else if (status == 3 &&
          widget.item.notifyCustomerOfTheCost!) //DefineMalfunction
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
                        await cubit.updateStatusForHandReceiptItem(
                            receiptItemId: widget.partId);

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
      } else if (status == 3 &&
          // ignore: dead_code
          !widget.item.notifyCustomerOfTheCost!)
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
                        await cubit.updateStatusForHandReceiptItem(
                            receiptItemId: widget.partId, status: 11);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
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
              text: "إبلاغ العميل بالتكلفة",
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ShowDilogInformCustomerOfTheCost(
                      status: widget.item.maintenanceRequestStatus!,
                      receiptItemId: widget.partId);
                },
              );
            },
          ),
        ];
      } else if (status == 7) {
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
                      final cubit = context.read<HandReceiptCubit>();
                      try {
                        await cubit.updateStatusForHandReceiptItem(
                            receiptItemId: widget.partId, status: 7);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
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
      } else if (status == 5 &&
          widget.item.notifyCustomerOfTheCost!) //CustomerApproved
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
                              warrantyDaysNumber:
                                  widget.item.warrantyDaysNumber!,
                            );

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
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
      } else if ((status == 5 && !widget.item.notifyCustomerOfTheCost!) ||
          status == 10) {
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
                        await cubit.updateStatusForHandReceiptItem(
                            receiptItemId: widget.partId);

                        Navigator.of(context).pop();
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
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
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
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
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
      } else {
        return [
          ListTile(
            title: const CustomStyledText(
              text: 'التعليق',
              fontSize: 20,
            ),
            onTap: () {},
          ),
        ];
      }
    } else {
      return [
        ListTile(
          title: const CustomStyledText(
            text: 'فك تعليق',
            fontSize: 20,
          ),
          onTap: () {
            // ReOpenMaintenanceForHandReceiptItem
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(
                  onConfirm: () {},
                );
              },
            );
          },
        ),
      ];
    }
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
            if (widget.status == 5) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<HandReceiptCubit>();
                      try {
                        await cubit.updateStatusForHandReceiptItem(
                            receiptItemId: widget.receiptItemId, status: 5);

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
            } else if (widget.status == 6) {
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
            } else if (widget.status == 7) //NoResponseFromTheCustomer
            {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () async {
                      final cubit = context.read<HandReceiptCubit>();
                      try {
                        await cubit.updateStatusForHandReceiptItem(
                          receiptItemId: widget.receiptItemId,
                          status: 7,
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
