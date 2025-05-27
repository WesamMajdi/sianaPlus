import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/showTopSnackBar.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/profile_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/profile_state.dart';
import '../../../../../core/export file/exportfiles.dart';

class ChangeUserProfile extends StatefulWidget {
  const ChangeUserProfile({super.key});

  @override
  State<ChangeUserProfile> createState() => _ChangeUserProfileState();
}

class _ChangeUserProfileState extends State<ChangeUserProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileCubit>().state;
    nameController = TextEditingController(text: state.name ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    bottomRight: Radius.circular(15),
                  ),
                ),
                height: 140,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Image.asset("assets/images/logoWhit.png"),
                ),
              ),
              AppSizedBox.kVSpace20,
              const CustomLabelText(text: 'الاسم الشخصي'),
              CustomInputField(
                controller: nameController,
                hintText: 'ادخل اسمك',
                icon: Icons.person,
                validators: (value) {
                  if (value == null || value.isEmpty) {
                    return 'عفوا. هذا الحقل مطلوب';
                  }
                  return null;
                },
              ),
              BlocListener<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state.changeNameStatus == ChangeNameStatus.failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.red,
                          content: CustomStyledText(
                              text: state.errorMessage ?? "حدث خطأ ما")),
                    );
                  }
                  if (state.changeNameStatus == ChangeNameStatus.success) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const UserProfilePage(),
                      ),
                    );
                  }
                },
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state.changeNameStatus == ChangeNameStatus.loading) {
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
                      text: 'تعديل',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<ProfileCubit>()
                              .changeName(nameController.text.trim());
                        }
                      },
                    );
                  },
                ),
              ),
              AppSizedBox.kVSpace20,
            ],
          ),
        ));
  }
}
