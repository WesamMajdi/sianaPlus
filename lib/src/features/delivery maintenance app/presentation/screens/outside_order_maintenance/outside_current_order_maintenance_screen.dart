import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsCurrentMaintenanceOutSidePart.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';

class CurrentTakeOrderMaintenanceOutSideScreen extends StatefulWidget {
  const CurrentTakeOrderMaintenanceOutSideScreen({Key? key}) : super(key: key);

  @override
  State<CurrentTakeOrderMaintenanceOutSideScreen> createState() =>
      _CurrentTakeOrderMaintenanceOutSideScreenState();
}

class _CurrentTakeOrderMaintenanceOutSideScreenState
    extends State<CurrentTakeOrderMaintenanceOutSideScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      BlocProvider.of<DeliveryMaintenanceCubit>(context)
          .fetchAllTakeDeliveryOutSide(refresh: true);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !context.read<DeliveryMaintenanceCubit>().state.hasReachedMax &&
          context
                  .read<DeliveryMaintenanceCubit>()
                  .state
                  .deliveryMaintenanceCurrentOutSideStatus !=
              DeliveryMaintenanceCurrentOutSideStatus.loading) {
        fetchAllTakeDeliveryOutSide();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchAllTakeDeliveryOutSide({bool refresh = false}) async {
    context.read<DeliveryMaintenanceCubit>().fetchAllTakeDeliveryOutSide(
          refresh: refresh,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplicationArrow(
        text: 'الطلبات المحولة الحالية خارج المؤسسة ',
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
        if (state.deliveryMaintenanceCurrentOutSideStatus ==
                DeliveryMaintenanceCurrentOutSideStatus.loading &&
            state.ordersCurrentOutSide.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.deliveryMaintenanceCurrentOutSideStatus ==
            DeliveryMaintenanceCurrentOutSideStatus.failure) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.ordersCurrentOutSide.isEmpty) {
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
                  .fetchAllTakeDeliveryOutSide();
            }
            return false;
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.ordersCurrentOutSide.length
                : state.ordersCurrentOutSide.length + 1,
            itemBuilder: (context, index) {
              if (index < state.ordersCurrentOutSide.length) {
                return ItemsCurrentMaintenanceOutSidePart(
                  item: state.ordersCurrentOutSide[index],
                );
              } else {
                return state.deliveryMaintenanceCurrentOutSideStatus ==
                        DeliveryMaintenanceCurrentOutSideStatus.loading
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
