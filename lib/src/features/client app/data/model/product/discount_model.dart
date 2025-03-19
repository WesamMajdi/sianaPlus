import 'package:maintenance_app/src/features/client%20app/domain/entities/product/discount_entity.dart';

class DiscountModel extends DiscountEntity{
  DiscountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    discount = json['discount'];
    tax = json['tax'];
    deliveryfees = json['deliveryfees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['discount'] = this.discount;
    data['tax'] = this.tax;
    data['deliveryfees'] = this.deliveryfees;
    return data;
  }

  

}