import 'package:flutter/material.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/authentication/data/model/forgot_password_model.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/state/auth_state.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/reset_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarApplicationArrow(
        text: "نسيت كلمة المرور",
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
            width: double.infinity,
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
                      text: 'هل نسيت كلمة المرور؟',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.secondaryColor,
                    ),
                  ),
                  AppSizedBox.kVSpace10,
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
                    controller: emailController,
                    hintText: "أدخل البريد الالكتروني",
                    icon: Icons.email,
                  ),
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state.status == AuthStatus.failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: Colors.red,
                              content: CustomStyledText(
                                  text: state.errorMessage ?? "حدث خطأ ما")),
                        );
                      }
                      if (state.status == AuthStatus.success) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const ResetPasswordScreen(),
                          ),
                        );
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
                          text: "ارسال",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().forgotPassword(
                                  ForgotPasswordModel(
                                      email: emailController.text.trim()));
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
