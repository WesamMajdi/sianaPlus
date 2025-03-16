import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maintenance_app/src/core/constants/constants.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/customStyledText.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/hand_receip_maintenance_parts/hand_receipt_model.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/recovered_maintenance_parts/recovered_maintenance_parts_entity.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/recovered_maintenance_parts/recovered_maintenance_parts_details_page.dart';

class ItemsRecoveredMaintenancePart extends StatelessWidget {
  final ReturnHandReceiptEntity part;
  const ItemsRecoveredMaintenancePart({
    super.key,
    required this.part,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RecoveredMaintenancePartsDetailsPage(partId: part.id!),
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
                        text: part.item!,
                        fontSize: 18,
                        textColor: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: getColor(part.maintenanceRequestStatus!),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 10),
                          child: CustomStyledText(
                            text: getText(part.maintenanceRequestStatus!),
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
                            text: part.customer!.name,
                            fontSize: 16,
                            textColor: Colors.grey,
                          ),
                          AppSizedBox.kVSpace5,
                          CustomStyledText(
                            text: part.customer!.phoneNumber,
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
