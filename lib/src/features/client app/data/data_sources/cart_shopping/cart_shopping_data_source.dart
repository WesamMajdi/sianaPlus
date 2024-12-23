import 'package:maintenance_app/src/features/client%20app/domain/entities/cart_shopping/cart_shopping_entity.dart';

final List<CartItemModel> items = [
  CartItemModel(
    id: 1,
    name: "طقم طناجر",
    imagePath: "assets/images/kitchenware.jpeg",
    price: 55.0,
  ),
  CartItemModel(
    id: 2,
    name: "مكيف",
    imagePath: "assets/images/Air conditioner.jpeg",
    price: 75.0,
  ),
  CartItemModel(
    id: 3,
    name: "ثلاجة",
    imagePath: "assets/images/refrigerator.jpeg",
    price: 300.0,
  ),
];

double get totalAmount {
  double total = 0.0;
  for (var item in items) {
    total += item.price * item.quantity;
  }
  return total;
}
