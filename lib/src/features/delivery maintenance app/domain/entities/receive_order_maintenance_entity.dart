import 'package:flutter/material.dart';

class ReceiveMaintenanceOrderEntity {
  final int id;
  final String customerName;
  final String? customerPhoneNumber;
  final double? total;
  final double? discount;
  final double? totalAfterDiscount;
  final String? deliveryDate;
  final String? locationForDelivery;
  final int? orderMaintenanceStatus;
  final int? handReceiptId;

  ReceiveMaintenanceOrderEntity({
    required this.id,
    required this.customerName,
    this.locationForDelivery,
    this.customerPhoneNumber,
    required this.total,
    required this.discount,
    required this.totalAfterDiscount,
    required this.handReceiptId,
    this.deliveryDate,
    required this.orderMaintenanceStatus,
  });
}

String getTextOrderStatusDeliveryMaintenance(int? status) {
  switch (status) {
    case 1:
      return "جديد";
    case 2:
      return "استلام من العميل";
    case 3:
      return "توصيل للفرع";
    case 4:
      return "تم إبلاغ العميل بالتكلفة";
    case 5:
      return "انتهاء الصيانة";
    case 6:
      return "استلام من الفرع";
    case 7:
      return "إرجاع للعميل";
    case 8:
      return "مكتمل";
    case 9:
      return "مرفوض";
    default:
      return "حالة غير معروفة";
  }
}

Color getColorOrderStatusDeliveryMaintenance(int? status) {
  switch (status) {
    case 1:
      return Colors.blue;
    case 2:
      return Colors.orange;
    case 3:
      return Colors.yellow;
    case 4:
      return Colors.purple;
    case 5:
      return Colors.green;
    case 6:
      return Colors.teal;
    case 7:
      return Colors.cyan;
    case 8:
      return Colors.greenAccent;
    case 9:
      return Colors.red;
    default:
      return Colors.grey;
  }
}
