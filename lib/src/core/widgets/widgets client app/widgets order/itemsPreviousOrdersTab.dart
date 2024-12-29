import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/data/data_sources/orders/orders_data_source.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/orders_maintenance/details_orders_screen.dart';

class PreviousOrdersTab extends StatelessWidget {
  const PreviousOrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (previousOrders.isEmpty) {
      return const CustomStyledText(text: 'لا توجد بيانات');
    } else {
      return ListView.builder(
        itemCount: previousOrders.length,
        itemBuilder: (context, index) {
          final order = previousOrders[index];
          return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.mediumPadding,
                  vertical: AppPadding.smallPadding),
              child: Container(
                  decoration: BoxDecoration(
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.black54
                        : Colors.white),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrdersDetailsPage(),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.mediumPadding,
                          vertical: AppPadding.mediumPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppSizedBox.kVSpace10,
                              CustomStyledText(
                                text: "طلب #${order.id}",
                                fontSize: 16,
                              ),
                              AppSizedBox.kVSpace5,
                              CustomStyledText(
                                text: ' order.serviceName',
                                textColor: AppColors.secondaryColor,
                                fontSize: 20,
                              ),
                              AppSizedBox.kVSpace5,
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const CustomStyledText(
                                    text: "السعر: ",
                                    textColor: AppColors.secondaryColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                  CustomStyledText(
                                    text: "${'order.price'}\$",
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                              AppSizedBox.kVSpace5,
                              Row(
                                children: [
                                  const CustomStyledText(
                                    text: "وقت الانتهاء: ",
                                    textColor: AppColors.secondaryColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                  CustomStyledText(
                                    text: "${'order.deliveryTime'} ",
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )));
        },
      );
    }
  }
}
