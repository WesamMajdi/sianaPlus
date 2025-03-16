import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maintenance_app/src/core/constants/constants.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20shop%20app/ItemsReceiveOrderPart.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/customStyledText.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/pervious_order/detiels_previous_order_screen.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/receive_order/receive_order_detiels_screen.dart';

class ItemsPerviousOrderPart extends StatelessWidget {
  final ReceiveOrderEntity? item;

  const ItemsPerviousOrderPart({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PerviousOrdersDetailsScreen(
              basketId: item!.id,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.mediumPadding,
          vertical: AppPadding.smallPadding,
        ),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomStyledText(
                      text: (' رقم الطلب#${item!.id.toString()}' ?? ''),
                      fontSize: 18,
                      textColor: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomStyledText(
                      text: (item!.deliveryDate.toString()),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
                          text: item?.customerName ?? 'اسم غير متوفر',
                          fontSize: 16,
                          textColor: Colors.grey,
                        ),
                        AppSizedBox.kVSpace5,
                        CustomStyledText(
                          text: item?.customerPhoneNumber ?? 'لا يوجد رقم',
                          fontSize: 16,
                          textColor: Colors.grey,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                            String location = item!.locationForDelivery ??
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
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomStyledText(
                                text: 'تفاصيل',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.grey,
                              ),
                              AppSizedBox.kWSpace10,
                              Icon(
                                FontAwesomeIcons.arrowLeft,
                                size: 14,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
