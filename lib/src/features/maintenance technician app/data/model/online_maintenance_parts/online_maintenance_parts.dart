// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/hand_receip_maintenance_parts/hand_receipt_model.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/online_maintenance_parts/online_maintenance_parts_entity.dart';

enum StatusEnumOnline {
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

String getTextStatusOnline(int status) {
  if (status == 1) {
    return "طلب جديد";
  } else if (status == 2) {
    return "يتم فحص";
  } else if (status == 3) {
    return "يتم تحديد العطل";
  } else if (status == 4) {
    return "إبلاغ العميل بالتكاليف";
  } else if (status == 5) {
    return "تمت الموافقة عليه";
  } else if (status == 6) {
    return "رفض العميل";
  } else if (status == 7) {
    return "لا يوجد رد من العميل";
  } else if (status == 8) {
    return "لا يمكن صيانة العنصر";
  } else if (status == 9) {
    return "إخبار العميل بعدم القدرة على الصيانة";
  } else if (status == 10) {
    return "أدخل تكلفة الصيانة";
  } else if (status == 11) {
    return "مكتمل";
  } else if (status == 12) {
    return "إخبار العميل بنهاية الصيانة";
  } else if (status == 13) {
    return "تم التوصيل";
  } else if (status == 14) {
    return "معلق";
  } else if (status == 15) {
    return "تمت إزالته من الصيانة";
  }
  return "حالة غير معروفة";
}

Color getColorStatusOnline(int status) {
  if (status == 1) {
    return Colors.blue;
  } else if (status == 2) {
    return Colors.orange;
  } else if (status == 3) {
    return Colors.yellow;
  } else if (status == 4) {
    return Colors.purple;
  } else if (status == 5) {
    return Colors.green;
  } else if (status == 6) {
    return Colors.red;
  } else if (status == 7) {
    return Colors.grey;
  } else if (status == 8) {
    return Colors.brown;
  } else if (status == 9) {
    return Colors.pink;
  } else if (status == 10) {
    return Colors.teal;
  } else if (status == 11) {
    return Colors.greenAccent;
  } else if (status == 12) {
    return Colors.cyan;
  } else if (status == 13) {
    return Colors.indigo;
  } else if (status == 14) {
    return Colors.amber;
  } else if (status == 15) {
    return Colors.black;
  }
  return Colors.white;
}

// Model
class OnlineModel extends OnlineEntity {
  OnlineModel.fromJson(Map<String, dynamic> json) {
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
