// ignore_for_file: constant_identifier_names

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

enum StatusEnum {
  WaitingManagerResponse,
  ManagerApprovedReturn,
  ManagerRefusedReturn,
  New,
  CheckItem,
  DefineMalfunction,
  InformCustomerOfTheCost,
  CustomerApproved,
  CustomerRefused,
  NoResponseFromTheCustomer,
  ItemCannotBeServiced,
  NotifyCustomerOfTheInabilityToMaintain,
  EnterMaintenanceCost,
  Completed,
  NotifyCustomerOfMaintenanceEnd,
  Delivered,
  Suspended,
  RemovedFromMaintained
}

class HandReceipt {
  int? id;
  Customer? customer;
  String? item;
  String? company;
  String? color;
  String? description;
  int? specifiedCost;
  bool? notifyCustomerOfTheCost;
  Null? costNotifiedToTheCustomer;
  Null? costFrom;
  Null? costTo;
  String? urgent;
  String? itemBarcode;
  int? warrantyDaysNumber;
  Null? returnReason;
  int? maintenanceRequestStatus;
  String? maintenanceRequestStatusMessage;

  HandReceipt(
      {this.id,
      this.customer,
      this.item,
      this.company,
      this.color,
      this.description,
      this.specifiedCost,
      this.notifyCustomerOfTheCost,
      this.costNotifiedToTheCustomer,
      this.costFrom,
      this.costTo,
      this.urgent,
      this.itemBarcode,
      this.warrantyDaysNumber,
      this.returnReason,
      this.maintenanceRequestStatus,
      this.maintenanceRequestStatusMessage});

  HandReceipt.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  Null? address;
  int? customerRate;
  Null? notes;
  String? userCustomerId;
  String? createdAt;

  Customer(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.address,
      this.customerRate,
      this.notes,
      this.userCustomerId,
      this.createdAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    customerRate = json['customerRate'];
    notes = json['notes'];
    userCustomerId = json['userCustomerId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['customerRate'] = this.customerRate;
    data['notes'] = this.notes;
    data['userCustomerId'] = this.userCustomerId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
