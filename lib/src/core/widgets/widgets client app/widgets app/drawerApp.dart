import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/authentication/login/data.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/category_screen.dart';

import '../../../../features/client app/presentation/screens/home_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      shadowColor: AppColors.secondaryColor,
      width: screenWidth * 0.71,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: (Theme.of(context).brightness == Brightness.dark
                  ? AppColors.lightGrayColor
                  : AppColors.darkGrayColor),
            ),
            child: const InfoCard(
              name: 'مدير التطبيق',
              username: 'admin@gmail.com',
            ),
          ),
          SideMenuTile(
            icon: FontAwesomeIcons.house,
            title: 'الرئيسية',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            },
          ),
          SideMenuTile(
            icon: FontAwesomeIcons.shapes,
            title: 'تسوق اونلاين',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryPage(),
                  ));
            },
          ),
          SideMenuTile(
            icon: FontAwesomeIcons.cartShopping,
            title: 'سلة التسوق',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartShoppingPage(),
                  ));
            },
          ),
          SideMenuTile(
            // ignore: deprecated_member_use
            icon: FontAwesomeIcons.tools,
            title: 'طلب صيانة',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MaintenanceRequestPage(),
                  ));
            },
          ),
          SideMenuTile(
            icon: FontAwesomeIcons.boxOpen,
            title: 'طلباتي',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersPage(),
                  ));
            },
          ),

          // sideMenuTile(
          //   icon: FontAwesomeIcons.solidHeart,
          //   title: 'المفضلة',
          //   onTap: () {},
          // ),
          // sideMenuTile(
          //   icon: FontAwesomeIcons.solidBell,
          //   title: 'الاشعارات',
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const NotificationsPage(),
          //         ));
          //   },
          // ),
          SideMenuTile(
            icon: FontAwesomeIcons.solidUser,
            title: 'صفحتي الشخصية',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfilePage(),
                  ));
            },
          ),
          Divider(
            color: Colors.grey.withOpacity(0.4),
          ),
          SideMenuTile(
            icon: FontAwesomeIcons.gear,
            title: 'الاعدادات',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserSettingProfile(),
                ),
              );
            },
          ),
          SideMenuTile(
            icon: FontAwesomeIcons.rightFromBracket,
            title: 'تسجيل خروج',
            onTap: () {
              logout(context);
            },
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String? name;
  final String username;
  const InfoCard({
    Key? key,
    this.name,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 75,
          height: 70,
          child: CircleAvatar(
            backgroundColor: AppColors.secondaryColor,
            child: Image.asset('assets/images/siana_plus_logo2.png'),
          ),
        ),
        AppSizedBox.kVSpace10,
        CustomStyledText(
          text: name!,
          fontWeight: FontWeight.bold,
          textColor: AppColors.secondaryColor,
          fontSize: 20,
        ),
        AppSizedBox.kVSpace5,
        CustomStyledText(
          text: username,
          fontSize: 14,
          textColor: Colors.grey,
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }
}
