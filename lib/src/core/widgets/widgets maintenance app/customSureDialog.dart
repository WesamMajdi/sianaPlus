import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class CustomSureDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const CustomSureDialog({Key? key, required this.onConfirm}) : super(key: key);

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
              margin: const EdgeInsets.only(bottom: 15, top: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            alignment: Alignment.topRight,
            child: const CustomStyledText(
              text: 'تحذير',
              fontSize: 20,
              textColor: AppColors.secondaryColor,
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.grey,
            height: 0.5,
          ),
        ],
      ),
      content: SizedBox(
        height: 35,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: const CustomStyledText(
                text: 'هل أنت متأكد من استمرار العملية ؟',
                fontSize: 17,
              ),
            ),
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
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: AppColors.secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const CustomStyledText(text: "تأكيد", textColor: Colors.white),
        ),
      ],
    );
  }
}
