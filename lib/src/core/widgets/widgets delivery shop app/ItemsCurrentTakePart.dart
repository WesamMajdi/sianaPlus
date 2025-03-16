import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maintenance_app/src/core/constants/constants.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20shop%20app/ItemsReceiveOrderPart.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/customStyledText.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/current_order_detiles_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/current_order/detiels_current_order_screen.dart';

class ItemsCurrentTakePart extends StatelessWidget {
  final ReceiveOrderEntity items;
  const ItemsCurrentTakePart({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CurrentOrdersDetailsScreen(
              basketId: items.id,
            ),
          ),
        );
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
              padding: const EdgeInsets.all(AppPadding.largePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomStyledText(
                        text: (' رقم الطلب#${items!.id.toString()}' ?? ''),
                        fontSize: 18,
                        textColor: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  AppSizedBox.kVSpace10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomStyledText(
                            text: items.customerName.toString(),
                            fontWeight: FontWeight.bold,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: getColorOrderStatusDeliveryShop(
                                  items.orderStatus),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 10),
                              child: CustomStyledText(
                                text: getTextOrderStatusDeliveryShop(
                                    items.orderStatus),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomStyledText(
                        text: items.customerPhoneNumber.toString(),
                        fontSize: 16,
                        textColor: Colors.grey,
                      ),
                    ],
                  ),
                  AppSizedBox.kVSpace10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 25,
                            ),
                            label: const CustomLabelText(text: 'الموقع'),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                elevation: 0),
                            onPressed: () {
                              String location = items!.locationForDelivery ??
                                  '31.517676194600096,34.45955065416023';
                              List<String> coordinates = location.split(',');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                    latitude: double.parse(coordinates[0]),
                                    longitude: double.parse(coordinates[1]),
                                  ),
                                ),
                              );
                            },
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
      ),
    );
  }
}
