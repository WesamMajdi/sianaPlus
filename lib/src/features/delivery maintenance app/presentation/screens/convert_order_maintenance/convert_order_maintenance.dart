import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsMaintenanceConvertPart.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';

class ConvertOrderMaintenancesScreen extends StatefulWidget {
  const ConvertOrderMaintenancesScreen({Key? key}) : super(key: key);

  @override
  State<ConvertOrderMaintenancesScreen> createState() =>
      _ConvertOrderMaintenancesScreenState();
}

class _ConvertOrderMaintenancesScreenState
    extends State<ConvertOrderMaintenancesScreen> {
  final ScrollController _scrollController = ScrollController();

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

  Future<void> fetchAllForAllDeliveryConvert({bool refresh = false}) async {
    context.read<DeliveryMaintenanceCubit>().fetchAllForAllDeliveryConvert(
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
          return const Center(
              child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
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
      return const Center(
          child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
    });
  }
}
