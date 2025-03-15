// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/maintenance_parts/maintenance_parts_model.dart';

class ReturnHandReceiptEntity {
  int? id;
  Customer? customer;
  String? item;
  String? company;
  String? color;
  String? description;
  int? specifiedCost;
  bool? notifyCustomerOfTheCost;
  double? costNotifiedToTheCustomer;
  double? costFrom;
  double? costTo;
  String? urgent;
  String? itemBarcode;
  int? warrantyDaysNumber;
  String? returnReason;
  int? maintenanceRequestStatus;
  String? maintenanceRequestStatusMessage;
  double? collectedAmount;
  String? collectionDate;
  String? deliveryDate;
  int? technicianId;
  String? itemBarcodeFilePath;

  ReturnHandReceiptEntity({
    this.id,
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
    this.maintenanceRequestStatusMessage,
    this.collectedAmount,
    this.collectionDate,
    this.deliveryDate,
    this.technicianId,
    this.itemBarcodeFilePath,
  });
}
