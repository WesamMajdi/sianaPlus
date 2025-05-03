import 'package:flutter/gestures.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20categorys/itemsMainCategorys.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20categorys/itemsSubCategorys.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';

class CategoryPage extends StatefulWidget {
  final bool fromHomeScreen;
  final int? currentIndex;

  const CategoryPage({
    super.key,
    this.fromHomeScreen = false,
    this.currentIndex = 1,
  });

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    context.read<CategoryCubit>().getDiscount();
    context.read<CategoryCubit>().fetchCategories();

    if (!widget.fromHomeScreen) {
      final categories = context.read<CategoryCubit>().state.categories;
      if (categories.isNotEmpty) {
        _onCategorySelected(categories.first.id);
      } else {
        print('No categories available');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        currentIndex: widget.currentIndex,
      ),
      appBar: const AppBarApplication(
        text: 'تسوق اونلاين',
      ),
      body: Column(
        children: [
          _buildMainCategoriesHeader(),
          _buildMainCategoriesList(),
          AppSizedBox.kVSpace20,
          _buildSubCategoriesHeader(),
          _buildSubCategoriesList(),
        ],
      ),
    );
  }

  Widget _buildMainCategoriesHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      alignment: Alignment.centerRight,
      child: const CustomStyledText(
        text: "الاصناف الرئيسية",
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildMainCategoriesList() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        switch (state.mainCategoryStatus) {
          case MainCategoryStatus.initial:
          case MainCategoryStatus.loading:
            return const Center(child: CircularProgressIndicator());

          case MainCategoryStatus.failure:
            return Text(state.errorMessage!);

          case MainCategoryStatus.success:
            return SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return GestureDetector(
                    onTap: () => _onCategorySelected(category.id),
                    child: ItemsMainCategories(
                      state: state,
                      category: category,
                    ),
                  );
                },
              ),
            );
        }
      },
    );
  }

  void _onCategorySelected(int categoryId) async {
    context.read<CategoryCubit>().selectCategory(categoryId: categoryId);
    await context.read<CategoryCubit>().fetchSubCategories(
          mainCategoryId: categoryId,
        );
  }

  Widget _buildSubCategoriesHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerRight,
      child: const CustomStyledText(
        text: "الاصناف الفرعية",
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubCategoriesList() {
    return Expanded(
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state.subCategoryStatus == SubCategoryStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.subCategories.isEmpty) {
            return const Center(
                child: CustomStyledText(text: 'لا توجد أصناف فرعية'));
          }

          return ListView.builder(
            itemCount: state.subCategories.length,
            itemBuilder: (context, index) {
              final subCategory = state.subCategories[index];
              return ItemsSubCategorys(subCategory: subCategory);
            },
          );
        },
      ),
    );
  }
}
