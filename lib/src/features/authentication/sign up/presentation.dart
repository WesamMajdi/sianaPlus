import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String? originalPassword = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarApplicationArrow(
        text: "تسجيل حساب جديد",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSizedBox.kVSpace10,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const CustomLabelText(text: 'الاسم كامل'),
                  CustomInputField(
                    hintText: 'ادخل الاسم كامل',
                    icon: CupertinoIcons.person_alt_circle,
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.الاسم مطلوب';
                      }
                      return null;
                    },
                    controller: fullnameController,
                  ),
                  AppSizedBox.kVSpace10,
                  const CustomLabelText(text: 'البريد الإلكتروني'),
                  CustomInputField(
                    hintText: 'ادخل البريد الإلكتروني',
                    icon: CupertinoIcons.mail_solid,
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.البريد الإلكتروني مطلوب';
                      }
                      if (!RegExp(
                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                      ).hasMatch(value)) {
                        return 'البريد الإلكتروني غير صحيح';
                      }
                      return null;
                    },
                    controller: usernameController,
                  ),
                  AppSizedBox.kVSpace10,
                  const CustomLabelText(text: 'رقم الموبايل'),
                  CustomInputField(
                    hintText: 'ادخل رقم الموبايل',
                    icon: CupertinoIcons.phone_solid,
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.رقم الموبايل مطلوب';
                      }
                      if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
                        return 'رقم الموبايل غير صحيح';
                      }
                      return null;
                    },
                    controller: mobileNumberController,
                  ),
                  const CustomLabelText(text: 'كلمة المرور'),
                  CustomInputFieldPassword(
                    controller: passwordController,
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.كلمة المرور مطلوبة';
                      }
                      if (value.length < 8) {
                        return 'عفوا.يجب أن تكون كلمة المرور 8 أحرف وأكثر';
                      }
                      if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                        return 'عفوا.يجب أن تحتوي كلمة المرور على حروف';
                      }
                      return null;
                    },
                    hintText: 'ادخل كلمة المرور',
                    icon: CupertinoIcons.lock_circle_fill,
                  ),
                  const CustomLabelText(text: 'تاكيد كلمة المرور'),
                  CustomInputFieldPassword(
                    controller: confirmpasswordController,
                    validators: (value) {
                      if (value != passwordController.text) {
                        return 'عفوا.كلمة المرور غير متطابقة';
                      }
                      if (value == null || value.isEmpty) {
                        return 'عفوا.كلمة المرور مطلوبة';
                      }
                      if (value.length < 8) {
                        return 'عفوا.يجب أن تكون كلمة المرور 8 أحرف وأكثر';
                      }
                      if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                        return 'عفوا.يجب أن تحتوي كلمة المرور على حروف';
                      }
                      return null;
                    },
                    hintText: 'تاكيد كلمة المرور',
                    icon: CupertinoIcons.lock_circle_fill,
                  ),
                  const CustomLabelText(text: 'العنوان'),
                  CustomInputFielLocation(
                    hintText: 'حدد موقعك',
                    icon: Icons.location_off_rounded,
                    controller: locationController,
                  ),
                ],
              ),
            ),
            AppSizedBox.kVSpace10,
            CustomButton(
              text: "تسجيل حساب",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                  // ignore: avoid_print
                  print("تم التحقق من البيانات بنجاح");
                }
              },
            ),
            AppSizedBox.kVSpace5,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomStyledText(
                    text: 'لديك حساب فعال؟',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const CustomStyledText(
                      fontWeight: FontWeight.bold,
                      text: "تسجيل دخول",
                      fontSize: 18,
                      textColor: AppColors.secondaryColor,
                    )),
              ],
            ),
            AppSizedBox.kVSpace15
          ],
        ),
      ),
    );
  }
}
