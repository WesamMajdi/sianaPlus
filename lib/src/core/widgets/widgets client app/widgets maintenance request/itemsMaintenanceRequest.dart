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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomStyledText(
                      text: 'رقم الطلب #$i',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    const CustomStyledText(
                      text: 'اصلاح ثلاجة',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.secondaryColor,
                    ),
                  ],
                ),
                AppSizedBox.kVSpace10,
                Row(
                  children: [
                    CustomStyledText(
                      text: truncateTextDescription(
                        'الثلاجة لا تعمل بشكل جيد، يوجد تسريب مياه من الداخل، وأحيانًا تتوقف عن التبريد فجأة.',
                      ),
                      fontSize: 14,
                      textColor: Colors.grey,
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
