import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/showTopSnackBar.dart';

import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/state/auth_state.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({super.key});

  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  final TextEditingController newPhoneNumberController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.updatePhone == UpdatePhoneStatus.success) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const SuccessPage(
                message: "تم تغيير رقم الهاتف بنجاح!!",
              ),
            ),
          );
        } else if (state.updatePhone == UpdatePhoneStatus.failure) {
          showTopSnackBar(
              context, "فشل تسجيل دخول , يرجي اعادة المحاولة", Colors.red);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarApplicationArrow(
          text: "تغيير رقم الهاتف",
          onBackTap: () {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.lightGrayColor
                      : AppColors.primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
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
                    const CustomStyledText(
                      text: 'هل تريد تغيير رقم الهاتف الخاص بك؟',
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      textColor: AppColors.secondaryColor,
                    ),
                    AppSizedBox.kVSpace20,
                    const CustomLabelText(
                      text: 'ادخل رقم الهاتف الجديد',
                    ),
                    CustomInputField(
                      validators: (value) {
                        if (value == null || value.isEmpty) {
                          return 'عفوا. رقم الهاتف مطلوب';
                        }
                        if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
                          return 'رقم الهاتف غير صحيح';
                        }
                        return null;
                      },
                      controller: newPhoneNumberController,
                      hintText: "أدخل رقم الهاتف الجديد",
                      icon: Icons.phone,
                    ),
                    AppSizedBox.kVSpace20,
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return state.updatePhone == UpdatePhoneStatus.loading
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
                                    context.read<AuthCubit>().updatePhone(
                                        newPhoneNumberController.text.trim());
                                  }
                                },
                              );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
