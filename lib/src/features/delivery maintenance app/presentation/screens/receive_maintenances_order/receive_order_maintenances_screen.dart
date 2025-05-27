import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsMaintenancePart.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsReceiveOrderMaintenancePart.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/current_order_maintenance/detiels_current_order_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/receive_maintenances_order/receive_order_maintenance_detiels_screen.dart';

class ReceiveOrderMaintenancesScreen extends StatefulWidget {
  const ReceiveOrderMaintenancesScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveOrderMaintenancesScreen> createState() =>
      _ReceiveOrderMaintenancesScreenState();
}

class _ReceiveOrderMaintenancesScreenState
    extends State<ReceiveOrderMaintenancesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    final ScrollController _scrollController = ScrollController();

    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      BlocProvider.of<DeliveryMaintenanceCubit>(context)
          .fetchReceiveMaintenanceOrder(refresh: true);
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
        fetchReceiveMaintenanceOrder();
      }
    });
  }

  Future<void> fetchReceiveMaintenanceOrder({bool refresh = false}) async {
    context.read<DeliveryMaintenanceCubit>().fetchReceiveMaintenanceOrder(
          refresh: refresh,
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
        text: 'الطلبات',
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
            buildReceiveOrderList(),
          ],
        ),
      ),
    );
  }

  Widget buildReceiveOrderList() {
    return BlocBuilder<DeliveryMaintenanceCubit, DeliveryMaintenanceState>(
        builder: (context, state) {
      if (state.deliveryMaintenanceStatus ==
          DeliveryMaintenanceStatus.loading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.deliveryMaintenanceStatus ==
          DeliveryMaintenanceStatus.failure) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.deliveryMaintenanceStatus ==
          DeliveryMaintenanceStatus.success) {
        if (state.orders.isEmpty) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: const Center(
                  child: CustomStyledText(text: 'لا توجد إيصالات استلام')));
        }
        return ListView.builder(
          controller: _scrollController,
          itemCount: state.hasReachedMax
              ? state.orders.length
              : state.orders.length + 1,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index < state.orders.length) {
              return ItemsMaintenancePart(
                items: state.orders[index],
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ReceiveOrdersMaintenanceDetailsScreen(
                              handReceiptId: state.orders[index].handReceiptId!,
                              orderMaintenancId: state.orders[index].id),
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
        );
      }
      return const Center(
          child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
    });
  }
}
