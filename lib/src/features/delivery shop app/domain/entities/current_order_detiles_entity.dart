import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/data/model/receive_order_detiels_model.dart';

class OrderCurrentDetailsEntity {
  final int orderStatus;
  final int basketId;
  final List<ReceiveOrderDetielsModel>? orders;

  OrderCurrentDetailsEntity({
    required this.orderStatus,
    required this.basketId,
    required this.orders,
  });
}

enum OrderStatusDeliveryShop {
  New, //1
  TakeFromStorage, //2
  DeliveryToCustomer, // 3
  Completed //4
}

String getTextOrderStatusDeliveryShop(int status) {
  if (status == 1) {
    return "جديد";
  } else if (status == 2) {
    return "اخذ من المخزن";
  } else if (status == 3) {
    return "توصيل لعميل";
  } else if (status == 4) {
    return "مكتمل";
  }
  return "حالة غير معروفة";
}

Color getColorOrderStatusDeliveryShop(int status) {
  if (status == 1) {
    return Colors.blue;
  } else if (status == 2) {
    return Colors.orange;
  } else if (status == 3) {
    return Colors.yellow;
  } else if (status == 4) {
    return Colors.green;
  }
  return Colors.white;
}
