import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

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
          disabledBackgroundColor: AppColors.secondaryColor,
          backgroundColor: AppColors.secondaryColor,
          padding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: AppPadding.mediumPadding),
        ),
        child: CustomStyledText(
          text: text,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          textColor: Colors.white,
        ),
      ),
    );
  }
}

class ButtonClose extends StatelessWidget {
  final VoidCallback onPressed;

  const ButtonClose({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: GestureDetector(
        onTap: onPressed,
        child: const CircleAvatar(
          radius: 15,
          backgroundColor: AppColors.secondaryColor,
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
