import '../../../domain/entities/orders/orders_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    collectedAmount = json['collectedAmount'];
    collectionDate = json['collectionDate'];
    deliveryDate = json['deliveryDate'];
    maintenanceRequestStatus = json['maintenanceRequestStatus'];
    maintenanceRequestStatusMessage = json['maintenanceRequestStatusMessage'];
    technicianId = json['technicianId'];
    itemBarcodeFilePath = json['itemBarcodeFilePath'];
    convertToBranch = json['convertToBranch'];
    branchId = json['branchId'];
    branchName = json['branchName'];
    convertBranchName = json['convertBranchName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['collectedAmount'] = this.collectedAmount;
    data['collectionDate'] = this.collectionDate;
    data['deliveryDate'] = this.deliveryDate;
    data['maintenanceRequestStatus'] = this.maintenanceRequestStatus;
    data['maintenanceRequestStatusMessage'] =
        this.maintenanceRequestStatusMessage;
    data['technicianId'] = this.technicianId;
    data['itemBarcodeFilePath'] = this.itemBarcodeFilePath;
    data['convertToBranch'] = this.convertToBranch;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    data['convertBranchName'] = this.convertBranchName;
    return data;
  }

}