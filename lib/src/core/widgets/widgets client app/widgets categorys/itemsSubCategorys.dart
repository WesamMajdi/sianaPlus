import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/categorys%20page/domain.dart';

class ItemsSubCategorys extends StatelessWidget {
  const ItemsSubCategorys({
    Key? key,
    required this.filteredSubCategories,
  }) : super(key: key);

  final List<SubCategory> filteredSubCategories;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
        ),
        itemCount: filteredSubCategories.length,
        itemBuilder: (context, index) {
          final subCategory = filteredSubCategories[index];
          return Container(
            height: 240,
            margin: const EdgeInsets.symmetric(
                horizontal: 20, vertical: AppPadding.smallPadding),
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: shadowList,
                        ),
                        margin: const EdgeInsets.only(top: 30),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductPage(),
                            ),
                          );
                        },
                        child: Align(
                          child: Image.asset(
                            subCategory.imagePath,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductPage(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 10),
                    decoration: BoxDecoration(
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.black54
                            : Colors.white),
                        boxShadow: shadowList,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppSizedBox.kVSpace20,
                        CustomStyledText(
                          text: truncateTextDescription(subCategory.name),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.secondaryColor,
                        ),
                        const SizedBox(height: 5),
                        CustomStyledText(
                          text:
                              truncateTextDescription(subCategory.description),
                          fontSize: 14,
                        ),
                        AppSizedBox.kVSpace20,
                        const CustomStyledText(
                          text: "عدد المنتجات",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        AppSizedBox.kVSpace5,
                        const CustomStyledText(
                          text: "10",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.secondaryColor,
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}
