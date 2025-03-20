import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({super.key});

  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

TextEditingController passwordController = TextEditingController();
TextEditingController oldPhoneNumberController = TextEditingController();
TextEditingController newPhoneNumberController = TextEditingController();

final _formKey = GlobalKey<FormState>();

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarApplicationArrow(
        text: "تغيير رقم الهاتف",
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: (Theme.of(context).brightness == Brightness.dark
                    ? AppColors.lightGrayColor
                    : AppColors.primaryColor),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            height: 140,
            width: 120,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset("assets/images/logoWhit.png"),
            ),
          ),
          AppSizedBox.kVSpace20,
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const CustomStyledText(
                      text: 'هل تريد تغيير رقم الهاتف الخاص بك؟',
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      textColor: AppColors.secondaryColor,
                    ),
                  ),
                  AppSizedBox.kVSpace20,
                  const CustomLabelText(
                    text: 'ادخل الهاتف الحالي',
                  ),
                  CustomInputField(
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.الهاتف الحالي مطلوب';
                      }

                      if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
                        return 'رقم الهاتف غير صحيح';
                      }
                      return null;
                    },
                    controller: newPhoneNumberController,
                    hintText: " أدخل رقم الهاتف الحالي",
                    icon: Icons.email,
                  ),
                  const CustomLabelText(
                    text: 'ادخل رقم الهاتف الجديد',
                  ),
                  CustomInputField(
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.رقم الهاتف الجديد';
                      }

                      if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
                        return 'رقم الهاتف غير صحيح';
                      }
                      return null;
                    },
                    controller: oldPhoneNumberController,
                    hintText: "أدخل رقم الهاتف الجديد",
                    icon: Icons.email,
                  ),
                  const CustomLabelText(
                    text: 'تاكيد كلمة المرور ',
                  ),
                  CustomInputFieldPassword(
                    controller: passwordController,
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'كلمة المرور مطلوبة';
                      }
                      if (value.length < 8) {
                        return 'يجب أن تكون كلمة المرور 8 أحرف وأكثر';
                      }
                      if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                        return 'يجب أن تحتوي كلمة المرور على حروف';
                      }
                      return null;
                    },
                    hintText: 'ادخل كلمة المرور',
                    icon: CupertinoIcons.lock_circle_fill,
                  ),
                  CustomButton(
                    text: 'ارسال',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
