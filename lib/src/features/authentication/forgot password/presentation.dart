import '../../../core/export file/exportfiles.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarApplicationArrow(
        text: "نسيت كلمة المرور",
      ),
      body: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            height: 150,
            width: 120,
            child: Image.asset("assets/images/siana_plus_logo.png"),
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
                  CustomButton(
                    text: 'ارسال',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
