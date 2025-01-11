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
                    padding: const EdgeInsets.all(AppPadding.largePadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomStyledText(
                              text: "طلب #${orderEntity.id}",
                              fontSize: 18,
                              textColor: AppColors.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                child: CustomStyledText(
                                  text: ' getText(part.status)',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppSizedBox.kVSpace10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                CustomStyledText(
                                  text: 'part.clientName',
                                  fontSize: 16,
                                  textColor: Colors.grey,
                                ),
                                AppSizedBox.kVSpace5,
                                CustomStyledText(
                                  text: 'part.clientPhone',
                                  fontSize: 16,
                                  textColor: Colors.grey,
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomStyledText(
                                    text: 'تفاصيل',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    textColor: Colors.white54,
                                  ),
                                  AppSizedBox.kWSpace10,
                                  Icon(
                                    FontAwesomeIcons.arrowLeft,
                                    size: 14,
                                    color: Colors.white54,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            )));
  }
}
