import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/utilities/extensions.dart';
import 'package:maintenance_app/src/features/client%20app/data/data_sources/orders/orders_data_source.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/orders_maintenance/details_orders_screen.dart';

class CurrentMaintenanceOrdersTab extends StatelessWidget {
  final OrderEntity orderEntity;
  final OrderState state;

  const CurrentMaintenanceOrdersTab(
      {Key? key, required this.orderEntity, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                child:  Padding(
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
                            text: "طلب #${orderEntity!.id}",
                            fontSize: 16,
                          ),
                          AppSizedBox.kVSpace5,
                          CustomStyledText(
                            text: 'itemEntity.item!.name!',
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
                              CustomStyledText(
                                text: "السعر: ",
                                textColor: AppColors.secondaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                              CustomStyledText(
                                text: "${orderEntity.totalAfterDiscount}\$",
                                fontSize: 14,
                              ),
                            ],
                          ),
                          AppSizedBox.kVSpace5,
                          Row(
                            children: [
                              const CustomStyledText(
                                text: "الحالة: ",
                                textColor: AppColors.secondaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                              CustomStyledText(
                                text: "${OrderMaintenanceStatusExtension.fromId(orderEntity.orderMaintenanceStatus!).name} ",
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
    // }
  }
}
