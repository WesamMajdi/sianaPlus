import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class InsertMaintenanceRequestPage extends StatefulWidget {
  const InsertMaintenanceRequestPage({super.key});

  @override
  State<InsertMaintenanceRequestPage> createState() =>
      _InsertMaintenanceRequestPageState();
}

class _InsertMaintenanceRequestPageState
    extends State<InsertMaintenanceRequestPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController devicenameController = TextEditingController();
  TextEditingController causeofthebreakdownController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const AppBarApplicationArrow(
          text: 'اضافة طلب صيانة',
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
                  children: [
                    const CustomLabelText(
                      text: 'اسم الجهاز',
                    ),
                    CustomInputField(
                      controller: devicenameController,
                      hintText: 'ادخل اسم الجهاز',
                      validators: (value) {
                        if (value == null || value.isEmpty) {
                          return 'عفوا.اسم الجهاز مطلوب';
                        }
                        return null;
                      },
                      icon: Icons.text_fields,
                    ),
                    const CustomLabelText(
                      text: 'شركة الجهاز',
                    ),
                    CustomSearchDropdown(
                      hintText: 'اختر شركة الجهاز',
                      validators: (value) {
                        if (value == null || value.isEmpty) {
                          return 'عفوا.يرجي اختيار شركة الجهاز';
                        }
                        return null;
                      },
                      items: const [
                        'LG ',
                        'Samsung ',
                        'Super General',
                        'Dyson ',
                        'Panasonic  ',
                      ],
                    ),
                    const CustomLabelText(
                      text: 'لون جهاز',
                    ),
                    CustomSearchDropdown(
                      validators: (value) {
                        if (value == null || value.isEmpty) {
                          return 'عفوا.يرجي اختيار لون الجهاز';
                        }
                        return null;
                      },
                      hintText: 'اختر لون القطعة',
                      items: const ['سيلفر', 'اسود', 'ابيض', 'رمادي', 'سكني'],
                    ),
                    const CustomLabelText(
                      text: 'سبب العطل',
                    ),
                    Texteara(
                      hintText: 'ادخل سبب العطل',
                      controller: causeofthebreakdownController,
                      validators: (value) {
                        if (value == null || value.isEmpty) {
                          return 'عفوا.ادخل سبب العطل مطلوب';
                        }
                        return null;
                      },
                    ),
                    CustomButton(
                      text: 'ارسال طلب',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                    ),
                  ],
                )),
          ],
        ));
  }
}
