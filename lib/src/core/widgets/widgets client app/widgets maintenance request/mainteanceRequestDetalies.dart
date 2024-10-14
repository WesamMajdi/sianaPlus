import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class MainteanceRequestDetalies extends StatelessWidget {
  const MainteanceRequestDetalies({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomStyledText(
                text: 'تفاصيل القطعة',
                textColor: AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.withOpacity(0.2)),
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          AppSizedBox.kVSpace10,
          const Row(
            children: [
              CustomStyledText(
                text: 'اسم القطعة :',
                fontSize: 18,
              ),
              AppSizedBox.kWSpace10,
              CustomStyledText(
                text: 'الثلاجة',
                fontSize: 16,
                textColor: Colors.grey,
              ),
            ],
          ),
          const Divider(),
          AppSizedBox.kVSpace10,
          const Row(
            children: [
              CustomStyledText(
                text: 'الشركة :',
                fontSize: 18,
              ),
              AppSizedBox.kWSpace10,
              CustomStyledText(
                  fontSize: 16, text: 'LG', textColor: Colors.grey),
            ],
          ),
          const Divider(),
          AppSizedBox.kVSpace10,
          const Row(
            children: [
              CustomStyledText(
                text: 'لون القطعة :',
                fontSize: 18,
              ),
              AppSizedBox.kWSpace5,
              CustomStyledText(
                  fontSize: 16, text: 'سيلفر', textColor: Colors.grey),
            ],
          ),
          const Divider(),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomStyledText(
                text: 'وصف المشكلة :',
              ),
              AppSizedBox.kVSpace10,
              CustomStyledText(
                text:
                    'الثلاجة لا تعمل بشكل جيد، يوجد تسريب مياه من الداخل، وأحيانًا تتوقف عن التبريد فجأة.',
                textColor: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
