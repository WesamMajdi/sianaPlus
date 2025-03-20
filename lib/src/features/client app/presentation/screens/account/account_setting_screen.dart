import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/update_password_screen.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(
        text: "الحساب",
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
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
                  text: "تنزيل سجل الطلبات",
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
                          builder: (context) => const UpdatePasswordScreen(),
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
