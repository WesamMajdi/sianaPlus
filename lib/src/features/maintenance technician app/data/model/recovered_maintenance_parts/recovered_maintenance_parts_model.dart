// Model
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/maintenance_parts/maintenance_parts_model.dart';
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
