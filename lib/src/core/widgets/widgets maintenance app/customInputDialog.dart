import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class CustomInputDialog extends StatefulWidget {
  final VoidCallback onConfirm;
  final String titleDialog;
  final String text;
  final String hintText;
  final FormFieldValidator<String>? validators;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const CustomInputDialog({
    Key? key,
    required this.onConfirm,
    required this.titleDialog,
    required this.text,
    required this.hintText,
    this.validators,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  @override
  State<CustomInputDialog> createState() => _CustomInputDialogState();
}

final _formKey = GlobalKey<FormState>();

class _CustomInputDialogState extends State<CustomInputDialog> {
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
            text: widget.titleDialog,
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
        height: 190,
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomStyledText(text: widget.text, fontSize: 17),
              AppSizedBox.kVSpace10,
              Texteara(
                hintText: widget.hintText,
                validators: widget.validators,
                controller: widget.controller,
              ),
              AppSizedBox.kVSpace10,
            ],
          ),
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
          onPressed: () {
            // Validate the form before calling onConfirm
            if (_formKey.currentState?.validate() ?? false) {
              widget.onConfirm();
            }
          },
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
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class CustomInputCostDialog extends StatefulWidget {
  final VoidCallback onConfirm;
  final String titleDialog;
  final String text;
  final String text2;
  final String hintText;
  final FormFieldValidator<String>? validators;
  final TextEditingController? controller;
  final IconData? icon;
  final IconData? icon2;
  final String hintText2;
  final TextEditingController? controller2;
  final FormFieldValidator<String>? validators2;

  const CustomInputCostDialog({
    Key? key,
    required this.onConfirm,
    required this.titleDialog,
    required this.text,
    required this.text2,
    required this.icon,
    required this.hintText,
    this.validators,
    this.controller,
    this.icon2,
    required this.hintText2,
    this.controller2,
    this.validators2,
  }) : super(key: key);

  @override
  State<CustomInputCostDialog> createState() => _CustomInputCostDialogState();
}

class _CustomInputCostDialogState extends State<CustomInputCostDialog> {
  final _formKey = GlobalKey<FormState>();
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
            text: widget.titleDialog,
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
        height: 220,
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomStyledText(text: widget.text, fontSize: 17),
              AppSizedBox.kVSpace10,
              CustomInputField(
                icon: widget.icon!,
                hintText: widget.hintText,
                validators: widget.validators,
                controller: widget.controller,
              ),
              AppSizedBox.kVSpace10,
              CustomStyledText(text: widget.text2, fontSize: 17),
              CustomInputField(
                icon: widget.icon2!,
                hintText: widget.hintText2,
                validators: widget.validators2,
                controller: widget.controller2,
              ),
            ],
          ),
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
          onPressed: () {
            // Validate the form before calling onConfirm
            if (_formKey.currentState?.validate() ?? false) {
              widget.onConfirm();
            }
          },
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
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
