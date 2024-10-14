import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class UserProfileMenu extends StatelessWidget {
  const UserProfileMenu({
    Key? key,
    this.icon,
    this.textColor = Colors.black,
    required this.text,
    required this.onTap,
    required this.isVisibl,
    this.colorIcon = Colors.grey,
  }) : super(key: key);

  final IconData? icon;
  final Color? textColor;
  final Color colorIcon;
  final String text;
  final GestureTapCallback onTap;
  final bool isVisibl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (icon != null)
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Icon(
                          icon,
                          color: colorIcon,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                AppSizedBox.kWSpace15,
                CustomStyledText(
                  text: text,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: const Icon(
                FontAwesomeIcons.angleLeft,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
