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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.mediumPadding,
            vertical: AppPadding.smallPadding),
        decoration: BoxDecoration(
          border: state.selectedCategoryId == category.id
              ? null
              : Border.all(
                  color: AppColors.secondaryColor,
                  width: 0.6,
                ),
          color: state.selectedCategoryId == category.id
              ? AppColors.primaryColor
              : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 3),
          child: Center(
            child: CustomStyledText(
              text: category.name,
              textColor: state.selectedCategoryId == category.id
                  ? AppColors.lightGrayColor
                  : AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
