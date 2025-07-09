import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/login_screen.dart';
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
                      ? (Theme.of(context).brightness == Brightness.dark
                          ? AppColors.lightGrayColor
                          : AppColors.primaryColor)
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
              color: currentIndex == 1
                  ? (Theme.of(context).brightness == Brightness.dark
                      ? AppColors.lightGrayColor
                      : AppColors.primaryColor)
                  : Colors.grey,
              size: 26,
            ),
            onPressed: () async {
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
              color: currentIndex == 2
                  ? (Theme.of(context).brightness == Brightness.dark
                      ? AppColors.lightGrayColor
                      : AppColors.primaryColor)
                  : Colors.grey,
              size: 26,
            ),
            onPressed: () async {
              String? token = await TokenManager.getToken();
              if (token == null) {
                final bool? confirmLogin = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    title: const Row(
                      children: [
                        Icon(FontAwesomeIcons.circleExclamation,
                            color: Color.fromARGB(255, 255, 173, 51),
                            size: 24.0),
                        AppSizedBox.kWSpace10,
                        Center(
                          child: CustomStyledText(
                            text: 'يتطلب تسجيل الدخول',
                            textColor: AppColors.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    content: const CustomStyledText(
                      text: 'يرجى تسجيل الدخول ليصلك الاشعارات .',
                      fontSize: 14,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const CustomStyledText(
                          text: "تسجيل الدخول",
                          textColor: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const CustomStyledText(
                          text: "إلغاء",
                          fontSize: 12,
                          textColor: AppColors.darkGrayColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );

                if (confirmLogin == true) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                }

                return;
              }
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
              color: currentIndex == 3
                  ? (Theme.of(context).brightness == Brightness.dark
                      ? AppColors.lightGrayColor
                      : AppColors.primaryColor)
                  : Colors.grey,
              size: 24,
            ),
            onPressed: () async {
              String? token = await TokenManager.getToken();
              if (token == null) {
                final bool? confirmLogin = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    title: const Row(
                      children: [
                        Icon(FontAwesomeIcons.circleExclamation,
                            color: Color.fromARGB(255, 255, 173, 51),
                            size: 24.0),
                        AppSizedBox.kWSpace10,
                        Center(
                          child: CustomStyledText(
                            text: 'يتطلب تسجيل الدخول',
                            textColor: AppColors.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    content: const CustomStyledText(
                      text: 'يرجى تسجيل الدخول لمشاهدة ملفك الشخصي .',
                      fontSize: 14,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const CustomStyledText(
                          text: "تسجيل الدخول",
                          textColor: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const CustomStyledText(
                          text: "إلغاء",
                          fontSize: 12,
                          textColor: AppColors.darkGrayColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );

                if (confirmLogin == true) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                }

                return;
              }
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
