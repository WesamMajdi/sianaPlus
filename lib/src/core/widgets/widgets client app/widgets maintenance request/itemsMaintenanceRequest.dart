import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20maintenance%20request/mainteanceRequestDetalies.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';

import '../../../../features/client app/presentation/controller/states/order_state.dart';

class ItemsMaintenanceRequest extends StatelessWidget {
  const ItemsMaintenanceRequest({
    super.key,
    required this.i,
    required this.itemEntity,
    required this.state,
  });

  final int i;
  final ItemsEntity itemEntity;
  final OrderState state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MainteanceRequestDetalies(
                itemsEntity: itemEntity,
              );
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomStyledText(
                      text: 'رقم الطلب #${i + 1}',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    IconButton(
                      icon:
                          const Icon(FontAwesomeIcons.xmark, color: Colors.red),
                      onPressed: () {
                        context
                            .read<OrderCubit>()
                            .deleteItem(itemsEntity: itemEntity);
                      },
                    )
                  ],
                ),
                CustomStyledText(
                  text: 'اصلاح ${itemEntity.item!.name}',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.secondaryColor,
                ),
                AppSizedBox.kVSpace10,
                Row(
                  children: [
                    const CustomStyledText(
                      text: 'لون القطعة : ',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.lightGrayColor,
                    ),
                    CustomStyledText(
                      text: itemEntity.color!.name!,
                      fontSize: 16,
                      textColor: Colors.grey,
                    ),
                  ],
                ),
                AppSizedBox.kVSpace10,
                Row(
                  children: [
                    const CustomStyledText(
                      text: 'شركة القطعة : ',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.lightGrayColor,
                    ),
                    CustomStyledText(
                      text: itemEntity.company!.name!,
                      fontSize: 16,
                      textColor: Colors.grey,
                    ),
                  ],
                ),
                AppSizedBox.kVSpace10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomStyledText(
                      text: truncateTextDescription(itemEntity.description!),
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
