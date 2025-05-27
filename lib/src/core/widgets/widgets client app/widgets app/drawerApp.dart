import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/authentication/data/data_source/auth_data_source.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/category/category_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/ordered_product/ordered_product_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/orders_maintenance/maintenance_requests_for_approval_screen.dart';
import '../../../../features/client app/presentation/screens/home/home_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
    this.currentIndex,
  });
  final int? currentIndex;

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
      width: screenWidth * 0.68,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 60,
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
              backgroundColor: AppColors.lightGrayColor,
              child: Icon(
                FontAwesomeIcons.solidUser,
                color: Colors.black,
                size: 20,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomStyledText(
                  text: "مرحبًا بِكَ عزيزيّ",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  textColor: AppColors.lightGrayColor,
                ),
                AppSizedBox.kWSpace5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomStyledText(
                      text: truncateTextTitle(username!),
                      fontSize: 16,
                    ),
                    const Icon(Icons.arrow_back_ios,
                        size: 12, textDirection: TextDirection.ltr),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          AppSizedBox.kVSpace5,
          SideMenuTile(
            icon: FontAwesomeIcons.house,
            title: 'الرئيسية',
            isActive: widget.currentIndex == 0,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(
                      currentIndex: 0,
                    ),
                  ));
            },
          ),
          SideMenuTile(
            icon: FontAwesomeIcons.shapes,
            title: 'تسوق اونلاين',
            isActive: widget.currentIndex == 1,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryPage(fromHomeScreen: false, currentIndex: 1),
                  ));
            },
          ),
          SideMenuTile(
            icon: FontAwesomeIcons.cartShopping,
            title: 'سلة التسوق',
            isActive: widget.currentIndex == 2,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartShoppingPage(
                      currentIndex: 2,
                    ),
                  ));
            },
          ),
          SideMenuTile(
            // ignore: deprecated_member_use
            icon: FontAwesomeIcons.tools,
            isActive: widget.currentIndex == 3,

            title: 'طلب صيانة',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MaintenanceRequestPage(
                      currentIndex: 3,
                    ),
                  ));
            },
          ),
          SideMenuTile(
            icon: FontAwesomeIcons.solidCircleCheck,
            title: ' طلبات الموافقة',
            isActive: widget.currentIndex == 4,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MaintenanceRequestsForApprovalScreen(
                            currentIndex: 4),
                  ));
            },
          ),
          SideMenuTile(
            icon: FontAwesomeIcons.toolbox,
            title: 'طلبات الصيانة',
            isActive: widget.currentIndex == 5,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const OrdersMaintenancePage(currentIndex: 5),
                  ));
            },
          ),
          SideMenuTile(
            isActive: widget.currentIndex == 6,
            icon: FontAwesomeIcons.boxOpen,
            title: ' طلبات المنتجات',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const OrdersProductPage(currentIndex: 6),
                  ));
            },
          ),
          SideMenuTile(
            isActive: widget.currentIndex == 7,
            icon: FontAwesomeIcons.solidUser,
            title: 'الملف الشخصية',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const UserProfilePage(currentIndex: 7),
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
            onTap: () async {
              bool resetFirstTime = false;
              final bool? confirmLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  title: const Row(
                    children: [
                      Icon(FontAwesomeIcons.rightFromBracket,
                          color: Color.fromARGB(255, 162, 148, 199),
                          size: 24.0),
                      AppSizedBox.kWSpace10,
                      Center(
                        child: CustomStyledText(
                          text: 'تأكيد تسجيل الخروج',
                          textColor: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  content: const CustomStyledText(
                    text: 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                    fontSize: 14,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const CustomStyledText(
                          text: "تسجيل الخروج",
                          textColor: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
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
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
              print("confirmLogout 22222222222222222222222222222222");
              print(confirmLogout);
              if (confirmLogout == true) {
                try {
                  resetFirstTime = true;
                  print("resetFirstTime 555555555555555");

                  print(resetFirstTime);
                  String? currentFcmToken =
                      await FirebaseMessaging.instance.getToken();
                  print('📦 FCM Token قبل الحذف: $currentFcmToken');

                  String? savedToken = await TokenManager.getToken();
                  print('💾 TokenManager قبل الحذف: $savedToken');

                  await Future.wait([
                    FirebaseMessaging.instance.deleteToken(),

                    TokenManager.removefcmToken(),
                    TokenManager.removeToken(),

                    SharedPreferences.getInstance().then((prefs) async {
                      if (resetFirstTime) {
                        await prefs.setBool(FIRST_TIME_KEY, true);
                      }
                      await prefs.clear();
                    }),

                    // 4. إعلام الخادم بإلغاء التسجيل (اختياري)
                    // unregisterDeviceOnServer(),
                  ]);
                  await Future.delayed(const Duration(milliseconds: 300));
                  String? fcmTokenAfterDelete =
                      await TokenManager.getFcmToken();

                  print(
                      '📦 FCM Token بعد الحذف (مفترض يكون جديد أو null): $fcmTokenAfterDelete');

                  String? savedTokenAfter = await TokenManager.getToken();
                  print('💾 TokenManager بعد الحذف: $savedTokenAfter');
                  String? newFcmToken =
                      await FirebaseMessaging.instance.getToken();
                  print("🎯 New FCM Token بعد تسجيل الدخول: $newFcmToken");

                  await TokenManager.saveFcmToken(newFcmToken!);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                } catch (e) {
                  print('حدث خطأ أثناء تسجيل الخروج: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('حدث خطأ أثناء تسجيل الخروج')),
                  );
                }
              }
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
