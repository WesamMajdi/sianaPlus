import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsMaintenanceConvertPart.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsMaintenanceOutSidePart.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class OutSideOrderMaintenancesScreen extends StatefulWidget {
  const OutSideOrderMaintenancesScreen({Key? key}) : super(key: key);

  @override
  State<OutSideOrderMaintenancesScreen> createState() =>
      _OutSideOrderMaintenancesScreenState();
}

class _OutSideOrderMaintenancesScreenState
    extends State<OutSideOrderMaintenancesScreen> {
  final ScrollController _scrollController = ScrollController();
  String barcodeResult = "لم يتم مسح الباركود";
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      BlocProvider.of<DeliveryMaintenanceCubit>(context)
          .fetchAllForAllDeliveryOutSide();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !context.read<DeliveryMaintenanceCubit>().state.hasReachedMax &&
          context
                  .read<DeliveryMaintenanceCubit>()
                  .state
                  .deliveryMaintenanceOutSideStatus !=
              DeliveryMaintenanceOutSideStatus.loading) {
        fetchAllForAllDeliveryOutSide();
      }
    });
  }

  Future<void> fetchAllForAllDeliveryOutSide({bool refresh = false}) async {
    final barcode = barcodeResult != "لم يتم مسح الباركود" ? barcodeResult : '';
    context
        .read<DeliveryMaintenanceCubit>()
        .fetchAllForAllDeliveryOutSide(refresh: refresh, barcode: barcode);
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
                fetchAllForAllDeliveryOutSide(refresh: true);
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
            buildOutSideOrderList(),
          ],
        ),
      ),
    );
  }

  Widget buildOutSideOrderList() {
    return BlocBuilder<DeliveryMaintenanceCubit, DeliveryMaintenanceState>(
        builder: (context, state) {
      if (state.deliveryMaintenanceOutSideStatus ==
          DeliveryMaintenanceOutSideStatus.loading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.deliveryMaintenanceOutSideStatus ==
          DeliveryMaintenanceOutSideStatus.failure) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.deliveryMaintenanceOutSideStatus ==
          DeliveryMaintenanceOutSideStatus.success) {
        return ListView.builder(
          controller: _scrollController,
          itemCount: state.hasReachedMax
              ? state.ordersOutSide.length
              : state.ordersOutSide.length + 1,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index < state.ordersOutSide.length) {
              return ItemsMaintenanceOutSidePart(
                item: state.ordersOutSide[index],
              );
            } else {
              return state.deliveryMaintenanceOutSideStatus ==
                      DeliveryMaintenanceOutSideStatus.loading
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox.shrink();
            }
          },
        );
      }
      return const Center(
          child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
    });
  }
}
