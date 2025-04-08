import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/authentication/data/model/signup_model.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/home/home_screen.dart';

import '../controller/state/auth_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  // TextEditingController locationController = TextEditingController();
  String? originalPassword = '';

  @override
  void initState() {
    super.initState();
  }

  String? selectedCountryCode = '+966';

  final List<String> gulfCountryCodes = [
    '+966',
    '+971',
    '+965',
    '+973',
    '+968',
    '+974',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarApplicationArrow(
        text: "تسجيل حساب جديد",
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
                                hintStyle: TextStyle(
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
                              style: TextStyle(
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
                              selectedCountryCode = value?.replaceAll("+", "");
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
                        validators: (value) {
                          if (value == null || value.isEmpty) {
                            return 'عفوا.رقم الموبايل مطلوب';
                          }
                          if (!RegExp(r'^\+?[0-9]{9,15}$').hasMatch(value)) {
                            return 'رقم الموبايل غير صحيح';
                          }
                          return null;
                        },
                        controller: mobileNumberController,
                      ),
                    ),
                  ],
                ),
                const CustomLabelText(text: 'كلمة المرور'),
                CustomInputFieldPassword(
                  controller: passwordController,
                  validators: (value) {
                    if (value == null || value.isEmpty) {
                      return 'عفوا.كلمة المرور مطلوبة';
                    }
                    if (value.length < 6) {
                      return 'عفوا.يجب أن تكون كلمة المرور 6 أحرف وأكثر';
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
                    if (value.length < 6) {
                      return 'عفوا.يجب أن تكون كلمة المرور 8 أحرف وأكثر';
                    }

                    return null;
                  },
                  hintText: 'تاكيد كلمة المرور',
                  icon: CupertinoIcons.lock_circle_fill,
                ),
                // const CustomLabelText(text: 'العنوان'),
                // CustomInputFielLocation(
                //   hintText: 'حدد موقعك',
                //   icon: Icons.location_off_rounded,
                //   controller: locationController,
                // ),
              ],
            ),
          ),
          AppSizedBox.kVSpace10,
          AppSizedBox.kVSpace10,
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: CustomStyledText(
                      text: "فشل تسجيل دخول , يرجي اعادة المحاولة",
                    ),
                    backgroundColor: Colors.red));
              }
              if (state.status == AuthStatus.success) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const HomePage(),
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
                  text: "تسجيل حساب",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().signup(SignupModel(
                            fullName: fullnameController.text,
                            email: usernameController.text,
                            password: passwordController.text,
                            confirmPassword: confirmpasswordController.text,
                            phoneNumber: mobileNumberController.text,
                            countryCode: selectedCountryCode!,
                          ));
                    }
                  },
                );
              },
            ),
          ),
          AppSizedBox.kVSpace5,
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
                        builder: (context) => const LoginScreen(),
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
    );
  }
}
