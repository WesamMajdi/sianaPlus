import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.child,
  });

  final String text;
  final VoidCallback onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
          horizontal: AppPadding.mediumPadding,
          vertical: AppPadding.smallPadding),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBackgroundColor:
              (Theme.of(context).brightness == Brightness.dark
                  ? AppColors.lightGrayColor
                  : AppColors.primaryColor),
          backgroundColor: (Theme.of(context).brightness == Brightness.dark
              ? AppColors.lightGrayColor
              : AppColors.primaryColor),
          padding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: AppPadding.mediumPadding),
        ),
        child: child ??
            CustomStyledText(
              text: text,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              textColor: Colors.white,
            ),
      ),
    );
  }
}
