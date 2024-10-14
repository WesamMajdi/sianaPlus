import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarApplicationArrow(text: "الحساب"),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(children: [
                UserProfileMenu(
                  text: "معلومات الحساب",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountInfoPage(),
                        ));
                  },
                  isVisibl: true,
                ),
                const Divider(),
                UserProfileMenu(
                  text: "تنزيل سجل الظلبات التي تمت",
                  onTap: () {},
                  isVisibl: true,
                ),
                const Divider(),
                UserProfileMenu(
                  text: "كلمة السر",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordPage(),
                        ));
                  },
                  isVisibl: true,
                ),
                const Divider(),
                UserProfileMenu(
                  text: "تعطيل الحساب او حذفه",
                  onTap: () {},
                  isVisibl: true,
                ),
              ]),
            ),
            AppSizedBox.kVSpace20
          ],
        ),
      ),
    );
  }
}
