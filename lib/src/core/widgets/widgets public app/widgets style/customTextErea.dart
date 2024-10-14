import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class Texteara extends StatelessWidget {
  final String hintText;
  final FormFieldValidator<String>? validators;
  final TextEditingController? controller;

  const Texteara({
    Key? key,
    required this.hintText,
    this.validators,
    this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.mediumPadding),
      child: TextFormField(
        controller: controller,
        validator: validators,
        cursorColor: AppColors.darkGrayColor,
        textAlign: TextAlign.right,
        maxLines: 4,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          suffixIconColor: AppColors.darkGrayColor,
          iconColor: AppColors.secondaryColor,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: const TextStyle(fontFamily: "Tajawal", fontSize: 14),
          hintStyle: const TextStyle(
              fontSize: 16, color: Colors.grey, fontFamily: "Tajawal"),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.secondaryColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.secondaryColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
