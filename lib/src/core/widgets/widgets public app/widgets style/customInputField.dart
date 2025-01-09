import 'package:flutter/services.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final FormFieldValidator<String>? validators;
  final TextEditingController? controller;
  const CustomInputField(
      {super.key,
      required this.hintText,
      required this.icon,
      this.validators,
      this.controller});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.mediumPadding, vertical: 5),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validators,
        cursorColor: AppColors.darkGrayColor,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          suffixIconColor: AppColors.darkGrayColor,
          iconColor: AppColors.darkGrayColor,
          errorStyle: const TextStyle(fontFamily: "Tajawal", fontSize: 14),
          hintStyle: const TextStyle(
              fontSize: 16, color: Colors.grey, fontFamily: "Tajawal"),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.secondaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.secondaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.smallPadding,
                vertical: AppPadding.smallPadding),
            child: Icon(
              widget.icon,
              size: 22,
              color: Colors.grey[500],
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppPadding.mediumPadding,
            horizontal: AppPadding.mediumPadding,
          ),
        ),
      ),
    );
  }
}

class CustomInputFieldPassword extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final FormFieldValidator<String>? validators;
  final TextEditingController? controller;

  const CustomInputFieldPassword({
    super.key,
    required this.hintText,
    required this.icon,
    this.validators,
    this.controller,
  });

  @override
  State<CustomInputFieldPassword> createState() =>
      _CustomInputFieldPasswordState();
}

class _CustomInputFieldPasswordState extends State<CustomInputFieldPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.mediumPadding, vertical: 5),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validators,
        obscureText: _obscureText,
        cursorColor: AppColors.darkGrayColor,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          suffixIconColor: AppColors.darkGrayColor,
          iconColor: AppColors.darkGrayColor,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: "Tajawal",
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: const TextStyle(
            fontFamily: "Tajawal",
            fontSize: 14,
          ),
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
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.smallPadding,
              vertical: AppPadding.smallPadding,
            ),
            child: Icon(
              widget.icon,
              size: 24,
              color: Colors.grey[500],
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 10,
              ),
              child: Icon(
                Icons.visibility,
                size: 24,
                color:
                    _obscureText ? Colors.grey[500] : AppColors.secondaryColor,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppPadding.mediumPadding,
            horizontal: AppPadding.mediumPadding,
          ),
        ),
      ),
    );
  }
}

class CustomInputFielLocation extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final FormFieldValidator<String>? validators;
  final TextEditingController? controller;
  final bool? enabled;

  const CustomInputFielLocation({
    super.key,
    required this.hintText,
    required this.icon,
    this.validators,
    this.controller,
    this.enabled = true,
  });

  @override
  State<CustomInputFielLocation> createState() =>
      _CustomInputFielLocationState();
}

class _CustomInputFielLocationState extends State<CustomInputFielLocation> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.mediumPadding, vertical: 5),
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.controller,
        validator: widget.validators,
        obscureText: _obscureText,
        cursorColor: AppColors.darkGrayColor,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          suffixIconColor: AppColors.darkGrayColor,
          iconColor: AppColors.darkGrayColor,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: "Tajawal",
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.secondaryColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: const TextStyle(fontFamily: "Tajawal", fontSize: 14),
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
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.smallPadding,
              vertical: AppPadding.smallPadding,
            ),
            child: Icon(
              widget.icon,
              size: 24,
              color: Colors.grey[500],
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 10,
              ),
              child: Icon(
                Icons.location_on,
                size: 24,
                color:
                    _obscureText ? Colors.grey[500] : AppColors.secondaryColor,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppPadding.mediumPadding,
            horizontal: AppPadding.mediumPadding,
          ),
        ),
      ),
    );
  }
}
