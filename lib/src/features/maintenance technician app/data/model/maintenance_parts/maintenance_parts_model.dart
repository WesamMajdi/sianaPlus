import 'package:flutter/material.dart';

class MaintenancePart {
  final String maintenancePartName;
  final String clientName;
  final String clientPhone;
  final OrderStatus status;

  MaintenancePart({
    required this.maintenancePartName,
    required this.clientName,
    required this.clientPhone,
    required this.status,
  });
}

enum OrderStatus { New, TakeFromStorage, DeliveryToCustomer, Completed }

Color getColor(OrderStatus status) {
  if (status == OrderStatus.New) {
    return Colors.blue.shade500;
  } else if (status == OrderStatus.TakeFromStorage) {
    return Colors.orange.shade500;
  } else if (status == OrderStatus.DeliveryToCustomer) {
    return Colors.grey.shade500;
  } else if (status == OrderStatus.Completed) {
    return Colors.green.shade500;
  }
  return Colors.black;
}

String getText(OrderStatus status) {
  if (status == OrderStatus.New) {
    return 'جديد';
  } else if (status == OrderStatus.TakeFromStorage) {
    return ' من المخزن';
  } else if (status == OrderStatus.DeliveryToCustomer) {
    return 'تم توصيلها ';
  } else if (status == OrderStatus.Completed) {
    return 'مكتمل';
  }
  return 'غير معروف';
}

final List<MaintenancePart> maintenanceParts = [
  MaintenancePart(
    maintenancePartName: 'مكيف هواء',
    clientName: 'محمد أحمد',
    clientPhone: '0501234567',
    status: OrderStatus.New,
  ),
  MaintenancePart(
    maintenancePartName: 'ثلاجة',
    clientName: 'سارة خالد',
    clientPhone: '0557654321',
    status: OrderStatus.DeliveryToCustomer,
  ),
  MaintenancePart(
    maintenancePartName: 'غسالة',
    clientName: 'عبدالله علي',
    clientPhone: '0569876543',
    status: OrderStatus.Completed,
  ),
  MaintenancePart(
    maintenancePartName: 'غسالة',
    clientName: 'عمر حمد',
    clientPhone: '0599924216',
    status: OrderStatus.TakeFromStorage,
  ),
];
List<OrderStatus> orderStatuses = [
  OrderStatus.New,
  OrderStatus.TakeFromStorage,
  OrderStatus.DeliveryToCustomer,
  OrderStatus.Completed,
];
