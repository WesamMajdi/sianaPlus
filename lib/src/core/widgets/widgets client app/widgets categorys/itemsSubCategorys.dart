import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/categorys%20page/domain.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';

import '../../../../features/client app/presentation/controller/cubits/category_cubit.dart';

class ItemsSubCategorys extends StatelessWidget {
  const ItemsSubCategorys({
    Key? key,
    required this.filteredSubCategories,
  }) : super(key: key);

  final List<SubCategory> filteredSubCategories;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        switch (state.subCategoryStatus) {
          case SubCategoryStatus.initial:
          case SubCategoryStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case SubCategoryStatus.failure:
            return Text(state.errorMessage!);
          case SubCategoryStatus.success:
            if (state.subCategories.isNotEmpty) {
              return Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: state.subCategories.length,
                  itemBuilder: (context, index) {
                    final subCategory = state.subCategories[index];
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
                                        builder: (context) => ProductPage(
                                            categoryId: subCategory.id),
                                      ),
                                    );
                                  },
                                  child: Align(
                                    // child: Image.network(
                                    //   subCategory.image,
                                    // ),
                                    child: Container(
                                      height: 100,
                                      width: 100,
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
                                  builder: (context) => ProductPage(
                                    categoryId: subCategory.id,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 40, bottom: 10),
                              decoration: BoxDecoration(
                                  color: (Theme.of(context).brightness ==
                                          Brightness.dark
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
                                    text: truncateTextDescription(
                                        subCategory.name),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    textColor: AppColors.secondaryColor,
                                  ),
                                  const SizedBox(height: 5),
                                  CustomStyledText(
                                    text: truncateTextDescription(
                                        subCategory.description ?? ''),
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
            } else {
              return Text('No Data');
            }
        }

        return Text('Some thing error');
      },
    );
  }
}
