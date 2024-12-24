import 'package:maintenance_app/src/features/client%20app/data/data_sources/favourite/favourite_data_source.dart';
import '../../../../../core/export file/exportfiles.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBarApplication(
        text: "المفضلة",
        actions: [
          PopupMenuButton(
            splashRadius: 4,
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      CustomStyledText(
                        text: "حذف الكل",
                        textColor: Colors.red,
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
              ];
            },
            onSelected: (String value) async {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: lstFavourite.length,
        itemBuilder: (context, index) {
          return FavouriteCard(item: lstFavourite[index]);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SearchProductPage()),
          );
        },
        child: const Icon(
          FontAwesomeIcons.magnifyingGlass,
          size: 20,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: const BottomAppBarApplication(currentIndex: 1),
    );
  }
}
