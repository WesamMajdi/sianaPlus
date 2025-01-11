// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customInputDialog.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/maintenance_parts/maintenance_parts_model.dart';

class MaintenancePartsDetailsPage extends StatelessWidget {
  const MaintenancePartsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarApplicationArrow(
        text: "تفاصيل القطعة ",
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                    buildTableRow('اسم العميل', 'محمد أحمد'),
                    buildTableRow('رقم العميل', '0501234567'),
                    buildTableRow('اسم القطعة', 'ثلاجة'),
                    buildTableRow('الشركة', 'سامسونج'),
                    buildTableRow('اللون', 'أسود'),
                    buildTableRow('الوصف', 'ssssss'),
                    buildTableRow('يتطلب إبلاغ العميل بالتكلفة؟', 'لا'),
                    buildTableRow('مستعجل', 'لا'),
                    buildTableRow('عدد أيام الضمان', '22'),
                  ],
                ),
                AppSizedBox.kVSpace20,
                buildButtonWidget(context)
              ],
            ),
          ),
        ],
      ),
    );
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
    return Container(
      decoration: BoxDecoration(
        color: getColor(status),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
        ),
        child: Center(
          child: CustomStyledText(
            text: getText(status),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildButtonWidget(BuildContext context) {
    StatusEnum status = StatusEnum.InformCustomerOfTheCost;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
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
                  ..._getItemsBasedOnStatus(context, status),
                ],
              ),
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

  List<Widget> _getItemsBasedOnStatus(BuildContext context, StatusEnum status) {
    bool notifyCustomerOfTheCost = true;
    if (status != StatusEnum.Suspended) {
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
      if (status == StatusEnum.New) {
        return [
          ListTile(
            title: const CustomStyledText(
              text: 'فحص القطعة',
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () {},
                  ); //UpdateStatusForHandReceiptItem
                },
              );
            },
          ),
        ];
      } else if (status == StatusEnum.CheckItem) {
        return [
          ListTile(
            title: const CustomStyledText(
              text: 'تحديد العطل',
              fontSize: 20,
            ),
            onTap: () {
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
                    onConfirm: () {}, //DefineMalfunctionForHandReceiptItem
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
                    onConfirm: () {}, //UpdateStatusForHandReceiptItem
                  );
                },
              );
            },
          ),
        ];
      } else if (status == StatusEnum.DefineMalfunction &&
          notifyCustomerOfTheCost) {
        return [
          ListTile(
            title: const CustomStyledText(
              text: 'ابلاغ العميل بتكلفة',
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () {},
                  );
                },
              );
            }, //UpdateStatusForHandReceiptItem
          ),
        ];
      } else if (status == StatusEnum.DefineMalfunction &&
          // ignore: dead_code
          !notifyCustomerOfTheCost) {
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
                    onConfirm: () {},
                  );
                },
              );
            }, //UpdateStatusForHandReceiptItem
          ),
        ];
      } else if (status == StatusEnum.InformCustomerOfTheCost) {
        return [
          ListTile(
            title: const CustomStyledText(
              text: 'إبلاغ العميل بالتكلفة',
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ShowDilogInformCustomerOfTheCost();
                },
              );
            },
          ),
        ];
      } else if (status == StatusEnum.NoResponseFromTheCustomer) {
        return [
          ListTile(
            title: const CustomStyledText(
              text: 'موافقة العميل',
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () {},
                  );
                },
              );
            }, //UpdateStatusForHandReceiptItem
          ),
          ListTile(
            title: const CustomStyledText(
              text: 'رفض العميل',
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
      } else if (status == StatusEnum.CustomerApproved &&
          notifyCustomerOfTheCost) {
        return [
          ListTile(
            title: const CustomStyledText(
              text: 'سعر صيانة',
              fontSize: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomInputDialog(
                    titleDialog: 'تحديد السعر',
                    text: 'السعر:',
                    hintText: 'ادخل السعر',
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.السعر مطلوب';
                      }
                      return null;
                    },
                    onConfirm: () {},

                    ///EnterMaintenanceCostForHandReceiptItem
                  );
                },
              );
            },
          ),
        ];
      } else if ((status == StatusEnum.CustomerApproved &&
              !notifyCustomerOfTheCost) ||
          status == StatusEnum.EnterMaintenanceCost) {
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
                    onConfirm: () {},
                  );
                },
              );
            },
          ),
        ];

        ///UpdateStatusForHandReceiptItem
      } else if (status == StatusEnum.Completed) {
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
                    onConfirm: () {},

                    ///UpdateStatusForHandReceiptItem
                  );
                },
              );
            },
          ),
        ];
      } else if (status == StatusEnum.ItemCannotBeServiced) {
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
                    onConfirm: () {},

                    ///UpdateStatusForHandReceiptItem
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
  const ShowDilogInformCustomerOfTheCost({
    super.key,
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
            if (statusEnum == StatusEnum.CustomerApproved) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () {},
                  );
                },
              );
            } else if (statusEnum == StatusEnum.CustomerRefused) {
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
            } else if (statusEnum == StatusEnum.NoResponseFromTheCustomer) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSureDialog(
                    onConfirm: () {},
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
