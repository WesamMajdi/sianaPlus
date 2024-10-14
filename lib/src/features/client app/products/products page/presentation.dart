import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const AppBarApplication(
        text: 'تسوق اونلاين',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSizedBox.kVSpace10,
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              alignment: Alignment.centerRight,
              child: const CustomStyledText(
                text: "المنتجات",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                textColor: AppColors.secondaryColor,
              ),
            ),
            const ItemsProduct()
          ],
        ),
      ),
    );
  }
}
