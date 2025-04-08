import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';
import '../../../../../core/export file/exportfiles.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) => Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBarApplication(
          text: "المفضلة",
          actions: [
            PopupMenuButton(
              splashRadius: 4,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        InkWell(
                            child: const CustomStyledText(
                              text: "حذف الكل",
                              textColor: Colors.red,
                              fontSize: 18,
                            ),
                            onTap: () async => await context
                                .read<CategoryCubit>()
                                .deleteAllFavorite())
                      ],
                    ),
                  ),
                ];
              },
              onSelected: (String value) async {},
            ),
          ],
        ),
        body: state.favouriteProducts.isEmpty
            ? _buildEmptyFavorites(context)
            : ListView.builder(
                itemCount: state.favouriteProducts.length,
                itemBuilder: (context, index) {
                  return FavouriteCard(item: state.favouriteProducts[index]);
                },
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const FloatingButtonInBottomBar(),
        bottomNavigationBar: const BottomAppBarApplication(currentIndex: 1),
      ),
    );
  }

  Widget _buildEmptyFavorites(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.heart,
            size: 120,
            color: Colors.redAccent,
          ),
          AppSizedBox.kVSpace10,
          const SizedBox(height: 20),
          const CustomStyledText(
            text: "لا توجد منتجات في المفضلة",
            textColor: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          AppSizedBox.kVSpace10,
          CustomButton(
              text: "ابحث عن منتجات",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchProductPage(),
                  ),
                );
              })
        ],
      ),
    );
  }
}
