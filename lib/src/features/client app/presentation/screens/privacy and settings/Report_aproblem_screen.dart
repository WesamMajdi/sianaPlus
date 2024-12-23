import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class ReportProblemPage extends StatefulWidget {
  const ReportProblemPage({super.key});

  @override
  State<ReportProblemPage> createState() => _ReportProblemPageState();
}

final _formKey = GlobalKey<FormState>();

class _ReportProblemPageState extends State<ReportProblemPage> {
  TextEditingController problemController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarApplicationArrow(
        text: 'الإبلاغ عن المشكلة',
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
                text: 'المشكلة',
              ),
              Texteara(
                hintText: 'ادخل المشكلة التي تود الإبلاغ عنها',
                controller: problemController,
                validators: (value) {
                  if (value == null || value.isEmpty) {
                    return 'عفوا.ادخل المشكلة مطلوب';
                  }
                  return null;
                },
              ),
              AppSizedBox.kVSpace10,
              CustomButton(
                text: 'ارسال الإبلاغ',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
              ),
            ],
          )),
    );
  }
}
