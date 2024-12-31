import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class MaintenancePartsDetailsPage extends StatelessWidget {
  const MaintenancePartsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarApplicationArrow(
        text: "تفاصيل قطعة الغيار",
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSizedBox.kVSpace10,
                  Table(
                    border: TableBorder(
                      borderRadius: BorderRadius.circular(10),
                      horizontalInside: const BorderSide(
                        color: Colors.grey,
                      ),
                      verticalInside: const BorderSide(
                        color: Colors.grey,
                      ),
                      top: const BorderSide(
                        color: Colors.grey,
                      ),
                      bottom: const BorderSide(
                        color: Colors.grey,
                      ),
                      left: const BorderSide(
                        color: Colors.grey,
                      ),
                      right: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(3),
                    },
                    children: const [
                      TableRow(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: 'رقم القطعة',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: '1',
                                fontSize: 16,
                                textColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: 'اسم الزبون',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: 'وسام مجدي البلعاوي',
                                fontSize: 16,
                                textColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: 'اسم القطعة',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: 'الثلاجة',
                                fontSize: 16,
                                textColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: 'الشركة المصنعة',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: 'LG',
                                fontSize: 16,
                                textColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: 'الباركود',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: '123456789#@',
                                fontSize: 16,
                                textColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: 'لون القطعة',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: 'سيلفر',
                                fontSize: 16,
                                textColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: 'عدد أيام الضمان',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: '30 يومًا',
                                fontSize: 16,
                                textColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CustomStyledText(
                                text: 'وصف المشكلة',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: CustomStyledText(
                                text:
                                    'الثلاجة لا تعمل بشكل جيد، يوجد تسريب مياه من الداخل، وأحيانًا تتوقف عن التبريد فجأة.',
                                fontSize: 14,
                                textColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleMenuSelection(BuildContext context, int item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomStyledText(
                    text: 'العمليات',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.secondaryColor,
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[200]),
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
