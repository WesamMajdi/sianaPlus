import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/itemsToMaintenancePart.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/cubit/hand_receipt_maintenance_parts/maintenance_parts_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/state/handReceipt_state.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/home_maintenance/home_maintenance_screen.dart';

class MaintenancePartsPage extends StatefulWidget {
  const MaintenancePartsPage({Key? key}) : super(key: key);

  @override
  State<MaintenancePartsPage> createState() => _MaintenancePartsPageState();
}

class _MaintenancePartsPageState extends State<MaintenancePartsPage> {
  String barcodeResult = "لم يتم مسح الباركود";
  TextEditingController searchController = TextEditingController();

  Future<void> scanBarcode() async {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: MobileScanner(
            controller: MobileScannerController(
              facing: CameraFacing.back,
              torchEnabled: false,
            ),
            onDetect: (barcodeCapture) {
              final code = barcodeCapture.barcodes.first.rawValue;
              if (code != null) {
                setState(() {
                  barcodeResult = code;
                });
                Navigator.of(context).pop();
                fetchHandReceipts(refresh: true);
              }
            },
            errorBuilder: (context, error, child) {
              return Center(child: Text('خطأ بالكاميرا: ${error.errorCode}'));
            },
            overlayBuilder: (context, constraints) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            placeholderBuilder: (context, child) => const Center(
              child: CircularProgressIndicator(),
            ),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      BlocProvider.of<HandReceiptCubit>(context).fetchHandReceipts();
    });
  }

  Future<void> fetchHandReceipts({bool refresh = false}) async {
    final searchQuery = searchController.text;
    final barcode = barcodeResult != "لم يتم مسح الباركود" ? barcodeResult : '';

    context.read<HandReceiptCubit>().fetchHandReceipts(
          refresh: refresh,
          searchQuery: searchQuery,
          barcode: barcode,
        );
    print('🔍 Barcode Scan Result: $barcodeResult');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplicationArrow(
        text: 'قطع المستلمة',
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeMaintenanceScreen(),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: buildSearchBar(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: buildBarcodeScanner(),
                  ),
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
              controller: searchController,
              cursorColor: Colors.black,
              onChanged: (value) {
                fetchHandReceipts(refresh: true);
              },
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
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
                  fontFamily: "Tajawal",
                ),
              ),
            ),
          ),
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
    return BlocBuilder<HandReceiptCubit, HandReceiptState>(
      builder: (context, state) {
        if (state.handReceiptStatus == HandReceiptStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.handReceiptStatus == HandReceiptStatus.failure) {
          return const Center(child: Text('فشلت العملية'));
        }
        if (state.handReceiptStatus == HandReceiptStatus.success) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: state.receipts.length,
            itemBuilder: (context, index) {
              return ItemsMaintenancePart(
                items: state.receipts[index],
              );
            },
          );
        }
        return const Center(
            child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
      },
    );
  }
}
