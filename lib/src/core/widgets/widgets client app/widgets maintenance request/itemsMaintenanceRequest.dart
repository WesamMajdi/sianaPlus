import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20maintenance%20request/mainteanceRequestDetalies.dart';

class ItemsMaintenanceRequest extends StatelessWidget {
  const ItemsMaintenanceRequest({
    super.key,
    required this.i,
  });

  final int i;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const MainteanceRequestDetalies();
            });
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.2, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(top: 3),
                        child: CustomStyledText(
                          text: '$i',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSizedBox.kWSpace20,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomStyledText(
                      text: 'الثلاجة',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.secondaryColor,
                    ),
                    AppSizedBox.kVSpace10,
                    CustomStyledText(
                      text: truncateTextDescription(
                        'الثلاجة لا تعمل بشكل جيد، يوجد تسريب مياه من الداخل، وأحيانًا تتوقف عن التبريد فجأة.',
                      ),
                      fontSize: 14,
                      textColor: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
