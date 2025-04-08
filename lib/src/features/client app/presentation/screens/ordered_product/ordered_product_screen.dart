import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20order/itemMaintenanceOrders.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20order/itemsProductOrders.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';

class OrdersProductPage extends StatefulWidget {
  const OrdersProductPage({super.key});

  @override
  State<OrdersProductPage> createState() => _OrdersProductPageState();
}

class _OrdersProductPageState extends State<OrdersProductPage> {
  @override
  void initState() {
    context.read<OrderCubit>().getOrderProductByUserNew();
    context.read<OrderCubit>().getOrderProductByUserOld();
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
                : AppColors.primaryColor),
            unselectedLabelColor: Colors.grey.withOpacity(0.5),
            indicatorColor: (Theme.of(context).brightness == Brightness.dark
                ? AppColors.lightGrayColor
                : AppColors.primaryColor),
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
                text: 'طلبات المنتجات',
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
                if (state.orderProductStatus == OrderProductStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.orderProductStatus == OrderProductStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.orderProductStatus == OrderProductStatus.success &&
                    state.ordersProductItemsNew!.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.ordersProductItemsNew!.length,
                    itemBuilder: (context, index) {
                      return ProductOrdersPage(
                        state: state,
                        orderProductEntity: state.ordersProductItemsNew![index],
                      );
                    },
                  );
                }
                return const Center(
                    child:
                        CustomStyledText(text: 'لا توجد طلبات منتجات سابقة'));
              },
            ),
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state.orderProductStatus == OrderProductStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.orderProductStatus == OrderProductStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.orderProductStatus == OrderProductStatus.success &&
                    state.ordersProductItemsOld!.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.ordersProductItemsOld!.length,
                    itemBuilder: (context, index) {
                      return ProductOrdersPage(
                        state: state,
                        orderProductEntity: state.ordersProductItemsOld![index],
                      );
                    },
                  );
                }
                return const Center(
                    child:
                        CustomStyledText(text: 'لا توجد طلبات منتجات سابقة'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
