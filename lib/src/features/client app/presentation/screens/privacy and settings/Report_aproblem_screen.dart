import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/profile_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/profile_state.dart';

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
      appBar: AppBarApplicationArrow(
        text: 'الإبلاغ عن المشكلة',
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: Form(
          key: _formKey,
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
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state.problemStatus == ProblemStatus.loading) {
                    return CustomButton(
                      text: "",
                      onPressed: () {},
                      child: const SizedBox(
                          width: 30.0,
                          height: 30.0,
                          child: CircularProgressIndicator()),
                    );
                  }

                  return CustomButton(
                    text: "ارسال الإبلاغ",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<ProfileCubit>()
                            .createProblem(problemController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SuccessPage(message: "تمت العملية بنجاح"),
                          ),
                        );
                      }
                    },
                  );
                },
              )
            ],
          )),
    );
  }
}
