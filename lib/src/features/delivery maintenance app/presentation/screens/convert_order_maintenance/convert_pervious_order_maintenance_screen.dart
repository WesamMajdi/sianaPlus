import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsCurrentMaintenanceConvertPart.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';

class PerviousTakeOrderMaintenanceConvertScreen extends StatefulWidget {
  const PerviousTakeOrderMaintenanceConvertScreen({Key? key}) : super(key: key);

  @override
  State<PerviousTakeOrderMaintenanceConvertScreen> createState() =>
      _PerviousTakeOrderMaintenanceConvertScreenState();
}

class _PerviousTakeOrderMaintenanceConvertScreenState
    extends State<PerviousTakeOrderMaintenanceConvertScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      BlocProvider.of<DeliveryMaintenanceCubit>(context)
          .fetchAllForDeliveryConvert(refresh: true);
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
        fetchAllForDeliveryConvert();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchAllForDeliveryConvert({bool refresh = false}) async {
    context.read<DeliveryMaintenanceCubit>().fetchAllForDeliveryConvert(
          refresh: refresh,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplicationArrow(
        text: 'الطلبات المحولة السابقة',
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
            child: buildPerviousTakeOrderList(),
          ),
        ],
      ),
    );
  }

  Widget buildPerviousTakeOrderList() {
    return BlocBuilder<DeliveryMaintenanceCubit, DeliveryMaintenanceState>(
      builder: (context, state) {
        if (state.deliveryMaintenancePerviousConvertStatus ==
                DeliveryMaintenancePerviousConvertStatus.loading &&
            state.ordersCurrentConvert.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.deliveryMaintenancePerviousConvertStatus ==
            DeliveryMaintenancePerviousConvertStatus.failure) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.ordersPerviousConvert.isEmpty) {
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
                  .fetchAllForDeliveryConvert();
            }
            return false;
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.ordersPerviousConvert.length
                : state.ordersPerviousConvert.length + 1,
            itemBuilder: (context, index) {
              if (index < state.ordersPerviousConvert.length) {
                return ItemsCurrentMaintenanceConvertPart(
                  item: state.ordersPerviousConvert[index],
                );
              } else {
                return state.deliveryMaintenancePerviousConvertStatus ==
                        DeliveryMaintenancePerviousConvertStatus.loading
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
