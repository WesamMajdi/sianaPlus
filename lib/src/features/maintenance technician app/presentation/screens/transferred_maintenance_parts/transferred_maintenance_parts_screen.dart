import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/itemsToMaintenancePart.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/itemstoTransferredMaintenanceParts.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/maintenance_parts/maintenance_parts_model.dart';

class TransferredMaintenancePartsPage extends StatefulWidget {
  const TransferredMaintenancePartsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TransferredMaintenancePartsPage> createState() =>
      _TransferredMaintenancePartsPageState();
}

class _TransferredMaintenancePartsPageState
    extends State<TransferredMaintenancePartsPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarApplicationArrow(text: 'القطع المحولة الي الفرع'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSizedBox.kVSpace15,
            buildSearchBar(),
            AppSizedBox.kVSpace10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Expanded(
                  //     child: buildSearchDropdownStatus(
                  //   orderStatuses,
                  //   'ابحث عن الحالة ',
                  //   (OrderStatus? selectedStatus) {},
                  // )),
                  Container(child: buildBarcodeScanner()),
                ],
              ),
            ),
            AppSizedBox.kVSpace10,
            // buildPortableMaintenancePartsList(),
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
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: const Icon(
          Icons.qr_code_scanner,
          size: 32,
          color: AppColors.secondaryColor,
        ),
        onPressed: scanBarcode,
      ),
    );
  }

  // Widget buildPortableMaintenancePartsList() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: const BouncingScrollPhysics(),
  //     itemCount: maintenanceParts.length,
  //     itemBuilder: (context, index) {
  //       final part = maintenanceParts[index];
  //       return ItemsTransferredMaintenancePart(
  //         part: part,
  //       );
  //     },
  //   );
  // }
}
