import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class IsEmptyCartShopping extends StatelessWidget {
  const IsEmptyCartShopping({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const AppBarApplication(text: "سلة التسوق"),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/cart_empty.json',
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
            const CustomStyledText(text: 'لا توجد بيانات')
          ],
        ),
      ),
    );
  }
}
