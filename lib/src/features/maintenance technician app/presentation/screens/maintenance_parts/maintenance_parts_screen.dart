import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/maintenance_parts/maintenance_parts_model.dart';

class MaintenancePartsPage extends StatefulWidget {
  const MaintenancePartsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MaintenancePartsPage> createState() => _MaintenancePartsPageState();
}

class _MaintenancePartsPageState extends State<MaintenancePartsPage> {
  String barcodeResult = "لم يتم مسح الباركود";

  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        barcodeResult = result.rawContent.isEmpty
            ? "لم يتم العثور على نتيجة"
            : result.rawContent;
      });
    } catch (e) {
      setState(() {
        barcodeResult = "حدث خطأ أثناء مسح الباركود: $e";
      });
    }
  }

  TextEditingController searchController = TextEditingController();

  final List<MaintenancePart> maintenanceParts = [
    MaintenancePart(
      maintenancePartName: 'مكيف هواء',
      clientName: 'محمد أحمد',
      clientPhone: '0501234567',
      status: OrderStatus.New,
    ),
    MaintenancePart(
      maintenancePartName: 'ثلاجة',
      clientName: 'سارة خالد',
      clientPhone: '0557654321',
      status: OrderStatus.DeliveryToCustomer,
    ),
    MaintenancePart(
      maintenancePartName: 'غسالة',
      clientName: 'عبدالله علي',
      clientPhone: '0569876543',
      status: OrderStatus.Completed,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarApplicationArrow(text: 'الصيانة أونلاين'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSizedBox.kVSpace15,
            buildSearchBar(),
            AppSizedBox.kVSpace10,
            buildBarcodeScanner(),
            buildMaintenancePartsList(),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              cursorColor: Colors.black,
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
                prefixIcon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 20,
                  color: Colors.grey,
                ),
                suffixIcon: searchController.text.isEmpty
                    ? null
                    : const Icon(
                        Icons.cancel_sharp,
                        color: Colors.black,
                      ),
                hintText: "ابحث عن القطعة او اسم الزبون ",
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Tajawal"),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(right: 5),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                icon: const Icon(Icons.tune, color: Colors.white),
                onPressed: () {},
              ))
        ],
      ),
    );
  }

  Widget buildBarcodeScanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.qr_code_scanner,
              size: 50,
              color: Colors.blue,
            ),
            onPressed: scanBarcode,
          ),
        ],
      ),
    );
  }

  Widget buildMaintenancePartsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: maintenanceParts.length,
      itemBuilder: (context, index) {
        final part = maintenanceParts[index];
        return MaintenancePartWidget(
          part: part,
        );
      },
    );
  }
}

class MaintenancePartWidget extends StatelessWidget {
  final MaintenancePart part;
  const MaintenancePartWidget({
    super.key,
    required this.part,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.mediumPadding,
          vertical: AppPadding.smallPadding),
      child: Container(
          decoration: BoxDecoration(
            color: (Theme.of(context).brightness == Brightness.dark
                ? Colors.black54
                : Colors.white),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.largePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomStyledText(
                      text: part.maintenancePartName,
                      fontSize: 18,
                      textColor: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColor(part.status),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 10),
                        child: CustomStyledText(
                          text: getText(part.status),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSizedBox.kVSpace10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CustomStyledText(
                          text: part.clientName,
                          fontSize: 16,
                          textColor: Colors.grey,
                        ),
                        AppSizedBox.kVSpace5,
                        CustomStyledText(
                          text: part.clientPhone,
                          fontSize: 16,
                          textColor: Colors.grey,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('wwww'),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomStyledText(
                              text: 'تفاصيل',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              textColor: Colors.white54,
                            ),
                            AppSizedBox.kWSpace10,
                            Icon(
                              FontAwesomeIcons.arrowLeft,
                              size: 14,
                              color: Colors.white54,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Color getColor(OrderStatus status) {
    if (status == OrderStatus.New) {
      return Colors.blue.shade500;
    } else if (status == OrderStatus.TakeFromStorage) {
      return Colors.orange.shade500;
    } else if (status == OrderStatus.DeliveryToCustomer) {
      return Colors.grey.shade500;
    } else if (status == OrderStatus.Completed) {
      return Colors.green.shade500;
    }
    return Colors.black;
  }

  String getText(OrderStatus status) {
    if (status == OrderStatus.New) {
      return 'جديد';
    } else if (status == OrderStatus.TakeFromStorage) {
      return 'تم أخذها من المخزن';
    } else if (status == OrderStatus.DeliveryToCustomer) {
      return 'تم توصيلها ';
    } else if (status == OrderStatus.Completed) {
      return 'مكتمل';
    }
    return 'غير معروف';
  }
}
