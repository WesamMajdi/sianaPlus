import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/showTopSnackBar.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_email_model.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/state/auth_state.dart';

class UpdateEmailScreen extends StatefulWidget {
  const UpdateEmailScreen({super.key});

  @override
  State<UpdateEmailScreen> createState() => _UpdateEmailScreenState();
}

TextEditingController newEmailController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _UpdateEmailScreenState extends State<UpdateEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarApplicationArrow(
        text: "تغيير البريد الالكتروني",
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
                      text: 'هل تريد تغيير الايميل الخاص بك؟',
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      textColor: AppColors.secondaryColor,
                    ),
                  ),
                  AppSizedBox.kVSpace20,
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
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state.updateEmailStatus ==
                          UpdateEmailStatus.failure) {
                        Navigator.pop(context);
                        showTopSnackBar(context,
                            "فشل تسجيل دخول , يرجي اعادة المحاولة", Colors.red);
                      }
                      if (state.updateEmailStatus ==
                          UpdateEmailStatus.success) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const SuccessPage(
                              message: "تم تغيير البريد بنجاح!!",
                            ),
                          ),
                        );
                      }
                    },
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state.updateEmailStatus ==
                            UpdateEmailStatus.loading) {
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
                              context
                                  .read<AuthCubit>()
                                  .updateEmail(UpdateEmailModel(
                                    newEmail: newEmailController.text.trim(),
                                  ));
                              newEmailController = TextEditingController();
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
