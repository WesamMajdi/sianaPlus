import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/showTopSnackBar.dart';
import 'package:maintenance_app/src/features/authentication/data/model/reset_password_model.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/home/home_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/home_delivery/home_delivery_shop_screen.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/home_maintenance/home_maintenance_screen.dart';

import '../controller/state/auth_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarApplicationArrow(
        text: "استعادة كلمة المرور",
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: ListView(
        children: [
          AppSizedBox.kVSpace10,
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset("assets/images/logoWhit.png"),
                    ),
                  ),
                  AppSizedBox.kVSpace20,
                  const CustomLabelText(text: 'رقم الجوال'),
                  CustomInputField(
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.رقم الجوال  مطلوب';
                      }

                      return null;
                    },
                    controller: usernameController,
                    hintText: "أدخل رقم الجوال",
                    icon: Icons.email,
                  ),
                  const CustomLabelText(text: 'كلمة المرور'),
                  CustomInputFieldPassword(
                    hintText: 'ادخل كلمة المرور',
                    icon: CupertinoIcons.lock_circle_fill,
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.كلمة المرور مطلوب';
                      }
                      return null;
                    },
                    controller: passwordController,
                  ),
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state.resetPasswordStatus ==
                          ResetPasswordStatus.failure) {
                        showTopSnackBar(context,
                            "فشل تسجيل دخول , يرجي اعادة المحاولة", Colors.red);
                      }
                      if (state.resetPasswordStatus ==
                          ResetPasswordStatus.success) {
                        if (state.user!.role == 'MaintenanceTechnician') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const HomeMaintenanceScreen(),
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
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        }
                      }
                    },
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state.resetPasswordStatus ==
                            ResetPasswordStatus.loading) {
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
                          text: "ارسال",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().resetPassword(
                                  ResetPasswordModel(
                                      phoneNumber:
                                          usernameController.text.trim(),
                                      newPassword:
                                          passwordController.text.trim()));
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
