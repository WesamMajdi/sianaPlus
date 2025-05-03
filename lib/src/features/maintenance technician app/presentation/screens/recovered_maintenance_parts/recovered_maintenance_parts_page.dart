// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/itemsRecoveredMaintenanceParts.dart';

import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/cubit/recovered_maintenance_parts/recovered_maintenance_parts_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/state/returnHandReceipt_state.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/home_maintenance/home_maintenance_screen.dart';

class RecoveredMaintenancePartsPage extends StatefulWidget {
  const RecoveredMaintenancePartsPage({super.key});

  @override
  State<RecoveredMaintenancePartsPage> createState() =>
      _RecoveredMaintenancePartsPageState();
}

class _RecoveredMaintenancePartsPageState
    extends State<RecoveredMaintenancePartsPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<ReturnHandReceiptCubit>()
        .getAllReturnHandReceiptItems(refresh: true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !context.read<ReturnHandReceiptCubit>().state.hasReachedEnd &&
          context
                  .read<ReturnHandReceiptCubit>()
                  .state
                  .returnHandReceiptStatus !=
              ReturnHandReceiptStatus.loading) {
        fetcReturnhHandReceipts();
      }
    });
  }

  String barcodeResult = "لم يتم مسح الباركود";
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> fetcReturnhHandReceipts({bool refresh = false}) async {
    final searchQuery = searchController.text;
    final barcode = barcodeResult != "لم يتم مسح الباركود" ? barcodeResult : '';

    context.read<ReturnHandReceiptCubit>().getAllReturnHandReceiptItems(
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
        text: 'قطع المرجعة',
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
          Expanded(child: buildRecoveredMaintenancePartsList()),
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
                fetcReturnhHandReceipts(refresh: true);
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
        onPressed: () {},
      ),
    );
  }

  Widget buildRecoveredMaintenancePartsList() {
    return BlocBuilder<ReturnHandReceiptCubit, ReturnHandReceiptState>(
      builder: (context, state) {
        if (state.returnHandReceiptStatus == ReturnHandReceiptStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.returnHandReceiptStatus == ReturnHandReceiptStatus.failure) {
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state.returnHandReceiptStatus == ReturnHandReceiptStatus.success) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedEnd
                ? state.returnHandReceipts.length
                : state.returnHandReceipts.length + 1,
            itemBuilder: (context, index) {
              if (index < state.returnHandReceipts.length) {
                return ItemsRecoveredMaintenancePart(
                  part: state.returnHandReceipts[index],
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
