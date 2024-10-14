import 'package:flutter/cupertino.dart';
import '../../../core/export file/exportfiles.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

TextEditingController oldPasswordController = TextEditingController();
TextEditingController newPasswordController = TextEditingController();
TextEditingController confirmNewPasswordController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarApplicationArrow(
        text: "تغيير كلمة المرور",
      ),
      body: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            height: 150,
            width: 120,
            child: Image.asset("assets/images/siana_plus_logo.png"),
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
                      text: 'هل تريد تغيير كلمة المرورالخاص بك؟',
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      textColor: AppColors.secondaryColor,
                    ),
                  ),
                  AppSizedBox.kVSpace20,
                  const CustomLabelText(
                    text: 'كلمة المرور الحالية',
                  ),
                  CustomInputFieldPassword(
                    controller: oldPasswordController,
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
                    hintText: 'ادخل كلمة المرور الحالية',
                    icon: CupertinoIcons.lock_circle_fill,
                  ),
                  const CustomLabelText(
                    text: 'كلمة المرور الجديدة',
                  ),
                  CustomInputFieldPassword(
                    controller: newPasswordController,
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
                    hintText: 'ادخل كلمة المرور الجديدة',
                    icon: CupertinoIcons.lock_circle_fill,
                  ),
                  const CustomLabelText(
                    text: 'تاكيد كلمة المرور ',
                  ),
                  CustomInputFieldPassword(
                    controller: confirmNewPasswordController,
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
                    hintText: 'تاكيد كلمة المرور',
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
