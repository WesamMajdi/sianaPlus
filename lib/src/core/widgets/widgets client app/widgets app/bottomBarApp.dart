import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/favorite/favourite_screen.dart';
import '../../../../features/client app/presentation/screens/home/home_screen.dart';

class BottomAppBarApplication extends StatelessWidget {
  final int currentIndex;

  const BottomAppBarApplication({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 65,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Row(
              children: [
                Icon(
                  currentIndex == 0 ? Icons.home : Icons.home_outlined,
                  color: currentIndex == 0
                      ? AppColors.secondaryColor
                      // ignore: deprecated_member_use
                      : Colors.grey.withOpacity(0.8),
                  size: 35,
                ),
              ],
            ),
            onPressed: () {
              if (currentIndex != 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(
              currentIndex == 1
                  ? FontAwesomeIcons.solidHeart
                  : FontAwesomeIcons.heart,
              color: currentIndex == 1 ? AppColors.secondaryColor : Colors.grey,
              size: 26,
            ),
            onPressed: () {
              if (currentIndex != 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavouritePage()),
                );
              }
            },
          ),
          AppSizedBox.kWSpace20,
          AppSizedBox.kWSpace20,
          IconButton(
            icon: Icon(
              currentIndex == 2
                  ? FontAwesomeIcons.solidBell
                  : FontAwesomeIcons.bell,
              color: currentIndex == 2 ? AppColors.secondaryColor : Colors.grey,
              size: 26,
            ),
            onPressed: () {
              if (currentIndex != 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationsPage()),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(
              currentIndex == 3
                  ? FontAwesomeIcons.solidUser
                  : FontAwesomeIcons.user,
              color: currentIndex == 3 ? AppColors.secondaryColor : Colors.grey,
              size: 24,
            ),
            onPressed: () {
              if (currentIndex != 3) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfilePage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
