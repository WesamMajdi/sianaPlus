import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20order/itemMaintenanceOrders.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';

class MaintenanceRequestsForApprovalScreen extends StatefulWidget {
  final int? currentIndex;
  const MaintenanceRequestsForApprovalScreen(
      {super.key, this.currentIndex = 4});

  @override
  State<MaintenanceRequestsForApprovalScreen> createState() =>
      _MaintenanceRequestsForApprovalScreenState();
}

class _MaintenanceRequestsForApprovalScreenState
    extends State<MaintenanceRequestsForApprovalScreen> {
  @override
  void initState() {
    context.read<OrderCubit>().getOrderMaintenanceRequestsForApproval();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(currentIndex: widget.currentIndex),
      appBar: const AppBarApplication(text: "طلبات الموافقة"),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state.orderApprovalStatus == OrderForApprovalStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.orderApprovalStatus == OrderForApprovalStatus.failure) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.orderApprovalStatus == OrderForApprovalStatus.success &&
              state.ordersItemsApprovel.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.ordersItemsApprovel.length,
              itemBuilder: (context, index) {
                return MaintenanceOrders(
                    state: state,
                    orderEntity: state.ordersItemsApprovel[index],
                    isTab: false);
              },
            );
          }
          return Column(
            children: [
              AppSizedBox.kVSpace20,
              AppSizedBox.kVSpace20,
              Image.asset('assets/images/Approval.png'),
              AppSizedBox.kVSpace20,
              AppSizedBox.kVSpace20,
              const Center(
                  child: CustomStyledText(text: 'لا توجد طلبات صيانة')),
            ],
          );
        },
      ),
    );
  }
}
