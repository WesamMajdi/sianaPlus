import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/basket_Model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/ordered_product/ordered_product_screen.dart';

class PrductOrdersDetailsScreen extends StatefulWidget {
  final int basketId;

  const PrductOrdersDetailsScreen({Key? key, required this.basketId})
      : super(key: key);

  @override
  State<PrductOrdersDetailsScreen> createState() =>
      _PrductOrdersDetailsScreenState();
}

class _PrductOrdersDetailsScreenState extends State<PrductOrdersDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getAllItemByOrder(widget.basketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(
        text: 'تفاصيل طلب',
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrdersProductPage()),
          );
        },
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state.orderProductStatus == OrderProductStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.orderProductStatus == OrderProductStatus.failure) {
            return const Center(child: Text('حدث خطأ أثناء التحميل'));
          }

          if (state.orderProductStatus == OrderProductStatus.success) {
            if (state.basket.isEmpty) {
              return const Center(child: Text('لا توجد بيانات'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              itemCount: state.basket.length,
              itemBuilder: (context, basketIndex) {
                final basket = state.basket[basketIndex];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomStyledText(
                            text: 'رقم السلة:# ${basket.basketId}',
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: basket.orders.length,
                            itemBuilder: (context, orderIndex) {
                              final order = basket.orders[orderIndex];
                              return _buildOrderItem(order);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('جاري التحميل...'));
        },
      ),
    );
  }

  Widget _buildOrderItem(BasketItem order) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomStyledText(
            text: order.productName ?? "غير محدد",
            textColor: AppColors.lightGrayColor,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomStyledText(
                  text: "اللون: ${order.productColor ?? "غير محدد"}"),
              CustomStyledText(
                  text: "الشركة: ${order.productCompany ?? "غير محدد"}"),
            ],
          ),
          const SizedBox(height: 4),
          CustomStyledText(
              text: "السعر: ${order.price?.toStringAsFixed(2) ?? "0.00"}"),
          const Divider(),
        ],
      ),
    );
  }
}
