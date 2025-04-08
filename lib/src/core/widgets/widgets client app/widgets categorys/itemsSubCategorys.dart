import 'package:cached_network_image/cached_network_image.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';

import '../../../../features/client app/presentation/controller/cubits/category_cubit.dart';

class ItemsSubCategorys extends StatelessWidget {
  const ItemsSubCategorys({
    Key? key,
  }) : super(key: key);

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
                child: ListView.builder(
                  itemCount: state.subCategories.length,
                  itemBuilder: (context, index) {
                    final subCategory = state.subCategories[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: AppPadding.smallPadding),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductPage(categoryId: subCategory.id),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: IMAGE_URL + subCategory.image,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            title: CustomStyledText(
                              text: truncateTextTitle(subCategory.name),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textColor: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppColors.lightGrayColor
                                  : AppColors.primaryColor),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: CustomStyledText(
                                text: truncateTextDescription(
                                    subCategory.description ?? ''),
                                fontSize: 14,
                              ),
                            ),
                            trailing: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_forward_ios,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Column(
                children: [CustomStyledText(text: 'لا توجد اصناف')],
              );
            }
        }
        return const Text('Some thing error');
      },
    );
  }
}
