import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/update_email_screen.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/update_phone_number_screen.dart';

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(
        text: "معلومات الحساب",
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
                  text: "رقم الهاتف",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePhoneNumberScreen(),
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
                          builder: (context) => const UpdateEmailScreen(),
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
