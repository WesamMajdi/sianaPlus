class OrderDetailsEntity {
  int? id;
  String? item;
  String? company;
  String? color;
  String? description;
  Null? specifiedCost;
  String? notifyCustomerOfTheCost;
  Null? costNotifiedToTheCustomer;
  Null? costFrom;
  Null? costTo;
  String? urgent;
  Null? itemBarcode;
  Null? warrantyDaysNumber;
  Null? collectedAmount;
  Null? collectionDate;
  Null? deliveryDate;
  int? maintenanceRequestStatus;
  String? maintenanceRequestStatusMessage;
  Null? technicianId;
  Null? itemBarcodeFilePath;
  Null? convertToBranch;
  Null? branchId;
  Null? branchName;
  Null? convertBranchName;

  OrderDetailsEntity(
      {this.id,
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
      this.collectedAmount,
      this.collectionDate,
      this.deliveryDate,
      this.maintenanceRequestStatus,
      this.maintenanceRequestStatusMessage,
      this.technicianId,
      this.itemBarcodeFilePath,
      this.convertToBranch,
      this.branchId,
      this.branchName,
      this.convertBranchName});
}
