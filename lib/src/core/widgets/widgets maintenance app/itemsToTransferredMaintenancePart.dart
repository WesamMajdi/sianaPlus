import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maintenance_app/src/core/constants/constants.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/customStyledText.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/hand_receip_maintenance_parts/hand_receipt_model.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/hand_receipt_maintenance_parts/hand_receipt_maintenance_parts_entitie.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/maintenance_parts_hand_receipt/maintenance_parts_details_screen.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/maintenance_parts_hand_receipt/maintenance_parts_screen.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/transferred_maintenance_parts/transferred_maintenance_parts_details_screen.dart';

class ItemsTransferredMaintenancePart extends StatelessWidget {
  final HandReceiptEntity items;
  const ItemsTransferredMaintenancePart({
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
            builder: (context) => TransferredMaintenancePartsDetailsPage(
              partId: items.id!,
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
                        text: items.item ?? 'غير معروف',
                        fontSize: 18,
                        textColor: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: getColor(items.maintenanceRequestStatus ?? 0),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 10),
                          child: CustomStyledText(
                            text: getText(items.maintenanceRequestStatus ?? 0),
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
                            text: items.customer?.name ?? 'غير معروف',
                            fontSize: 16,
                            textColor: Colors.grey,
                          ),
                          AppSizedBox.kVSpace5,
                          CustomStyledText(
                            text: items.customer?.phoneNumber ?? 'غير معروف',
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
      ),
    );
  }
}
