// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/maintenance_parts/maintenance_parts_model.dart';

class HandReceiptEntity {
  int? id;
  Customer? customer;
  String? item;
  String? company;
  String? color;
  String? description;
  int? specifiedCost;
  bool? notifyCustomerOfTheCost;
  int? costNotifiedToTheCustomer;
  int? costFrom;
  int? costTo;
  String? urgent;
  String? itemBarcode;
  int? warrantyDaysNumber = 0;
  String? returnReason;
  int? maintenanceRequestStatus;
  String? maintenanceRequestStatusMessage;

  HandReceiptEntity(
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
}
