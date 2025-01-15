// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/maintenance_parts/maintenance_parts_entitie.dart';

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

enum StatusEnum {
  WaitingManagerResponse, // 1
  ManagerApprovedReturn, // 2
  ManagerRefusedReturn, // 3
  New, // 4
  CheckItem, // 5
  DefineMalfunction, // 6
  InformCustomerOfTheCost, // 7
  CustomerApproved, // 8
  CustomerRefused, // 9
  NoResponseFromTheCustomer, // 10
  ItemCannotBeServiced, // 11
  NotifyCustomerOfTheInabilityToMaintain, // 12
  EnterMaintenanceCost, // 13
  Completed, // 14
  NotifyCustomerOfMaintenanceEnd, // 15
  Delivered, // 16
  Suspended, // 17
  RemovedFromMaintained, // 18
}

String getText(int status) {
  if (status == StatusEnum.WaitingManagerResponse.index) {
    return "طلب جديد";
  } else if (status == StatusEnum.ManagerApprovedReturn.index + 1) {
    return "يتم فحص";
  } else if (status == StatusEnum.ManagerRefusedReturn.index) {
    return "يتم تحديد العطل";
  } else if (status == StatusEnum.New.index) {
    return "تمت الصيانة بنجاح";
  } else if (status == StatusEnum.CheckItem.index) {
    return "تم تسليم المنتج إلى العميل";
  } else if (status == StatusEnum.Suspended.index + 1) {
    return "تم تعليق الطلب";
  } else if (status == StatusEnum.ManagerApprovedReturn.index) {
    return "تمت الموافقة على إرجاع";
  } else if (status == StatusEnum.ManagerRefusedReturn.index) {
    return "تم رفض إرجاع المنتج من قبل المدير";
  }
  return "حالة غير معروفة";
}

Color getColor(int status) {
  if (status == StatusEnum.New.index + 1) {
    return Colors.blue.shade500;
  } else if (status == StatusEnum.CheckItem.index + 1) {
    return Colors.orange.shade500;
  } else if (status == StatusEnum.DefineMalfunction.index + 1) {
    return Colors.yellow.shade500;
  } else if (status == StatusEnum.Completed.index + 1) {
    return Colors.green.shade500;
  } else if (status == StatusEnum.Delivered.index + 1) {
    return Colors.grey.shade500;
  } else if (status == StatusEnum.Suspended.index + 1) {
    return Colors.red.shade500;
  } else if (status == StatusEnum.ManagerApprovedReturn.index + 1) {
    return Colors.green.shade700;
  } else if (status == StatusEnum.ManagerRefusedReturn.index + 1) {
    return Colors.red.shade700;
  }
  return Colors.black;
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

// Model
class HandReceiptModel extends HandReceiptEntity {
  HandReceiptModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    item = json['item'];
    company = json['company'];
    color = json['color'];
    description = json['description'];
    specifiedCost = json['specifiedCost'];
    notifyCustomerOfTheCost = json['notifyCustomerOfTheCost'];
    costNotifiedToTheCustomer = json['costNotifiedToTheCustomer'];
    costFrom = json['costFrom'];
    costTo = json['costTo'];
    urgent = json['urgent'];
    itemBarcode = json['itemBarcode'];
    warrantyDaysNumber = json['warrantyDaysNumber'];
    returnReason = json['returnReason'];
    maintenanceRequestStatus = json['maintenanceRequestStatus'];
    maintenanceRequestStatusMessage = json['maintenanceRequestStatusMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['item'] = this.item;
    data['company'] = this.company;
    data['color'] = this.color;
    data['description'] = this.description;
    data['specifiedCost'] = this.specifiedCost;
    data['notifyCustomerOfTheCost'] = this.notifyCustomerOfTheCost;
    data['costNotifiedToTheCustomer'] = this.costNotifiedToTheCustomer;
    data['costFrom'] = this.costFrom;
    data['costTo'] = this.costTo;
    data['urgent'] = this.urgent;
    data['itemBarcode'] = this.itemBarcode;
    data['warrantyDaysNumber'] = this.warrantyDaysNumber;
    data['returnReason'] = this.returnReason;
    data['maintenanceRequestStatus'] = this.maintenanceRequestStatus;
    data['maintenanceRequestStatusMessage'] =
        this.maintenanceRequestStatusMessage;
    return data;
  }
}

class Customer {
  final String name;
  final String phoneNumber;

  Customer({
    required this.name,
    required this.phoneNumber,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}
