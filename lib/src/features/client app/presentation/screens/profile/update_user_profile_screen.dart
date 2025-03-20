import '../../../../../core/export file/exportfiles.dart';

class ChangeUserProfile extends StatefulWidget {
  const ChangeUserProfile({super.key});

  @override
  State<ChangeUserProfile> createState() => _ChangeUserProfileState();
}

class _ChangeUserProfileState extends State<ChangeUserProfile> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController loctionController = TextEditingController();
    TextEditingController phonenumberController = TextEditingController();
    return Scaffold(
        appBar: AppBarApplicationArrow(
          text: 'تعديل صفحتي ',
          onBackTap: () {
            Navigator.pop(context);
          },
        ),
        body: Form(
            key: _formKey,
            child: ListView(
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
                AppSizedBox.kVSpace10,
                const CustomLabelText(
                  text: 'الاسم الشخصي',
                ),
                CustomInputField(
                  controller: nameController,
                  hintText: 'ادخل اسمك',
                  icon: Icons.person,
                  validators: (value) {
                    if (value == null || value.isEmpty) {
                      return 'عفوا.هذا الحقل مطلوب';
                    }
                    return null;
                  },
                ),
                const CustomLabelText(
                  text: 'رقم الجوال',
                ),
                CustomInputField(
                  controller: phonenumberController,
                  validators: (value) {
                    if (value == null || value.isEmpty) {
                      return 'عفوا.هذا الحقل مطلوب';
                    }
                    return null;
                  },
                  hintText: 'ادخل رقم الجوال ',
                  icon: Icons.call,
                ),
                const CustomLabelText(
                  text: 'عنوان السكن',
                ),
                CustomInputField(
                  controller: loctionController,
                  validators: (value) {
                    if (value == null || value.isEmpty) {
                      return 'عفوا.هذا الحقل مطلوب';
                    }
                    return null;
                  },
                  hintText: 'ادخل  عنوان السكن ',
                  icon: Icons.location_off,
                ),
                CustomButton(
                  text: 'تعديل',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
                AppSizedBox.kVSpace20,
              ],
            )));
  }
}
