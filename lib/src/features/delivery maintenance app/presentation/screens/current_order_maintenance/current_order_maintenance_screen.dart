import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsMaintenancePart.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/current_order_maintenance/detiels_current_order_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';

class CurrentTakeOrderMaintenanceScreen extends StatefulWidget {
  const CurrentTakeOrderMaintenanceScreen({Key? key}) : super(key: key);

  @override
  State<CurrentTakeOrderMaintenanceScreen> createState() =>
      _CurrentTakeOrderMaintenanceScreenState();
}

class _CurrentTakeOrderMaintenanceScreenState
    extends State<CurrentTakeOrderMaintenanceScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      BlocProvider.of<DeliveryMaintenanceCubit>(context)
          .fetchAllTakeDelivery(refresh: true);
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
        fetchAllTakeDelivery();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchAllTakeDelivery({bool refresh = false}) async {
    context.read<DeliveryMaintenanceCubit>().fetchAllTakeDelivery(
          refresh: refresh,
        );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplicationArrow(
        text: 'الطلبات الحالية',
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
        if (state.deliveryMaintenanceStatus ==
                DeliveryMaintenanceStatus.loading &&
            state.ordersCurrent.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.deliveryMaintenanceStatus ==
            DeliveryMaintenanceStatus.failure) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.ordersCurrent.isEmpty) {
          return const Center(
              child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollEndNotification &&
                _scrollController.position.extentAfter == 0 &&
                !state.hasReachedMax) {
              context.read<DeliveryMaintenanceCubit>().fetchAllTakeDelivery();
            }
            return false;
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.ordersCurrent.length
                : state.ordersCurrent.length + 1,
            itemBuilder: (context, index) {
              if (index < state.ordersCurrent.length) {
                return ItemsMaintenancePart(
                  items: state.ordersCurrent[index],
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CurrentMaintenanceOrdersDetailsScreen(
                          handReceiptId:
                              state.ordersCurrent[index].handReceiptId!,
                          orderMaintenancId: state.ordersCurrent[index].id,
                          isPayid: state.ordersCurrent[index].isPayid!,
                          orderMaintenanceStatus: state
                              .ordersCurrent[index].orderMaintenanceStatus!,
                        ),
                      ),
                    );
                  },
                );
              } else {
                return state.deliveryMaintenanceStatus ==
                        DeliveryMaintenanceStatus.loading
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
