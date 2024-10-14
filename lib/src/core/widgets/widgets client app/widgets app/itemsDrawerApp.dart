import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class SideMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SideMenuTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.largePadding,
            vertical: AppPadding.mediumPadding),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: (Theme.of(context).brightness == Brightness.dark
                  ? AppColors.lightGrayColor
                  : Colors.black),
            ),
            AppSizedBox.kWSpace20,
            CustomStyledText(
              text: title,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
