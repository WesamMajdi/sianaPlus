import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';

class ItemsOrdersDetails extends StatelessWidget {
  final Order order;

  const ItemsOrdersDetails({
    super.key,
    required this.order,
  });

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
          padding: const EdgeInsets.all(AppPadding.largePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: "",
                        groupValue: "",
                        onChanged: (index) {},
                        activeColor: AppColors.secondaryColor,
                      ),
                      CustomStyledText(
                        text: order.serviceName,
                        fontSize: 20,
                        textColor: AppColors.secondaryColor,
                      ),
                    ],
                  ),
                  CustomStyledText(
                    text: order.price.toString(),
                    fontSize: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
