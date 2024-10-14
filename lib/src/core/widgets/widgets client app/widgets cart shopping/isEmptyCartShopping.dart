import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class IsEmptyCartShopping extends StatelessWidget {
  const IsEmptyCartShopping({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: MyDrawer(),
      appBar: AppBarApplication(text: "سلة التسوق"),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CustomStyledText(text: 'لا توجد بيانات')],
        ),
      ),
    );
  }
}
