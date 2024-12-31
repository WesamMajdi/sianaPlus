import 'package:maintenance_app/src/features/client%20app/data/data_sources/favourite/favourite_data_source.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';
import '../../../../../core/export file/exportfiles.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) =>
          Scaffold(
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
                              onTap: () async=>await context
                                  .read<CategoryCubit>()
                                  .deleteAllFavorite()
                            )
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
                ? _buildEmptyFavorites(context) // Show message when empty
                : ListView.builder(
              itemCount: state.favouriteProducts.length,
              itemBuilder: (context, index) {
                return FavouriteCard(item: state.favouriteProducts[index]);
              },
            ),

            floatingActionButtonLocation: FloatingActionButtonLocation
                .centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.secondaryColor,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchProductPage()),
                );
              },
              child: const Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 20,
                color: Colors.white,
              ),
            ),
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
            Icons.favorite_border,
            size: 100,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          const Text(
            "لا توجد منتجات في المفضلة", // Arabic: "No products in favorites"
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to product search
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchProductPage(),
                ),
              );
            },
            icon: const Icon(Icons.search),
            label: const Text(
                "ابحث عن منتجات"), // Arabic: "Search for Products"
          ),
        ],
      ),
    );
  }
}
