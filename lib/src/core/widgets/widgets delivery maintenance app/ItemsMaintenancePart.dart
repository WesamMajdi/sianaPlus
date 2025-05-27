import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maintenance_app/src/core/constants/constants.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20shop%20app/ItemsReceiveOrderPart.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/customStyledText.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/receive_order_Maintenance_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemsMaintenancePart extends StatelessWidget {
  final ReceiveMaintenanceOrderEntity items;
  final Function() ontap;
  const ItemsMaintenancePart({
    super.key,
    required this.items,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
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
                        text: (' رقم الطلب#${items.id.toString()}'),
                        fontSize: 18,
                        textColor: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: getColorOrderStatusDeliveryMaintenance(
                              items.orderMaintenanceStatus),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 10),
                          child: CustomStyledText(
                            text: getTextOrderStatusDeliveryMaintenance(
                                items.orderMaintenanceStatus),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                        ],
                      ),
                      AppSizedBox.kVSpace10,
                      CustomStyledText(
                        text: items.customerPhoneNumber.toString(),
                        fontSize: 16,
                        textColor: Colors.grey,
                      ),
                      AppSizedBox.kVSpace5,
                      CustomStyledText(
                        text: 'سعر الصيانة: ${items.total.toString()}',
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
                                // ignore: deprecated_member_use
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                elevation: 0),
                            onPressed: () {
                              String location = items.locationForDelivery ?? '';
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
                      Column(
                        children: [
                          ElevatedButton.icon(
                            icon: const FaIcon(FontAwesomeIcons.whatsapp,
                                color: Colors.green),
                            label: const CustomLabelText(text: 'واتساب'),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // ignore: deprecated_member_use
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                elevation: 0),
                            onPressed: () async {
                              openWhatsApp(items.customerPhoneNumber!);
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  void openWhatsApp(String phone) async {
    final Uri url = Uri.parse("https://wa.me/$phone");
    final Uri fallbackUrl = Uri.parse("https://wa.me/$phone");

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print("Error launching WhatsApp: $e");
    }
  }
}
