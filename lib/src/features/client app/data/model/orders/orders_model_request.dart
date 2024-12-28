import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';

class CreateOrderRequest {
  int? total;
  int? discount;
  String? locationForDelivery;
  bool? notifyCustomerOfTheCost;
  HandReceipt? handReceipt;

  CreateOrderRequest(
      {this.total,
        this.discount,
        this.locationForDelivery,
        this.notifyCustomerOfTheCost,
        this.handReceipt});

  CreateOrderRequest.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    discount = json['discount'];
    locationForDelivery = json['locationForDelivery'];
    notifyCustomerOfTheCost = json['notifyCustomerOfTheCost'];
    handReceipt = json['handReceipt'] != null
        ? new HandReceipt.fromJson(json['handReceipt'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['locationForDelivery'] = this.locationForDelivery;
    data['notifyCustomerOfTheCost'] = this.notifyCustomerOfTheCost;
    if (this.handReceipt != null) {
      data['handReceipt'] = this.handReceipt!.toJson();
    }
    return data;
  }
}

class HandReceipt {
  List<Items>? items;

  HandReceipt({this.items});

  HandReceipt.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? itemId;
  int? companyId;
  int? colorId;
  String? description;

  Items({this.itemId, this.companyId, this.colorId, this.description});

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    companyId = json['companyId'];
    colorId = json['colorId'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['companyId'] = this.companyId;
    data['colorId'] = this.colorId;
    data['description'] = this.description;
    return data;
  }
}

class ItemsEntity {
  OrderEntery? item;
  OrderEntery? company;
  OrderEntery? color;
  String? description;

  ItemsEntity({this.item, this.company, this.color,this.description});


}
