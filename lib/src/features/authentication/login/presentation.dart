import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/authentication/forgot%20password/presentation.dart';
import 'package:maintenance_app/src/features/authentication/sign%20up/presentation.dart';

import 'application.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/siana_plus_logo.png',
              width: 280,
            ),
            const CustomStyledText(
              text: "مرحباً بك في صيانة بلس",
              textColor: AppColors.secondaryColor,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            AppSizedBox.kVSpace15,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomInputField(
                      hintText: 'ادخل البريد الإلكتروني',
                      icon: CupertinoIcons.mail_solid,
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
                      controller: usernameController),
                  AppSizedBox.kVSpace10,
                  CustomInputFieldPassword(
                    controller: passwordController,
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.كلمة المرور مطلوبة';
                      }

                      return null;
                    },
                    hintText: 'ادخل كلمة المرور',
                    icon: CupertinoIcons.lock_circle_fill,
                  ),
                  AppSizedBox.kVSpace10,
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ));
                    },
                    child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 20),
                        child: const CustomStyledText(
                          text: 'هل نسيت كلمة المرور ؟',
                          fontWeight: FontWeight.w500,
                          textColor: Colors.grey,
                          fontSize: 14,
                        )),
                  ),
                ],
              ),
            ),
            AppSizedBox.kVSpace10,
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                } else if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("فشل تسجيل الدخول: ${state.error}"),
                  ));
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const CircularProgressIndicator();
                }
                return CustomButton(
                  text: "تسجيل دخول",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<LoginCubit>().login(
                            usernameController.text,
                            passwordController.text,
                          );
                    }
                  },
                );
              },
            ),
            AppSizedBox.kVSpace5,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomStyledText(
                    text: 'ليس لديك حساب؟',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ),
                      );
                    },
                    child: const CustomStyledText(
                      fontWeight: FontWeight.bold,
                      text: "انشاء حساب جديد",
                      fontSize: 18,
                      textColor: AppColors.secondaryColor,
                    )),
              ],
            ),
            AppSizedBox.kVSpace20,
            AppSizedBox.kVSpace20,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomStyledText(
                    text: 'هل لديك مشكلة او ترغب في الاستفسار عن شئ',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConcatInfoPage(),
                        ),
                      );
                    },
                    child: const CustomStyledText(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      text: "تواصل معنا",
                      textColor: AppColors.secondaryColor,
                    )),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBarLoginPage(),
    );
  }
}

class BottomBarLoginPage extends StatelessWidget {
  const BottomBarLoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: (Theme.of(context).brightness == Brightness.dark
          ? Colors.transparent
          : Colors.white24),
      padding: const EdgeInsets.only(bottom: 30),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomStyledText(
            text: " الاصدار :",
            textColor: AppColors.secondaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          AppSizedBox.kWSpace5,
          CustomStyledText(
            text: " 1.0.0 ",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
