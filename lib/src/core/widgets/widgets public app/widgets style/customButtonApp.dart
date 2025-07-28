import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.child,
    this.color,
    this.padding,
    this.margin, // <-- تمت إضافته هنا
  });

  final String text;
  final VoidCallback onPressed;
  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin; // <-- تمت إضافته هنا

  @override
  Widget build(BuildContext context) {
    final defaultColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.lightGrayColor
        : AppColors.primaryColor;

    final defaultPadding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: AppPadding.mediumPadding,
    );

    final defaultMargin = const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: AppPadding.smallPadding,
    );

    return Container(
      width: double.infinity,
      margin: margin ?? defaultMargin, // <-- استخدام margin القابل للتخصيص
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: color ?? defaultColor,
          disabledBackgroundColor: color ?? defaultColor,
          padding: padding ?? defaultPadding,
        ),
        child: child ??
            CustomStyledText(
              text: text,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              textColor: Colors.white,
            ),
      ),
    );
  }
}
