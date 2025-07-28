import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class CustomStyledText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double fontSize;
  final double? height;
  final FontWeight fontWeight;
  final String fontFamily;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  const CustomStyledText(
      {super.key,
      required this.text,
      this.textColor,
      this.fontSize = 16,
      this.height,
      this.fontWeight = FontWeight.w500,
      this.fontFamily = "Tajawal",
      this.textAlign,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor = textColor ??
        (Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : AppColors.primaryColor);

    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        height: height,
        color: effectiveTextColor,
        decoration: decoration,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }
}

class CustomLabelText extends StatelessWidget {
  final String text;

  const CustomLabelText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: CustomStyledText(
          text: text,
          textColor: (Theme.of(context).brightness == Brightness.dark
              ? AppColors.lightGrayColor
              : AppColors.primaryColor),
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: "Tajawal",
        ),
      ),
    );
  }
}
