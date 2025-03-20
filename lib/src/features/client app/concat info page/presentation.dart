import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';

import 'application.dart';

class ConcatInfoPage extends StatefulWidget {
  const ConcatInfoPage({super.key});
  @override
  State<ConcatInfoPage> createState() => _ConcatInfoPageState();
}

class _ConcatInfoPageState extends State<ConcatInfoPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController opinionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarApplicationArrow(
          text: 'تواصل معنا',
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
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Image.asset("assets/images/logoWhit.png")),
              ),
              AppSizedBox.kVSpace20,
              const Column(
                children: [
                  CustomStyledText(
                    text: "لتواصل معنا:",
                    fontSize: 22,
                  ),
                  AppSizedBox.kVSpace20,
                  ConcatInfoFromSocialMedia(),
                ],
              ),
              AppSizedBox.kVSpace20,
              const Divider(
                color: Colors.black12,
              ),
              AppSizedBox.kVSpace10,
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const CustomLabelText(
                        text: 'اسم الشخصي',
                      ),
                      CustomInputField(
                        controller: nameController,
                        hintText: 'ادخل الاسم الشخصي',
                        validators: (value) {
                          if (value == null || value.isEmpty) {
                            return 'عفوا.الاسم مطلوب';
                          }
                          return null;
                        },
                        icon: Icons.text_fields,
                      ),
                      const CustomLabelText(
                        text: 'رقم التواصل',
                      ),
                      CustomInputField(
                        controller: phonenumberController,
                        hintText: "ادخل رقم لتواصل",
                        validators: (value) {
                          if (value == null || value.isEmpty) {
                            return 'عفوا.رقم الموبايل مطلوب';
                          }
                          if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
                            return 'رقم الموبايل غير صحيح';
                          }
                          return null;
                        },
                        icon: Icons.call_outlined,
                      ),
                      const CustomLabelText(
                        text: 'البريد الالكتروني',
                      ),
                      CustomInputField(
                        controller: emailController,
                        hintText: "ادخل البريد الالكتروني",
                        validators: (value) {
                          if (value == null || value.isEmpty) {
                            return 'عفوا.البريد الإلكتروني مطلوب';
                          }
                          if (!RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                          ).hasMatch(value)) {
                            return 'عفوا.البريد الإلكتروني غير صحيح';
                          }
                          return null;
                        },
                        icon: Icons.email,
                      ),
                      const CustomLabelText(
                        text: 'رأيك',
                      ),
                      Texteara(
                        hintText: 'ادخل رأيك',
                        controller: opinionController,
                        validators: (value) {
                          if (value == null || value.isEmpty) {
                            return 'عفوا.ادخل رأيك مطلوب';
                          }
                          return null;
                        },
                      ),
                      BlocConsumer<ContactUsCubit, ContactUsState>(
                        listener: (context, state) {
                          if (state is ContactUsSuccess) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SuccessPage(
                                    message: "تمت العملية بنجاح"),
                              ),
                            );
                            nameController.clear();
                            emailController.clear();
                            phonenumberController.clear();
                            opinionController.clear();
                          } else if (state is ContactUsFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('فشل إرسال الرسالة: ${state.error}')));
                          }
                        },
                        builder: (context, state) {
                          if (state is ContactUsLoading) {
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
                            text: 'ارسال رأي',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<ContactUsCubit>().createContactUs(
                                    nameController.text,
                                    emailController.text,
                                    phonenumberController.text,
                                    opinionController.text);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
