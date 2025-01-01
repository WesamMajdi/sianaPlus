import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';

class MainteanceRequestDetalies extends StatelessWidget {
  MainteanceRequestDetalies({super.key, required this.itemsEntity});
  ItemsEntity itemsEntity;

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
          Row(
            children: [
              const CustomStyledText(
                text: 'اسم القطعة :',
                fontSize: 18,
              ),
              AppSizedBox.kWSpace10,
              CustomStyledText(
                text: itemsEntity.item!.name!,
                fontSize: 16,
                textColor: Colors.grey,
              ),
            ],
          ),
          const Divider(),
          AppSizedBox.kVSpace10,
          Row(
            children: [
              const CustomStyledText(
                text: 'الشركة :',
                fontSize: 18,
              ),
              AppSizedBox.kWSpace10,
              CustomStyledText(
                  fontSize: 16,
                  text: itemsEntity.company!.name!,
                  textColor: Colors.grey),
            ],
          ),
          const Divider(),
          AppSizedBox.kVSpace10,
          Row(
            children: [
              const CustomStyledText(
                text: 'لون القطعة :',
                fontSize: 18,
              ),
              AppSizedBox.kWSpace5,
              CustomStyledText(
                  fontSize: 16,
                  text: itemsEntity.color!.name!,
                  textColor: Colors.grey),
            ],
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomStyledText(
                text: 'وصف المشكلة :',
              ),
              AppSizedBox.kVSpace10,
              CustomStyledText(
                text: itemsEntity.description!,
                textColor: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
