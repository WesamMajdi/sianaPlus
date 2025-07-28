import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage(
      {super.key, this.fromHomeScreen = false, this.currentIndex});
  final bool? fromHomeScreen;
  final int? currentIndex;

  @override
  State<CategoryPage> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryPage> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getDiscount();
    context.read<CategoryCubit>().fetchCategories();
  }

  void _onCategorySelected(int categoryId) async {
    context.read<CategoryCubit>().selectCategory(categoryId: categoryId);
    await context
        .read<CategoryCubit>()
        .fetchSubCategories(mainCategoryId: categoryId);
  }

  Widget buildServiceCard({
    required int id,
    required String title,
    required String imageUrl,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(categoryId: id),
            ),
          );
        },
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            IMAGE_URL + imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          ),
        ),
        title: CustomStyledText(
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomStyledText(
              text: description,
              fontSize: 12,
              textColor: Colors.grey,
            ),
            const SizedBox(height: 4),
            Row(
              children: const [
                Icon(Icons.star, color: Colors.orange, size: 20),
                AppSizedBox.kWSpace5,
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child:
                      CustomStyledText(text: '4.8 | 1200 تقييم', fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.bookmark, color: AppColors.secondaryColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (!_isInitialized &&
            state.mainCategoryStatus == MainCategoryStatus.success &&
            state.categories.isNotEmpty) {
          _isInitialized = true;
          _onCategorySelected(state.categories.first.id);
        }

        return Scaffold(
          drawer: MyDrawer(
            currentIndex: widget.currentIndex,
          ),
          appBar: AppBarApplication(
            text: 'المتجر',
          ),
          body: Column(
            children: [
              AppSizedBox.kVSpace10,
              SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    final selected = category.id == state.selectedCategoryId;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ChoiceChip(
                        label: Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: CustomStyledText(
                            text: category.name,
                            fontSize: 12,
                          ),
                        ),
                        selected: selected,
                        onSelected: (_) => _onCategorySelected(category.id),
                        selectedColor: AppColors.secondaryColor,
                        labelStyle: TextStyle(
                          color: selected
                              ? Colors.white
                              : AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side:
                              const BorderSide(color: AppColors.secondaryColor),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: state.subCategoryStatus == SubCategoryStatus.loading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: state.subCategories.length,
                        itemBuilder: (context, index) {
                          final sub = state.subCategories[index];
                          return buildServiceCard(
                            id: sub.id,
                            title: sub.name,
                            imageUrl: sub.image,
                            description: sub.description ?? '',
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
