import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/authentication/change%20phone%20number/presentation.dart';

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(text: "معلومات الحساب"),
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
                  text: "رقم الهاتف",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePhoneNumberPage(),
                        ));
                  },
                  isVisibl: true,
                ),
                const Divider(),
                UserProfileMenu(
                  text: "البريد الإلكتروني ",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangeEmailPage(),
                        ));
                  },
                  isVisibl: true,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
