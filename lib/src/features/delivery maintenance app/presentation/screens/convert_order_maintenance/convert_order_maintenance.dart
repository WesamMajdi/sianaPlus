import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsMaintenanceConvertPart.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ConvertOrderMaintenancesScreen extends StatefulWidget {
  const ConvertOrderMaintenancesScreen({Key? key}) : super(key: key);

  @override
  State<ConvertOrderMaintenancesScreen> createState() =>
      _ConvertOrderMaintenancesScreenState();
}

class _ConvertOrderMaintenancesScreenState
    extends State<ConvertOrderMaintenancesScreen> {
  final ScrollController _scrollController = ScrollController();
  String barcodeResult = "لم يتم مسح الباركود";
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      BlocProvider.of<DeliveryMaintenanceCubit>(context)
          .fetchAllForAllDeliveryConvert();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !context.read<DeliveryMaintenanceCubit>().state.hasReachedMax &&
          context
                  .read<DeliveryMaintenanceCubit>()
                  .state
                  .deliveryMaintenanceConvertStatus !=
              DeliveryMaintenanceConvertStatus.loading) {
        fetchAllForAllDeliveryConvert();
      }
    });
  }

  Future<void> scanBarcode() async {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: MobileScanner(
            controller: MobileScannerController(facing: CameraFacing.back),
            onDetect: (barcodeCapture) {
              final code = barcodeCapture.barcodes.first.rawValue;
              if (code != null) {
                setState(() {
                  barcodeResult = code;
                });
                Navigator.of(context).pop();
                fetchAllForAllDeliveryConvert(refresh: true);
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
            placeholderBuilder: (context, child) =>
                const Center(child: CircularProgressIndicator()),
            fit: BoxFit.cover,
          ),
        );
      },
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

  Future<void> fetchAllForAllDeliveryConvert({bool refresh = false}) async {
    final barcode = barcodeResult != "لم يتم مسح الباركود" ? barcodeResult : '';
    context.read<DeliveryMaintenanceCubit>().fetchAllForAllDeliveryConvert(
          refresh: refresh,
          barcode: barcode,
        );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplicationArrow(
        text: 'الطلبات المحولة',
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeDeliveryMaintenanceScreen(),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: buildBarcodeScanner(),
            ),
            buildConvertOrderList(),
          ],
        ),
      ),
    );
  }

  Widget buildConvertOrderList() {
    return BlocBuilder<DeliveryMaintenanceCubit, DeliveryMaintenanceState>(
        builder: (context, state) {
      if (state.deliveryMaintenanceConvertStatus ==
          DeliveryMaintenanceConvertStatus.loading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.deliveryMaintenanceConvertStatus ==
          DeliveryMaintenanceConvertStatus.failure) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.deliveryMaintenanceConvertStatus ==
          DeliveryMaintenanceConvertStatus.success) {
        if (state.ordersConvert.isEmpty) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: const Center(
                  child: CustomStyledText(text: 'لا توجد إيصالات استلام')));
        }
        return ListView.builder(
          controller: _scrollController,
          itemCount: state.hasReachedMax
              ? state.ordersConvert.length
              : state.ordersConvert.length + 1,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index < state.ordersConvert.length) {
              return ItemsMaintenanceConvertPart(
                item: state.ordersConvert[index],
              );
            } else {
              return state.deliveryMaintenanceConvertStatus ==
                      DeliveryMaintenanceConvertStatus.loading
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox.shrink();
            }
          },
        );
      }
      return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: const Center(
              child: CustomStyledText(text: 'لا توجد إيصالات استلام')));
    });
  }
}
