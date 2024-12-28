// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20categorys/itemsMainCategorys.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20categorys/itemsSubCategorys.dart';
import '../../../core/export file/exportfiles.dart';
import '../presentation/controller/cubits/category_cubit.dart';
import '../presentation/controller/states/category_state.dart';
import 'data.dart';
import 'domain.dart';

class CategoryPage extends StatefulWidget {
  bool fromHomeScreen;
   CategoryPage({super.key,this.fromHomeScreen=false});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // int selectedMainCategoryId = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    !widget.fromHomeScreen ? context.read<CategoryCubit>().fetchSubCategories(
              mainCategoryId:
                  context.read<CategoryCubit>().state.categories.first.id,
            ): null;
    // context.read<CategoryCubit>().state.selectedCategoryId ==null? context.read<CategoryCubit>().selectCategory(
    //       categoryId: context.read<CategoryCubit>().state.categories.first.id,
    //     ): null ;
    // context.read<CategoryCubit>().fetchSubCategories(
    //       mainCategoryId:
    //           context.read<CategoryCubit>().state.categories.first.id,
    //     );
  }

  @override
  Widget build(BuildContext context) {
    // List<SubCategory> filteredSubCategories = subcategories
    //     .where((sub) => sub.parentId == selectedMainCategoryId)
    //     .toList();

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
            child: const CustomStyledText(
              text: "الاصناف الرئيسية",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textColor: AppColors.secondaryColor,
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
                    return Container(
                      height: 50,
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.transparent
                          : Colors.white),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return GestureDetector(
                            onTap: () async {
                              // setState(() {
                              //   selectedMainCategoryId = category.id;
                              // });

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
              textColor: AppColors.secondaryColor,
            ),
          ),
          ItemsSubCategorys(),
        ],
      ),
    );
  }
}
