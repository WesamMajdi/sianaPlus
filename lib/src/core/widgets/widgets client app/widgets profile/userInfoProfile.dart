import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class UserInfoProfile extends StatelessWidget {
  final IconData icon;
  final String text;

  const UserInfoProfile({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: (Theme.of(context).brightness == Brightness.dark
              ? AppColors.lightGrayColor
              : AppColors.primaryColor),
          size: 20,
        ),
        const SizedBox(
          height: 30,
          width: 20,
          child: VerticalDivider(),
        ),
        CustomStyledText(
          text: text,
          fontSize: 18,
        ),
      ],
    );
  }
}
