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
        appBar: const AppBarApplicationArrow(
          text: 'تعديل صفحتي ',
        ),
        body: Form(
            key: _formKey,
            child: ListView(
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
