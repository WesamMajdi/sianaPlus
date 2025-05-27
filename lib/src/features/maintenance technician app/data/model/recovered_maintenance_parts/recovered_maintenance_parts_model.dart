// Model
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/hand_receip_maintenance_parts/hand_receipt_model.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/recovered_maintenance_parts/recovered_maintenance_parts_entity.dart';

class ReturnHandReceiptModel extends ReturnHandReceiptEntity {
  ReturnHandReceiptModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
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
    collectedAmount = json['collectedAmount'];
    collectionDate = json['collectionDate'];
    deliveryDate = json['deliveryDate'];
    technicianId = json['technicianId'];
    itemBarcodeFilePath = json['itemBarcodeFilePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['item'] = item;
    data['company'] = company;
    data['color'] = color;
    data['description'] = description;
    data['specifiedCost'] = specifiedCost;
    data['notifyCustomerOfTheCost'] = notifyCustomerOfTheCost;
    data['costNotifiedToTheCustomer'] = costNotifiedToTheCustomer;
    data['costFrom'] = costFrom;
    data['costTo'] = costTo;
    data['urgent'] = urgent;
    data['itemBarcode'] = itemBarcode;
    data['warrantyDaysNumber'] = warrantyDaysNumber;
    data['returnReason'] = returnReason;
    data['maintenanceRequestStatus'] = maintenanceRequestStatus;
    data['maintenanceRequestStatusMessage'] = maintenanceRequestStatusMessage;
    data['collectedAmount'] = collectedAmount;
    data['collectionDate'] = collectionDate;
    data['deliveryDate'] = deliveryDate;
    data['technicianId'] = technicianId;
    data['itemBarcodeFilePath'] = itemBarcodeFilePath;
    return data;
  }
}

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

String getTextConverter(int status) {
  switch (status) {
    case 1:
      return "بانتظار موافقة المدير";
    case 2:
      return "تمت الموافقة على الإرجاع";
    case 3:
      return "تم رفض الإرجاع";
    case 4:
      return "طلب جديد";
    case 5:
      return "يتم فحص العنصر";
    case 6:
      return "يتم تحديد العطل";
    case 7:
      return "إبلاغ العميل بالتكلفة";
    case 8:
      return "تمت موافقة العميل";
    case 9:
      return "رفض العميل";
    case 10:
      return "لا يوجد رد من العميل";
    case 11:
      return "لا يمكن صيانة العنصر";
    case 12:
      return "تم إبلاغ العميل بعدم القدرة على الصيانة";
    case 13:
      return "أدخل تكلفة الصيانة";
    case 14:
      return "مكتمل";
    case 15:
      return "تم إبلاغ العميل بانتهاء الصيانة";
    case 16:
      return "تم التوصيل";
    case 17:
      return "معلق";
    case 18:
      return "الإزالة من قائمة الصيانة";
    default:
      return "حالة غير معروفة";
  }
}

Color getColorConverter(int status) {
  switch (status) {
    case 1:
      return Colors.blue;
    case 2:
      return Colors.green;
    case 3:
      return Colors.red;
    case 4:
      return Colors.lightBlue;
    case 5:
      return Colors.orange;
    case 6:
      return Colors.deepOrange;
    case 7:
      return Colors.purple;
    case 8:
      return Colors.greenAccent;
    case 9:
      return Colors.redAccent;
    case 10:
      return Colors.grey;
    case 11:
      return Colors.brown;
    case 12:
      return Colors.pinkAccent;
    case 13:
      return Colors.teal;
    case 14:
      return Colors.indigo;
    case 15:
      return Colors.cyan;
    case 16:
      return Colors.amber;
    case 17:
      return Colors.black;
    case 18:
      return Colors.deepPurple;
    default:
      return Colors.white;
  }
}
