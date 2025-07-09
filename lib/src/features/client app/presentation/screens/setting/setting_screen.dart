import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/showTopSnackBar.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/profile_cubit.dart';

class UserSettingProfile extends StatefulWidget {
  const UserSettingProfile({super.key});

  @override
  State<UserSettingProfile> createState() => _UserSettingProfileState();
}

class _UserSettingProfileState extends State<UserSettingProfile> {
  bool notificationsEnabled = true;
  String? userRole;
  @override
  void initState() {
    super.initState();
    _loadNotificationStatus();
    _loadUserType();
  }

  Future<void> _loadNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    });
  }

  Future<void> _loadUserType() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('role');
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);

    setState(() {
      notificationsEnabled = value;
    });
    showTopSnackBar(
      context,
      value ? "تم تفعيل الإشعارات" : "تم إيقاف الإشعارات",
      value ? Colors.green : Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(
        text: 'الإعدادات والخصوصية',
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppSizedBox.kVSpace10,
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const CustomStyledText(
              text: "الحساب",
              fontWeight: FontWeight.bold,
              fontSize: 16,
              textColor: AppColors.secondaryColor,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              UserProfileMenu(
                icon: FontAwesomeIcons.solidUser,
                text: "الحساب",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountSetting(),
                      ));
                },
                isVisibl: true,
              ),
              const Divider(),
              UserProfileMenu(
                icon: FontAwesomeIcons.share,
                text: "مشاركة التطبيق",
                onTap: () {
                  shareAppLink();
                },
                isVisibl: true,
              ),
              const Divider(),
              UserProfileMenu(
                isVisibl: false,
                text: "حذف الحساب",
                icon: FontAwesomeIcons.trash,
                onTap: () async {
                  final bool? confirmLogin = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      title: const Row(
                        children: [
                          Icon(FontAwesomeIcons.trash,
                              color: Colors.red, size: 20.0),
                          AppSizedBox.kWSpace10,
                          Center(
                            child: CustomStyledText(
                              text: 'تأكيد على حذف الحساب',
                              textColor: AppColors.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      content: const CustomStyledText(
                        text: 'هل أنت متأكد أنك تريد حذف هذا الحساب؟',
                        fontSize: 14,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const CustomStyledText(
                              text: "حذف الحساب",
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
                  if (confirmLogin == true) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
              ),
            ]),
          ),
          AppSizedBox.kVSpace10,
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const CustomStyledText(
              text: "المحتوي والعرض",
              fontWeight: FontWeight.bold,
              fontSize: 16,
              textColor: AppColors.secondaryColor,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.solidBell,
                  size: 22,
                  color: Colors.grey,
                ),
                title: const CustomStyledText(
                  text: "الإشعارات",
                  fontWeight: FontWeight.bold,
                ),
                trailing: Switch(
                  value: notificationsEnabled,
                  onChanged: _toggleNotifications,
                ),
              ),
              const Divider(),
              UserProfileMenu(
                icon: FontAwesomeIcons.solidMoon,
                text: "العرض",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DisplayPage(),
                      ));
                },
                isVisibl: true,
              ),
            ]),
          ),
          AppSizedBox.kVSpace10,
          if (userRole == "Customer") ...[
            AppSizedBox.kVSpace10,
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const CustomStyledText(
                text: "الدعم وحول التطبيق",
                fontWeight: FontWeight.bold,
                textColor: AppColors.secondaryColor,
                fontSize: 16,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(children: [
                UserProfileMenu(
                  icon: FontAwesomeIcons.solidFlag,
                  text: "الابلاغ عن مشكلة",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReportProblemPage()),
                    );
                  },
                  isVisibl: true,
                ),
                const Divider(),
                UserProfileMenu(
                  isVisibl: true,
                  text: "تواصل معنا",
                  icon: FontAwesomeIcons.phone,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConcatInfoPage()),
                    );
                  },
                ),
                const Divider(),
                UserProfileMenu(
                  icon: FontAwesomeIcons.circleExclamation,
                  text: "الشروط والسياسات",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicyPage()),
                    );
                  },
                  isVisibl: true,
                ),
              ]),
            ),
          ],
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const CustomStyledText(
              textColor: AppColors.secondaryColor,
              text: "تسجيل الخروج",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              UserProfileMenu(
                isVisibl: false,
                text: "تسجيل الخروج",
                icon: FontAwesomeIcons.rightFromBracket,
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

                  if (confirmLogout == true) {
                    try {
                      // Reset flags
                      resetFirstTime = true;

                      // حذف التوكنات القديمة
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
                      ]);

                      await Future.delayed(const Duration(milliseconds: 300));
                      String? newFcmToken =
                          await FirebaseMessaging.instance.getToken();
                      print("🎯 New FCM Token بعد الحذف: $newFcmToken");
                      await TokenManager.saveFcmToken(newFcmToken!);
                      // ignore: use_build_context_synchronously
                      context.read<ProfileCubit>().reset();
                      // ignore: use_build_context_synchronously
                      context.read<ProfileCubit>().getUserProfile();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    } catch (e) {
                      print('حدث خطأ أثناء تسجيل الخروج: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('حدث خطأ أثناء تسجيل الخروج')),
                      );
                    }
                  }
                },
              ),
            ]),
          ),
          AppSizedBox.kVSpace20,
          const Center(
            child: SizedBox(
              child: CustomStyledText(
                text: "V1.0.0",
                textColor: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          AppSizedBox.kVSpace10,
        ]),
      ),
    );
  }
}
