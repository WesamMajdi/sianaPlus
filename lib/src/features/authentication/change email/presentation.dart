import 'package:flutter/cupertino.dart';
import '../../../core/export file/exportfiles.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

TextEditingController passwordController = TextEditingController();
TextEditingController newEmailController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarApplicationArrow(
        text: "تغيير البريد الالكتروني",
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
                      text: 'هل تريد تغيير الايميل الخاص بك؟',
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      textColor: AppColors.secondaryColor,
                    ),
                  ),
                  AppSizedBox.kVSpace20,
                  const CustomLabelText(
                    text: 'ادخل الايميل الحالي',
                  ),
                  CustomInputField(
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.البريد الإلكتروني مطلوب';
                      }
                      if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          .hasMatch(value)) {
                        return 'عفوا.البريد الإلكتروني غير صحيح';
                      }
                      return null;
                    },
                    controller: newEmailController,
                    hintText: "أدخل البريد الالكتروني",
                    icon: Icons.email,
                  ),
                  const CustomLabelText(
                    text: 'ادخل الايميل الجديد',
                  ),
                  CustomInputField(
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.البريد الإلكتروني مطلوب';
                      }
                      if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          .hasMatch(value)) {
                        return 'عفوا.البريد الإلكتروني غير صحيح';
                      }
                      return null;
                    },
                    controller: newEmailController,
                    hintText: "أدخل البريد الالكتروني",
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
