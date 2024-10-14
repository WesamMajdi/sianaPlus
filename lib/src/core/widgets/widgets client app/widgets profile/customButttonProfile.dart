import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class CustomButttonProfile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const CustomButttonProfile({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
            ),
            AppSizedBox.kWSpace10,
            CustomStyledText(
              text: text,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}
