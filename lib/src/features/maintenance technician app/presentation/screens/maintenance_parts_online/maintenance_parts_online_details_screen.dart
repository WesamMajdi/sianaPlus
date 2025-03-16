// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customInputDialog.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/cubit/online_maintenance_parts/online_maintenance_parts_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/state/online_state.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/maintenance_parts_hand_receipt/maintenance_parts_screen.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/maintenance_parts_online/maintenance_parts_online_screen.dart';

class MaintenancePartsOnlineDetailsPage extends StatefulWidget {
  final int partId;

  const MaintenancePartsOnlineDetailsPage({super.key, required this.partId});

  @override
  State<MaintenancePartsOnlineDetailsPage> createState() =>
      _MaintenancePartsOnlineDetailsPageState();
}

class _MaintenancePartsOnlineDetailsPageState
    extends State<MaintenancePartsOnlineDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnlineCubit>().getOnlineItem(widget.partId);
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
                builder: (context) => const MaintenancePartsOnlinePage(),
              ),
            );
          },
        ),
        body: BlocBuilder<OnlineCubit, OnlineState>(
          builder: (context, state) {
            final onlineItem = state.onlineItem;
            if (state.onlineStatus == OnlineStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.onlineStatus == OnlineStatus.failure) {
              return const Center(child: Text('فشلت العملية'));
            }
            if (state.onlineStatus == OnlineStatus.success) {
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
                                onlineItem?.customer?.name ?? "غير متوفر"),
                            buildTableRow(
                                'رقم العميل',
                                onlineItem?.customer?.phoneNumber ??
                                    "غير متوفر"),
                            buildTableRow(
                                'اسم القطعة', onlineItem?.item ?? "غير متوفر"),
                            buildTableRow(
                                'الشركة', onlineItem?.company ?? "غير متوفر"),
                            buildTableRow(
                                'اللون', onlineItem?.color ?? "غير متوفر"),
                            buildTableRow('الوصف',
                                onlineItem?.description ?? "غير متوفر"),
                            buildTableRow(
                                'عدد أيام الضمان',
                                onlineItem?.warrantyDaysNumber?.toString() ??
                                    "غير متوفر"),
                            buildTableRow('مستعجل',
                                onlineItem?.urgent?.toString() ?? "غير متوفر"),
                          ],
                        ),
                        AppSizedBox.kVSpace20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (onlineItem!.maintenanceRequestStatus != 14) ...[
                              buildOperationsButtonWidget(context),
                              AppSizedBox.kWSpace10,
                              buildSuspensButtonWidget(context),
                            ] else if (onlineItem.maintenanceRequestStatus ==
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
            return BlocBuilder<OnlineCubit, OnlineState>(
              builder: (context, state) {
                if (state.onlineStatus == OnlineStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.onlineStatus == OnlineStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.onlineStatus == OnlineStatus.success) {
                  final onlineItem = state.onlineItem;
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
                            onlineItem!.maintenanceRequestStatus!,
                            onlineItem.notifyCustomerOfTheCost!,
                            onlineItem.warrantyDaysNumber != null
                                ? onlineItem.warrantyDaysNumber!
                                : 0,
                            onlineItem.maintenanceRequestStatus!),
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
            return BlocBuilder<OnlineCubit, OnlineState>(
              builder: (context, state) {
                if (state.onlineStatus == OnlineStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.onlineStatus == OnlineStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.onlineStatus == OnlineStatus.success) {
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
            return BlocBuilder<OnlineCubit, OnlineState>(
              builder: (context, state) {
                if (state.onlineStatus == OnlineStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.onlineStatus == OnlineStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.onlineStatus == OnlineStatus.success) {
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
                await context.read<OnlineCubit>().reopenMaintenanceOnlineItem(
                      receiptItemId: widget.partId,
                    );
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) => MaintenancePartsOnlineDetailsPage(
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
                      .read<OnlineCubit>()
                      .suspendMaintenanceForOnlineItem(
                          receiptItemId: widget.partId,
                          maintenanceSuspensionReason: suspensionReason);

                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => MaintenancePartsOnlineDetailsPage(
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
    print(status);
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
                    final cubit = context.read<OnlineCubit>();
                    try {
                      await cubit.updateStatusForOnlineItem(
                          receiptItemId: widget.partId, status: 2);
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MaintenancePartsOnlineDetailsPage(
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
                              .read<OnlineCubit>()
                              .defineMalfunctionForOnlineItem(
                                receiptItemId: widget.partId,
                                description: descriptionController.text,
                              );
                          Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MaintenancePartsOnlineDetailsPage(
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
                      final cubit = context.read<OnlineCubit>();
                      try {
                        await cubit.updateStatusForOnlineItem(
                            receiptItemId: widget.partId, status: 8);
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MaintenancePartsOnlineDetailsPage(
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
                    }, //UpdateStatusForonlineItem
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
              text: "ادخال التكلفة",
              fontSize: 20,
            ),
            onTap: () {
              final TextEditingController costController =
                  TextEditingController();
              final TextEditingController warrantyDaysNumberController =
                  TextEditingController();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomInputCostDialog(
                    titleDialog: 'تكلفة الصيانة',
                    text: 'التكلفة التي يتم ابلاغ العميل بها:',
                    icon: Icons.price_change,
                    hintText: 'ادخل التكلفة',
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.التكلفة مطلوب';
                      }
                      return null;
                    },
                    text2: "عدد أيام الضمان",
                    icon2: Icons.date_range,
                    controller: costController,
                    controller2: warrantyDaysNumberController,
                    hintText2: "ادخل عدد ايام الضمانة",
                    onConfirm: () async {
                      if (costController.text.isNotEmpty) {
                        try {
                          await context
                              .read<OnlineCubit>()
                              .enterMaintenanceCostForOnlinetItem(
                                receiptItemId: widget.partId,
                                costNotifiedToTheCustomer: costController.text,
                              );
                          Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MaintenancePartsOnlineDetailsPage(
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
                          SnackBar(content: Text('الرجاء إدخال الوصف')),
                        );
                      }
                    },
                  );
                },
              );
            },
          ),
        ];
      } else if (status == 4 || status == 7) {
        return [
          ListTile(
              title: const CustomStyledText(
                text: "انتظار رد العميل",
                fontSize: 20,
              ),
              onTap: () {}),
        ];
      } else if (status == 5) {
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
                      final cubit = context.read<OnlineCubit>();
                      try {
                        await cubit.updateStatusForOnlineItem(
                            receiptItemId: widget.partId, status: 11);
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MaintenancePartsOnlineDetailsPage(
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
                    }, //UpdateStatusForonlineItem
                  );
                },
              );
            },
          ),
        ];

        ///UpdateStatusForonlineItem
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
                      final cubit = context.read<OnlineCubit>();
                      try {
                        await cubit.updateStatusForOnlineItem(
                            receiptItemId: widget.partId, status: 12);
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MaintenancePartsOnlineDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MaintenancePartsOnlinePage(),
                          ),
                        );
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Failed to update status: $e')),
                        );
                      }
                    }, //UpdateStatusForonlineItem
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
                      final cubit = context.read<OnlineCubit>();
                      try {
                        await cubit.updateStatusForOnlineItem(
                            receiptItemId: widget.partId, status: 9);
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MaintenancePartsOnlineDetailsPage(
                                    partId: widget.partId),
                          ),
                        );
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MaintenancePartsOnlinePage(),
                          ),
                        );
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Failed to update status: $e')),
                        );
                      }
                    }, //UpdateStatusForonlineItem
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
