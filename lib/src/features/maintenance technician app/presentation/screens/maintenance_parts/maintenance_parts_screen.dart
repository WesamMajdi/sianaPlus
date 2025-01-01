import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/itemsToMaintenancePart.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: buildSearchDropdownStatus(
                    orderStatuses,
                    'ابحث عن الحالة ',
                    (OrderStatus? selectedStatus) {},
                  )),
                  Container(child: buildBarcodeScanner()),
                ],
              ),
            ),
            AppSizedBox.kVSpace10,
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

  Widget buildSearchDropdownStatus(List<OrderStatus> items, String hintText,
      void Function(OrderStatus?)? onChanged) {
    return DropdownSearch<OrderStatus>(
      itemAsString: (item) => getText(item),
      items: items,
      compareFn: (item1, item2) {
        return item1 == item2;
      },
      popupProps: PopupProps.menu(
        menuProps: MenuProps(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        isFilterOnline: true,
        showSearchBox: true,
        showSelectedItems: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'ابحث هنا',
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2),
            errorStyle: const TextStyle(fontFamily: "Tajawal", fontSize: 14),
            hintStyle: const TextStyle(
                fontSize: 14, color: Colors.grey, fontFamily: "Tajawal"),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.secondaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.secondaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppPadding.mediumPadding,
              horizontal: AppPadding.mediumPadding,
            ),
          ),
          style: const TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 16,
          ),
        ),
        itemBuilder: (context, item, isSelected) {
          return Column(
            children: [
              ListTile(
                title: CustomStyledText(
                  text: getText(item),
                  textColor: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
                ),
                selected: isSelected,
              ),
            ],
          );
        },
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          errorStyle: const TextStyle(fontFamily: "Tajawal", fontSize: 14),
          hintStyle: const TextStyle(
              fontSize: 16, color: Colors.grey, fontFamily: "Tajawal"),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.secondaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.secondaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppPadding.mediumPadding,
            horizontal: AppPadding.mediumPadding,
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
