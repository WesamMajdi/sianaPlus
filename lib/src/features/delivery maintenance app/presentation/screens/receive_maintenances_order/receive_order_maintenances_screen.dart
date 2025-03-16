import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsReceiveOrderMaintenancePart.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';

class ReceiveOrderMaintenancesScreen extends StatefulWidget {
  const ReceiveOrderMaintenancesScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveOrderMaintenancesScreen> createState() =>
      _ReceiveOrderMaintenancesScreenState();
}

class _ReceiveOrderMaintenancesScreenState
    extends State<ReceiveOrderMaintenancesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<DeliveryMaintenanceCubit>(context)
          .fetchReceiveMaintenanceOrder();
    });
  }

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
        return const Center(child: Text('فشلت العملية'));
      }
      if (state.deliveryMaintenanceStatus ==
          DeliveryMaintenanceStatus.success) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: state.orders.length,
          itemBuilder: (context, index) {
            return ItemsReceiveMaintenanceOrderPart(
              item: state.orders[index],
            );
          },
        );
      }
      return const Center(
          child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
    });
  }
}
