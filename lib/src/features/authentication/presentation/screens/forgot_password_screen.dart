import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/showTopSnackBar.dart';
import 'package:maintenance_app/src/features/authentication/data/model/forgot_password_model.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/state/auth_state.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/reset_password_screen.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/verification_screen.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/verify_reset_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController mobileNumberController = TextEditingController();

String? selectedCountryCode = '+966';

final List<String> gulfCountryCodes = [
  '+966',
  '+971',
  '+965',
  '+973',
  '+968',
  '+974',
];

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
      body: SingleChildScrollView(
        child: Column(
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: CustomStyledText(
                        text: "سيتم إرسال الكود إلى الواتساب الخاص بك",
                        fontSize: 16,
                        textColor: Colors.grey,
                      ),
                    ),
                    AppSizedBox.kVSpace10,
                    const CustomLabelText(text: 'البريد الإلكتروني'),
                    CustomInputField(
                      controller: emailController,
                      hintText: "أدخل البريد الالكتروني",
                      icon: Icons.email,
                    ),
                    AppSizedBox.kVSpace10,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: AlignmentDirectional.center,
                        children: [
                          Positioned(
                            left: 0,
                            child: Container(
                              width: 15,
                              height: 15,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 4,
                                  color:
                                      const Color.fromARGB(255, 237, 228, 253),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              width: 15,
                              height: 15,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 4,
                                  color:
                                      const Color.fromARGB(255, 237, 228, 253),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 27),
                            height: 5,
                            color: const Color.fromARGB(255, 237, 228, 253),
                          ),
                          const CircleAvatar(
                              radius: 25, child: CustomStyledText(text: 'أو')),
                        ],
                      ),
                    ),
                    const CustomLabelText(text: 'رقم الموبايل'),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: AppPadding.mediumPadding),
                            child: DropdownSearch<String>(
                              items: gulfCountryCodes,
                              selectedItem: selectedCountryCode,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: "أختر رقم",
                                  filled: true,
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Tajawal",
                                  ),
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                    horizontal: 18,
                                  ),
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                menuProps: MenuProps(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: "ابحث عن رمز الدولة ..",
                                    filled: true,
                                    hintStyle: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Tajawal",
                                    ),
                                    fillColor: Colors.grey.withOpacity(0.2),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                      horizontal: 18,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: "Tajawal",
                                    fontSize: 16,
                                  ),
                                ),
                                itemBuilder: (context, item, isSelected) {
                                  return ListTile(
                                    title: Text(
                                      item,
                                      style: const TextStyle(
                                        fontFamily: "Tajawal",
                                        fontSize: 14,
                                      ),
                                    ),
                                    selected: isSelected,
                                  );
                                },
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedCountryCode = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: CustomInputField(
                            hintText: 'ادخل رقم الموبايل',
                            icon: CupertinoIcons.phone_solid,
                            controller: mobileNumberController,
                          ),
                        ),
                      ],
                    ),
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state.forgotPasswordStatus ==
                            ForgotPasswordStatus.failure) {
                          showTopSnackBar(
                              context,
                              "فشل تسجيل دخول , يرجي اعادة المحاولة",
                              Colors.red);
                        }
                        if (state.forgotPasswordStatus ==
                            ForgotPasswordStatus.success) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => VerifyResetCodeScreen(
                                phone: state.phone,
                              ),
                            ),
                          );
                        }
                      },
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state.forgotPasswordStatus ==
                              ForgotPasswordStatus.loading) {
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
                                selectedCountryCode =
                                    selectedCountryCode?.replaceAll("+", "");

                                context.read<AuthCubit>().forgotPassword(
                                      ForgotPasswordModel(
                                        selectedCountryCode,
                                        mobileNumberController.text.trim(),
                                        emailController.text.trim(),
                                      ),
                                    );
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
      ),
    );
  }
}
