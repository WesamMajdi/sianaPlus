import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class SuccessPage extends StatelessWidget {
  final String message;

  const SuccessPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/success.json',
              width: 300,
              height: 300,
              repeat: false,
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color(
                    const ['**'],
                    value: AppColors.secondaryColor,
                  ),
                ],
              ),
            ),
            AppSizedBox.kVSpace20,
            AppSizedBox.kVSpace20,
            Text(
              " $message!!",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: "Tajawal",
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  // primary: AppColors.secondaryColor,
                  ),
              child: const CustomStyledText(
                text: "العودة",
                fontSize: 16,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
