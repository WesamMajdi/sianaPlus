import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/authentication/data/model/login_model.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/state/auth_state.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/signup_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/home/home_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/home_delivery/home_delivery_shop_screen.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/home_maintenance/home_maintenance_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            Container(
              margin: const EdgeInsets.only(top: 80, bottom: 20),
              child: Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? 'assets/images/logoWhit.png'
                    : 'assets/images/logo.png',
                width: 150,
              ),
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
                            builder: (context) => const ForgotPasswordScreen(),
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
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.status == AuthStatus.success) {
                  if (state.user!.role == 'MaintenanceTechnician') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeMaintenanceScreen(),
                      ),
                    );
                  } else if (state.user!.role == 'Customer') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  } else if (state.user!.role == 'DeliveryShop') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeDeliveryScreen(),
                      ),
                    );
                  } else if (state.user!.role == 'DeliveryMaintenance') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HomeDeliveryMaintenanceScreen(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }
                } else if (state.status == AuthStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: CustomStyledText(
                        text: "فشل تسجيل دخول, يرجي اعادة المحاولة",
                      ),
                      backgroundColor: Colors.red));
                }
              },
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state.status == AuthStatus.loading) {
                    return CustomButton(
                      text: "",
                      onPressed: () {},
                      child: const SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return CustomButton(
                    text: "تسجيل دخول",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().login(
                              LoginModel(
                                  email: usernameController.text.trim(),
                                  password: passwordController.text.trim(),
                                  rememberMe: true,
                                  fcmToken: ""),
                            );
                      }
                    },
                  );
                },
              ),
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
                          builder: (context) => const SignupScreen(),
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
