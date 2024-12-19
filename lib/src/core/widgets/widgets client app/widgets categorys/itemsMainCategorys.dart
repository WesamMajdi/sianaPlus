import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/categorys%20page/domain.dart';

import '../../../../features/client app/domain/entities/category/category_entity.dart';

class ItemsMainCategorys extends StatelessWidget {
  const ItemsMainCategorys({
    super.key,
    required this.selectedMainCategoryId,
    required this.category,
  });

  final int selectedMainCategoryId;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.mediumPadding,
            vertical: AppPadding.smallPadding),
        decoration: BoxDecoration(
          // boxShadow: shadowList,
          border: selectedMainCategoryId == category.id
              ? null
              : Border.all(
                  color: AppColors.secondaryColor,
                  width: 0.6,
                ),
          color: selectedMainCategoryId == category.id
              ? AppColors.secondaryColor
              : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 3),
          child: Center(
            child: CustomStyledText(
              text: category.name,
              textColor: selectedMainCategoryId == category.id
                  ? Colors.white
                  : AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
