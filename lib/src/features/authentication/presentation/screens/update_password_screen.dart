import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/showTopSnackBar.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_password_model.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/state/auth_state.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

TextEditingController oldPasswordController = TextEditingController();
TextEditingController newPasswordController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarApplicationArrow(
        text: "تغيير كلمة المرور",
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.updatePasswordStatus == UpdatePasswordStatus.success) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const SuccessPage(
                  message: "تم تغيير كلمة المرور بنجاح!!",
                ),
              ),
            );
          } else if (state.updatePasswordStatus ==
              UpdatePasswordStatus.failure) {
            showTopSnackBar(
                context, "فشل تسجيل دخول , يرجي اعادة المحاولة", Colors.red);
          }
        },
        builder: (context, state) {
          return ListView(
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
                      margin: const EdgeInsets.only(right: 10),
                      child: const CustomStyledText(
                        text: 'هل تريد تغيير كلمة المرور الخاصة بك؟',
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        textColor: AppColors.secondaryColor,
                      ),
                    ),
                    AppSizedBox.kVSpace20,
                    const CustomLabelText(text: 'كلمة المرور الحالية'),
                    CustomInputFieldPassword(
                      controller: oldPasswordController,
                      validators: validatePassword,
                      hintText: 'ادخل كلمة المرور الحالية',
                      icon: CupertinoIcons.lock_shield_fill,
                    ),
                    const CustomLabelText(text: 'كلمة المرور الجديدة'),
                    CustomInputFieldPassword(
                      controller: newPasswordController,
                      validators: validatePassword,
                      hintText: 'ادخل كلمة المرور الجديدة',
                      icon: CupertinoIcons.lock_shield_fill,
                    ),
                    AppSizedBox.kVSpace20,
                    state.updatePasswordStatus == UpdatePasswordStatus.loading
                        ? CustomButton(
                            text: "",
                            onPressed: () {},
                            child: const SizedBox(
                              width: 30.0,
                              height: 30.0,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : CustomButton(
                            text: 'إرسال',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<AuthCubit>()
                                    .updatePassword(UpdtePasswordModel(
                                      oldPassword:
                                          oldPasswordController.text.trim(),
                                      newPassword:
                                          newPasswordController.text.trim(),
                                    ));
                              }
                            },
                          ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 6) {
      return 'يجب أن تكون كلمة المرور  6 أحرف أو أكثر';
    }

    return null;
  }
}
