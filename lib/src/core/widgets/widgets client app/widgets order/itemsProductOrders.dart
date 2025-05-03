import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/order_product_model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/ordered_product/details_porducts_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/orders_maintenance/details_orders_screen.dart';

class ProductOrdersPage extends StatelessWidget {
  final OrderProductModel orderProductEntity;
  final OrderState state;

  const ProductOrdersPage({
    Key? key,
    required this.orderProductEntity,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrductOrdersDetailsScreen(
                    basketId: orderProductEntity.id,
                  ),
                ));
          },
          child: Padding(
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.mediumPadding,
                        vertical: AppPadding.smallPadding),
                    child: Container(
                        decoration: BoxDecoration(
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.black54
                                  : Colors.white),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(AppPadding.largePadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomStyledText(
                                    text: "طلب #${orderProductEntity.id}",
                                    fontSize: 18,
                                    textColor: AppColors.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: getStatusProductColor(
                                          orderProductEntity.orderStatus),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 10),
                                      child: CustomStyledText(
                                        text: getStatusProduct(
                                            orderProductEntity.orderStatus),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              AppSizedBox.kVSpace20,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomStyledText(
                                        text:
                                            'تاريخ تسليم: ${orderProductEntity.deliveryDate ?? "لم يتم تسليم بعد"}',
                                        fontSize: 16,
                                        textColor: Colors.grey,
                                      ),
                                      AppSizedBox.kVSpace5,
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  ))),
        ),
      ],
    );
  }

  String getStatusProduct(int productStatus) {
    return OrderProduct.values[productStatus - 1].nameAr.toString();
  }

  Color getStatusProductColor(int productStatus) {
    return OrderProduct.values[productStatus - 1].statusColor;
  }
}
