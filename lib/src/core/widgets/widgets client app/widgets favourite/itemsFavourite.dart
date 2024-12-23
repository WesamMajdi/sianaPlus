import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/favourite/favourite_entity.dart';

class FavouriteCard extends StatelessWidget {
  final Favourite item;

  const FavouriteCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (Theme.of(context).brightness == Brightness.dark
            ? Colors.black54
            : Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              image: DecorationImage(
                image: AssetImage(item.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AppSizedBox.kWSpace20,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomStyledText(
                    text: item.name,
                    fontSize: 20,
                    textColor: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  AppSizedBox.kVSpace5,
                  CustomStyledText(
                      text: truncateTextDescription(item.description),
                      fontSize: 14,
                      textColor: Colors.grey),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
