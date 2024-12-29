import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20order/itemCurrentMaintenanceOrderTab.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20order/itemsPerviousMaintenanceOrderTab.dart';
import 'package:maintenance_app/src/features/client%20app/data/data_sources/orders/orders_data_source.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';

class OrdersMaintenancePage extends StatelessWidget {
  const OrdersMaintenancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(
              weight: 100,
              shadows: shadowList,
              size: 32,
              fill: 0.5,
              color: (Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black)),
          elevation: 0,
          bottom: TabBar(
            labelColor: AppColors.secondaryColor,
            unselectedLabelColor: Colors.grey.withOpacity(0.5),
            indicatorColor: AppColors.secondaryColor,
            labelStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              fontFamily: 'Tajawal',
            ),
            tabs: const [
              Tab(
                text: 'طلباتي الحالية',
              ),
              Tab(text: 'طلباتي السابقة'),
            ],
          ),
          backgroundColor: Colors.transparent,
          title: Container(
            margin: const EdgeInsets.only(left: 60),
            child: const Center(
              child: CustomStyledText(
                text: 'طلبات الصيانة',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                textColor: AppColors.secondaryColor,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state.itemStatus == ItemStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.itemStatus == ItemStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.itemStatus == ItemStatus.success &&
                    state.orderItems.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true, // Important for nesting scrolls
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.orderItems.length,
                    itemBuilder: (context, index) {
                      return CurrentMaintenanceOrdersTab(
                        state: state,
                        itemEntity: state.orderItems[index],
                      );
                    },
                  );
                }
                return const Center(
                    child: CustomStyledText(text: 'لا توجد طلبات صيانة'));
              },
            ),
            PreviousMaintenanceOrdersTab()
          ],
        ),
      ),
    );
  }
}
