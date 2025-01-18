import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20order/itemCurrentMaintenanceOrderTab.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20order/itemsPerviousMaintenanceOrderTab.dart';
import 'package:maintenance_app/src/features/client%20app/data/data_sources/orders/orders_data_source.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';

// class OrdersMaintenancePage extends StatelessWidget {
//   const OrdersMaintenancePage({Key? key}) : super(key: key);
//
//
// }


class OrdersMaintenancePage extends StatefulWidget {
  const OrdersMaintenancePage({super.key});

  @override
  State<OrdersMaintenancePage> createState() => _OrdersMaintenancePageState();
}

class _OrdersMaintenancePageState extends State<OrdersMaintenancePage> {

  @override
  void initState() {
    // TODO: implement initState

    context.read<OrderCubit>().getOrderMaintenanceByUserNew();
    context.read<OrderCubit>().getOrderMaintenanceByUserOld();
    super.initState();
  }
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
                    state.ordersItemsNew.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.ordersItemsNew.length,
                    itemBuilder: (context, index) {
                      return CurrentMaintenanceOrdersTab(
                        state: state,
                        orderEntity: state.ordersItemsNew[index],
                      );
                    },
                  );
                }
                return const Center(
                    child: CustomStyledText(text: 'لا توجد طلبات صيانة'));
              },
            ),

            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state.orderStatus == OrderStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.orderStatus == OrderStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.orderStatus == OrderStatus.success &&
                    state.ordersItemsOld.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.ordersItemsOld.length,
                    itemBuilder: (context, index) {
                      return CurrentMaintenanceOrdersTab(
                        state: state,
                        orderEntity: state.ordersItemsOld[index],
                      );
                    },
                  );
                }
                return const Center(
                    child: CustomStyledText(text: 'لا توجد طلبات صيانة'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
