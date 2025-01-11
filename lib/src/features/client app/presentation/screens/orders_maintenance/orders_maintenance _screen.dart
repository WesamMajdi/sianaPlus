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
            labelColor: (Theme.of(context).brightness == Brightness.dark
                ? AppColors.lightGrayColor
                : AppColors.darkGrayColor),
            unselectedLabelColor: Colors.grey.withOpacity(0.5),
            indicatorColor: (Theme.of(context).brightness == Brightness.dark
                ? AppColors.lightGrayColor
                : AppColors.darkGrayColor),
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
            child: Center(
              child: CustomStyledText(
                text: 'طلبات الصيانة',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                textColor: (Theme.of(context).brightness == Brightness.dark
                    ? AppColors.lightGrayColor
                    : AppColors.primaryColor),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state.orderStatus == OrderStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.orderStatus == OrderStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.orderStatus == OrderStatus.success &&
                    state.ordersItems.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.ordersItems.length,
                    itemBuilder: (context, index) {
                      return CurrentMaintenanceOrdersTab(
                        state: state,
                        orderEntity: state.ordersItems[index],
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
