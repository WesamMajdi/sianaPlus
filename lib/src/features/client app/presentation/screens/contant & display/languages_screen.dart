import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class LanguageSelectionSheet extends StatefulWidget {
  const LanguageSelectionSheet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LanguageSelectionSheetState createState() => _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
  String selectedLanguage = 'ar';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomStyledText(
                text: selectedLanguage == 'ar' ? 'لغة' : 'Languages',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.grey.withOpacity(0.2)),
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                value: 'ar',
                fillColor: MaterialStateProperty.all(AppColors.secondaryColor),
                focusColor: AppColors.secondaryColor,
                groupValue: selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                },
              ),
              const CustomStyledText(
                text: 'لغة العربية',
                fontSize: 20,
              ),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                fillColor: MaterialStateProperty.all(AppColors.secondaryColor),
                focusColor: AppColors.secondaryColor,
                value: 'en',
                groupValue: selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                },
              ),
              const CustomStyledText(
                text: 'English',
                fontSize: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
