import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class CartShoppingPage extends StatefulWidget {
  const CartShoppingPage({super.key});

  @override
  State<CartShoppingPage> createState() => _CartShoppingPageState();
}

class _CartShoppingPageState extends State<CartShoppingPage> {
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const IsEmptyCartShopping();
    } else {
      return const CartShopping();
    }
  }
}
