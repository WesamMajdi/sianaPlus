import 'package:flutter/gestures.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20categorys/itemsMainCategorys.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20categorys/itemsSubCategorys.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';

class CategoryPage extends StatefulWidget {
  bool fromHomeScreen;
  CategoryPage({super.key, this.fromHomeScreen = false});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();

    context.read<CategoryCubit>().getDiscount();

    if (!widget.fromHomeScreen) {
      final categories = context.read<CategoryCubit>().state.categories;
      if (categories.isNotEmpty) {
        context.read<CategoryCubit>().fetchSubCategories(
              mainCategoryId: categories.first.id,
            );
      } else {
        print('No categories available');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const AppBarApplication(
        text: 'تسوق اونلاين',
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            alignment: Alignment.centerRight,
            child: CustomStyledText(
              text: "الاصناف الرئيسية",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              switch (state.mainCategoryStatus) {
                case MainCategoryStatus.initial:
                case MainCategoryStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case MainCategoryStatus.failure:
                  return Text(state.errorMessage!);

                case MainCategoryStatus.success:
                  if (state.categories.isNotEmpty) {
                    return SizedBox(
                      height: 50,
                      child: ListView.builder(
                        reverse: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return GestureDetector(
                            onTap: () async {
                              context
                                  .read<CategoryCubit>()
                                  .selectCategory(categoryId: category.id);
                              await context
                                  .read<CategoryCubit>()
                                  .fetchSubCategories(
                                      mainCategoryId: category.id);
                            },
                            child: ItemsMainCategories(
                                state: state, category: category),
                          );
                        },
                      ),
                    );
                  }
              }

              return Text('Some thing error');
            },
          ),
          AppSizedBox.kVSpace20,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerRight,
            child: const CustomStyledText(
              text: "الاصناف الفرعية",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const ItemsSubCategorys(),
        ],
      ),
    );
  }
}
