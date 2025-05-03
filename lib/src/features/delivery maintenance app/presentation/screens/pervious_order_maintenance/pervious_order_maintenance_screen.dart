import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsMaintenancePart.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/current_order_maintenance/detiels_current_order_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/pervious_order_maintenance/detiels_previous_order_maintenance_screen.dart';

class PerviousOrderMaintenanceScreen extends StatefulWidget {
  const PerviousOrderMaintenanceScreen({Key? key}) : super(key: key);

  @override
  State<PerviousOrderMaintenanceScreen> createState() =>
      _PerviousOrderMaintenanceScreenState();
}

class _PerviousOrderMaintenanceScreenState
    extends State<PerviousOrderMaintenanceScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      BlocProvider.of<DeliveryMaintenanceCubit>(context).fetchPerviousOrder();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplicationArrow(
        text: 'الطلبات السابقة',
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
            buildPerviousOrderList(),
          ],
        ),
      ),
    );
  }

  Widget buildPerviousOrderList() {
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
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: state.ordersOld.length,
          itemBuilder: (context, index) {
            return ItemsMaintenancePart(
              items: state.ordersOld[index],
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PerviousOrdersDetailsScreen(
                      handReceiptId: state.ordersOld[index].handReceiptId!,
                      orderMaintenancId: state.ordersOld[index].id,
                    ),
                  ),
                );
              },
            );
          },
        );
      }
      return const Center(
          child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
    });
  }
}
