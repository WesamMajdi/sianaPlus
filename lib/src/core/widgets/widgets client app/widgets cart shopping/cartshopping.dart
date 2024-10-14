import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class CartShopping extends StatelessWidget {
  const CartShopping({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const AppBarApplication(text: "سلة التسوق"),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return CartShoppingItem(item: items[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBarCartTotal(),
    );
  }
}
