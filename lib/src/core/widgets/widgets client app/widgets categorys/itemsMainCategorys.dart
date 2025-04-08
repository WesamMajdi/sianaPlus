import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import '../../../../features/client app/domain/entities/category/category_entity.dart';
import '../../../../features/client app/presentation/controller/states/category_state.dart';

class ItemsMainCategories extends StatelessWidget {
  const ItemsMainCategories({
    super.key,
    required this.state,
    required this.category,
  });

  final CategoryState state;
  final Category category;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = state.selectedCategoryId == category.id
        ? (isDarkMode ? AppColors.lightGrayColor : AppColors.primaryColor)
        : AppColors.secondaryColor;

    final nameColor =
        (isDarkMode ? AppColors.primaryColor : AppColors.lightGrayColor);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.mediumPadding,
            vertical: AppPadding.smallPadding),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 3),
          child: Center(
            child: CustomStyledText(
              text: category.name,
              fontWeight: FontWeight.bold,
              textColor: nameColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
