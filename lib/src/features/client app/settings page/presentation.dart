import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class UserSettingProfile extends StatefulWidget {
  const UserSettingProfile({super.key});

  @override
  State<UserSettingProfile> createState() => _UserSettingProfileState();
}

class _UserSettingProfileState extends State<UserSettingProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarApplicationArrow(
        text: 'الإعدادات والخصوصية',
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
              UserProfileMenu(
                icon: FontAwesomeIcons.solidBell,
                text: "الاشعارات",
                onTap: () {},
                isVisibl: true,
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
              const Divider(),
              UserProfileMenu(
                icon: FontAwesomeIcons.language,
                text: "اللغة",
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    builder: (BuildContext context) {
                      return const LanguageSelectionSheet();
                    },
                  );
                },
                isVisibl: true,
              ),
            ]),
          ),
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
                borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              UserProfileMenu(
                icon: FontAwesomeIcons.solidFlag,
                text: "الابلاغ عن مشكلة",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReportProblemPage(),
                      ));
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
                        builder: (context) => const ConcatInfoPage(),
                      ));
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
                        builder: (context) => PrivacyPolicyPage(),
                      ));
                },
                isVisibl: true,
              ),
            ]),
          ),
          AppSizedBox.kVSpace10,
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
                onTap: () {},
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
