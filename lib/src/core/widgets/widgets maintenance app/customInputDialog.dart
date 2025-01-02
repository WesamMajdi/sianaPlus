import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class CustomInputDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String titleDialog;
  final String text;
  final String hintText;
  final FormFieldValidator<String>? validators;
  final TextEditingController? controller;
  const CustomInputDialog({
    Key? key,
    required this.onConfirm,
    required this.titleDialog,
    required this.text,
    required this.hintText,
    this.validators,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          CustomStyledText(
            text: titleDialog,
            fontSize: 18,
            textColor: AppColors.secondaryColor,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: double.infinity,
            color: Colors.grey,
            height: 0.5,
          ),
        ],
      ),
      content: SizedBox(
        height: 170,
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomStyledText(text: text, fontSize: 17),
            AppSizedBox.kVSpace10,
            Texteara(
              hintText: hintText,
              validators: validators,
              controller: controller,
            ),
            AppSizedBox.kVSpace10
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[500],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const CustomStyledText(
            text: "إلغاء",
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: AppColors.secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const CustomStyledText(
              text: "تأكيد",
              textColor: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
