import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/features/authentication/data/model/reset_password_model.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';

import '../controller/state/auth_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController usernameController = TextEditingController();
TextEditingController codeController = TextEditingController();

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
                  const CustomLabelText(text: 'البريد الإلكتروني'),
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
                    controller: usernameController,
                    hintText: "أدخل البريد الالكتروني",
                    icon: Icons.email,
                  ),
                  const CustomLabelText(text: 'الكود'),
                  CustomInputField(
                    hintText: 'ادخل الكود',
                    icon: CupertinoIcons.person_alt_circle,
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'عفوا.الكود مطلوب';
                      }
                      return null;
                    },
                    controller: codeController,
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
                            builder: (_) => const SuccessPage(
                              message: "تم تغيير كلمة المرور بنجاح!!",
                            ),
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
                              context.read<AuthCubit>().resetPassword(
                                  ResetPasswordModel(
                                      email: usernameController.text.trim(),
                                      code: codeController.text.trim()));
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
