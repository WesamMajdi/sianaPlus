import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class SideMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isActive;

  const SideMenuTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color activeColor = AppColors.secondaryColor;
    final Color inactiveColor =
        isDark ? AppColors.lightGrayColor : Colors.black54;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isActive ? activeColor.withOpacity(0.1) : Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.largePadding,
          vertical: AppPadding.mediumPadding,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? activeColor : inactiveColor,
            ),
            AppSizedBox.kWSpace20,
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: CustomStyledText(
                text: title,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                textColor: isActive ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
