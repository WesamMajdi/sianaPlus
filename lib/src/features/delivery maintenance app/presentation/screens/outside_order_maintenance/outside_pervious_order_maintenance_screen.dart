import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsCurrentMaintenanceConvertPart.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsPervoiusMaintenanceOutSidePart.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';

class PerviousTakeOrderMaintenanceOutSideScreen extends StatefulWidget {
  const PerviousTakeOrderMaintenanceOutSideScreen({Key? key}) : super(key: key);

  @override
  State<PerviousTakeOrderMaintenanceOutSideScreen> createState() =>
      _PerviousTakeOrderMaintenanceOuutSideScreenState();
}

class _PerviousTakeOrderMaintenanceOuutSideScreenState
    extends State<PerviousTakeOrderMaintenanceOutSideScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      BlocProvider.of<DeliveryMaintenanceCubit>(context)
          .fetchAllForDeliveryOutSide(refresh: true);
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
        fetchAllForDeliveryOutSide();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchAllForDeliveryOutSide({bool refresh = false}) async {
    context.read<DeliveryMaintenanceCubit>().fetchAllForDeliveryOutSide(
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
        if (state.deliveryMaintenancePerviousOutSideStatus ==
                DeliveryMaintenancePerviousOutSideStatus.loading &&
            state.ordersCurrentConvert.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.deliveryMaintenancePerviousOutSideStatus ==
            DeliveryMaintenancePerviousOutSideStatus.failure) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.ordersPerviousOutSide.isEmpty) {
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
                  .fetchAllForDeliveryOutSide();
            }
            return false;
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.ordersPerviousOutSide.length
                : state.ordersPerviousOutSide.length + 1,
            itemBuilder: (context, index) {
              if (index < state.ordersPerviousOutSide.length) {
                return ItemsPerviousMaintenanceOutSidePart(
                  item: state.ordersPerviousOutSide[index],
                );
              } else {
                return state.deliveryMaintenancePerviousOutSideStatus ==
                        DeliveryMaintenancePerviousOutSideStatus.loading
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
