// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/itemsToMainteinaceOnlinePart.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/cubit/hand_receipt_maintenance_parts/maintenance_parts_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/cubit/online_maintenance_parts/online_maintenance_parts_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/state/online_state.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/home_maintenance/home_maintenance_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MaintenancePartsOnlinePage extends StatefulWidget {
  const MaintenancePartsOnlinePage({Key? key}) : super(key: key);

  @override
  State<MaintenancePartsOnlinePage> createState() =>
      _MaintenancePartsOnlinePageState();
}

class _MaintenancePartsOnlinePageState
    extends State<MaintenancePartsOnlinePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OnlineCubit>().fetchOnline(refresh: true);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !context.read<OnlineCubit>().state.hasReachedEnd &&
          context.read<OnlineCubit>().state.onlineStatus !=
              OnlineStatus.loading) {
        fetchOnline();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String barcodeResult = "لم يتم مسح الباركود";
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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
                fetchOnline(refresh: true);
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

  Future<void> fetchOnline({bool refresh = false}) async {
    final searchQuery = searchController.text;
    final barcode = barcodeResult != "لم يتم مسح الباركود" ? barcodeResult : '';

    context.read<OnlineCubit>().fetchOnline(
          refresh: refresh,
          searchQuery: searchQuery,
          barcode: barcode,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplicationArrow(
        text: 'قطع الاونلاين',
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeMaintenanceScreen(),
            ),
          );
        },
      ),
      body: Column(
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
                    child: buildBarcodeScanner()),
              ],
            ),
          ),
          AppSizedBox.kVSpace10,
          Expanded(child: buildMaintenancePartsList()),
        ],
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
                fetchOnline(refresh: true);
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
    return BlocBuilder<OnlineCubit, OnlineState>(
      builder: (context, state) {
        if (state.onlineStatus == OnlineStatus.loading) {
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state.onlineStatus == OnlineStatus.failure) {
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state.onlineStatus == OnlineStatus.success) {
          if (state.receiptsOnline.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: const Center(
                child: CustomStyledText(text: 'لا توجد إيصالات استلام'),
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedEnd
                ? state.receiptsOnline.length
                : state.receiptsOnline.length + 1,
            itemBuilder: (context, index) {
              if (index < state.receiptsOnline.length) {
                return ItemsMaintenanceOnlinePart(
                  items: state.receiptsOnline[index],
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        }
        return const Center(
            child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
      },
    );
  }
}
