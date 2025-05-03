import 'package:flutter/material.dart';

enum OrderMaintenanceStatus {
  newOrder, // طلب جديد
  takeFromCustomer, // تم استلامه من العميل
  deliveryToBranch, // تم تسليمه للفرع
  costNotifiedToTheCustomer, // تم إشعار العميل بالتكلفة
  maintenanceEnd, // تم الانتهاء من الصيانة
  takeFromBranch, // تم استلامه من الفرع
  returnToCustomer, // تم إرجاعه للعميل
  completed, // مكتمل
  orderRejected, // تم رفض الطلب
}

extension OrderMaintenanceStatusExtension on OrderMaintenanceStatus {
  String get nameAr {
    switch (this) {
      case OrderMaintenanceStatus.newOrder:
        return 'طلب جديد';
      case OrderMaintenanceStatus.takeFromCustomer:
        return 'تم استلامه من العميل';
      case OrderMaintenanceStatus.deliveryToBranch:
        return 'تم تسليمه للفرع';
      case OrderMaintenanceStatus.costNotifiedToTheCustomer:
        return 'اخبار العميل بالتكلفة';
      case OrderMaintenanceStatus.maintenanceEnd:
        return 'انتهت الصيانة';
      case OrderMaintenanceStatus.takeFromBranch:
        return 'تم استلامه من الفرع';
      case OrderMaintenanceStatus.returnToCustomer:
        return 'تم إرجاعه للعميل';
      case OrderMaintenanceStatus.completed:
        return 'مكتمل';
      case OrderMaintenanceStatus.orderRejected:
        return 'تم رفض الطلب';
      default:
        return '';
    }
  }

  Color get statusColor {
    switch (this) {
      case OrderMaintenanceStatus.newOrder:
        return Colors.blue;
      case OrderMaintenanceStatus.takeFromCustomer:
        return Colors.orange;
      case OrderMaintenanceStatus.deliveryToBranch:
        return Colors.green;
      case OrderMaintenanceStatus.costNotifiedToTheCustomer:
        return Colors.pink;
      case OrderMaintenanceStatus.maintenanceEnd:
        return Colors.purple;
      case OrderMaintenanceStatus.takeFromBranch:
        return Colors.red;
      case OrderMaintenanceStatus.returnToCustomer:
        return Colors.yellow;
      case OrderMaintenanceStatus.completed:
        return Colors.grey;
      case OrderMaintenanceStatus.orderRejected:
        return Colors.black;
    }
  }
}

enum OrderProduct {
  New, // طلب جديد
  TakeFromStorage, // تم أخذه من المخزن
  DeliveryToCustomer, // تم تسليمه للعميل
  Completed, // مكتمل
  OrderRejected, // تم رفض الطلب
}

extension OrderProductStatusExtension on OrderProduct {
  String get nameAr {
    switch (this) {
      case OrderProduct.New:
        return 'جديد';
      case OrderProduct.TakeFromStorage:
        return 'تم أخذه من المخزن';
      case OrderProduct.DeliveryToCustomer:
        return 'تم تسليمه للعميل';
      case OrderProduct.Completed:
        return 'مكتمل';
      case OrderProduct.OrderRejected:
        return 'تم رفض الطلب';
    }
  }

  Color get statusColor {
    switch (this) {
      case OrderProduct.New:
        return Colors.blue;
      case OrderProduct.TakeFromStorage:
        return Colors.orange;
      case OrderProduct.DeliveryToCustomer:
        return Colors.green;
      case OrderProduct.Completed:
        return Colors.purple;
      case OrderProduct.OrderRejected:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}

class OrderEntity {
  int? id;
  String? customerName;
  String? customerPhoneNumber;
  int? total;
  int? discount;
  int? totalAfterDiscount;
  int? handReceiptId;
  DateTime? deliveryDate;
  String? createdAt;
  int? orderMaintenanceStatus;
  bool? isPayid;
  String? deliveryName;
  String? locationForDelivery;

  OrderEntity({
    this.id,
    this.customerName,
    this.customerPhoneNumber,
    this.total,
    this.discount,
    this.totalAfterDiscount,
    this.handReceiptId,
    this.deliveryDate,
    this.createdAt,
    this.orderMaintenanceStatus,
    this.isPayid,
    this.deliveryName,
    this.locationForDelivery,
  });
}
