import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsCurrentMaintenanceConvertPart.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CurrentTakeOrderMaintenanceConvertScreen extends StatefulWidget {
  const CurrentTakeOrderMaintenanceConvertScreen({Key? key}) : super(key: key);

  @override
  State<CurrentTakeOrderMaintenanceConvertScreen> createState() =>
      _CurrentTakeOrderMaintenanceConvertScreenState();
}

class _CurrentTakeOrderMaintenanceConvertScreenState
    extends State<CurrentTakeOrderMaintenanceConvertScreen> {
  final ScrollController _scrollController = ScrollController();
  String barcodeResult = "لم يتم مسح الباركود";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      BlocProvider.of<DeliveryMaintenanceCubit>(context)
          .fetchAllTakeDeliveryConvert(refresh: true);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !context.read<DeliveryMaintenanceCubit>().state.hasReachedMax &&
          context
                  .read<DeliveryMaintenanceCubit>()
                  .state
                  .deliveryMaintenanceStatus !=
              DeliveryMaintenanceStatus.loading) {
        fetchAllTakeDeliveryConvert();
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
                fetchAllTakeDeliveryConvert(refresh: true);
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

  Future<void> fetchAllTakeDeliveryConvert({bool refresh = false}) async {
    final barcode = barcodeResult != "لم يتم مسح الباركود" ? barcodeResult : '';
    context.read<DeliveryMaintenanceCubit>().fetchAllTakeDeliveryConvert(
          refresh: refresh,
          barcode: barcode,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplicationArrow(
        text: 'الطلبات المحولة الحالية',
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeDeliveryMaintenanceScreen(),
            ),
          );
        },
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: buildBarcodeScanner(),
          ),
          Expanded(
            child: buildCurrentTakeOrderList(),
          ),
        ],
      ),
    );
  }

  Widget buildCurrentTakeOrderList() {
    return BlocBuilder<DeliveryMaintenanceCubit, DeliveryMaintenanceState>(
      builder: (context, state) {
        if (state.deliveryMaintenanceConvertCurrentStatus ==
                DeliveryMaintenanceCurrentConvertStatus.loading &&
            state.ordersCurrentConvert.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.deliveryMaintenanceConvertCurrentStatus ==
            DeliveryMaintenanceCurrentConvertStatus.failure) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.ordersCurrentConvert.isEmpty) {
          return const Center(
              child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollEndNotification &&
                _scrollController.position.extentAfter == 0 &&
                !state.hasReachedMax) {
              context
                  .read<DeliveryMaintenanceCubit>()
                  .fetchAllTakeDeliveryConvert();
            }
            return false;
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.ordersCurrentConvert.length
                : state.ordersCurrentConvert.length + 1,
            itemBuilder: (context, index) {
              if (index < state.ordersCurrentConvert.length) {
                return ItemsCurrentMaintenanceConvertPart(
                  item: state.ordersCurrentConvert[index],
                );
              } else {
                return state.deliveryMaintenanceConvertCurrentStatus ==
                        DeliveryMaintenanceCurrentConvertStatus.loading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox.shrink();
              }
            },
          ),
        );
      },
    );
  }
}
