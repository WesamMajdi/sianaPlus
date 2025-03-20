import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/authentication/login/data.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/category/category_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/ordered_product/ordered_product_screen.dart';
import '../../../../features/client app/presentation/screens/home/home_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? username = '';
  String? email = '';

  Future<void> _loadUserData() async {
    String? storedName = await TokenManager.getName();
    // String? storedEmail = await TokenManager.getEmail();

    setState(() {
      username = storedName ?? 'User';
      // email = storedEmail ?? 'user@gmail.com';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      shape: const RoundedRectangleBorder(),
      shadowColor: AppColors.secondaryColor,
      width: screenWidth * 0.72,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfilePage(),
                  ));
            },
            leading: const CircleAvatar(
              radius: 25,
              child: Icon(
                FontAwesomeIcons.user,
                size: 20,
              ),
            ),
            title: Row(
              children: [
                CustomStyledText(
                  text: truncateTextTitle(username!),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.5,
                ),
                AppSizedBox.kWSpace5,
                const Icon(Icons.arrow_back_ios,
                    size: 12, textDirection: TextDirection.ltr),
              ],
            ),
            // subtitle: CustomStyledText(
            //   text: email!,
            //   fontSize: 14,
            //   textColor: Colors.grey.shade500,
            // ),
          ),
          const Divider(),
          // DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: (Theme.of(context).brightness == Brightness.dark
          //         ? AppColors.lightGrayColor
          //         : AppColors.primaryColor),
          //   ),
          //   child: const InfoCard(
          //     name: 'مدير التطبيق',
          //     username: '',
          //   ),
          // ),
          AppSizedBox.kVSpace5,
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
                    builder: (context) => CategoryPage(),
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
                    builder: (context) => const MaintenanceRequestPage(),
                  ));
            },
          ),
          SideMenuTile(
            icon: FontAwesomeIcons.boxOpen,
            title: ' طلبات المنتجات',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderedProductPage(),
                  ));
            },
          ),
          SideMenuTile(
            icon: FontAwesomeIcons.toolbox,
            title: 'طلبات الصيانة',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersMaintenancePage(),
                  ));
            },
          ),
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
          const Divider(),
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
          width: 150,
          height: 70,
          child: CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            child: Image.asset('assets/images/user_png.png'),
          ),
        ),
        AppSizedBox.kVSpace5,
        CustomStyledText(
          text: name!,
          fontWeight: FontWeight.bold,
          textColor: (Theme.of(context).brightness == Brightness.dark
              ? AppColors.primaryColor
              : AppColors.lightGrayColor),
          fontSize: 20,
        ),
        CustomStyledText(
          text: username,
          fontSize: 14,
          textColor: Colors.white54,
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }
}
