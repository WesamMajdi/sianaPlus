import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';

final List<Order> allOrders = [
  Order(
    id: 2568,
    imageUrl: 'assets/images/afan.jpeg',
    serviceName: 'إصلاح مروحة',
    price: 150.0,
    status: 'نشطة',
  ),
  Order(
    id: 6935,
    imageUrl: 'assets/images/washing machine.jpeg',
    serviceName: 'إصلاح غسالة',
    price: 200.0,
    status: 'تحت المراجعة',
  ),
  Order(
    id: 1111,
    imageUrl: 'assets/images/Air conditioner.jpeg',
    serviceName: 'إصلاح المكيف',
    price: 250.0,
    deliveryTime: '2023-08-01',
  ),
  Order(
    id: 2565,
    imageUrl: 'assets/images/refrigerator.jpeg',
    serviceName: 'إصلاح الثلاجة',
    price: 300.0,
    deliveryTime: '2023-07-20',
  ),
];
final List<Order> previousOrders = [
  Order(
    id: 1111,
    imageUrl: 'assets/images/Air conditioner.jpeg',
    serviceName: 'إصلاح المكيف',
    price: 250.0,
    deliveryTime: '2023-08-01',
  ),
  Order(
    id: 2565,
    imageUrl: 'assets/images/refrigerator.jpeg',
    serviceName: 'إصلاح الثلاجة',
    price: 300.0,
    deliveryTime: '2023-07-20',
  ),
];

final List<Order> currentOrders = [
  // Order(
  //   id: 2568,
  //   imageUrl: 'assets/images/afan.jpeg',
  //   serviceName: 'إصلاح مروحة',
  //   price: 150.0,
  //   status: 'نشطة',
  // ),
  // Order(
  //   id: 6935,
  //   imageUrl: 'assets/images/washing machine.jpeg',
  //   serviceName: 'إصلاح غسالة',
  //   price: 200.0,
  //   status: 'تحت المراجعة',
  // ),
];
