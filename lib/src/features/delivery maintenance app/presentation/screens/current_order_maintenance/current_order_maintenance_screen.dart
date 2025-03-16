import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20maintenance%20app/ItemsCurrentTakeMaintenancePart.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/Cubit/delivery_shop_cubit.dart';

class CurrentTakeOrderMaintenanceScreen extends StatefulWidget {
  const CurrentTakeOrderMaintenanceScreen({Key? key}) : super(key: key);

  @override
  State<CurrentTakeOrderMaintenanceScreen> createState() =>
      _CurrentTakeOrderMaintenanceScreenState();
}

class _CurrentTakeOrderMaintenanceScreenState
    extends State<CurrentTakeOrderMaintenanceScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      BlocProvider.of<DeliveryMaintenanceCubit>(context).fetchAllTakeDelivery();
    });
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCurrentTakeOrderList(),
          ],
        ),
      ),
    );
  }

  Widget buildCurrentTakeOrderList() {
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
            itemCount: state.ordersCurrent.length,
            itemBuilder: (context, index) {
              return ItemsCurrentTakeMaintenancePart(
                items: state.ordersCurrent[index],
              );
            },
          );
        }
        return const Center(
            child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
      },
    );
  }
}
