import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/data/data_sources/cart_shopping/cart_shopping_data_source.dart';

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
