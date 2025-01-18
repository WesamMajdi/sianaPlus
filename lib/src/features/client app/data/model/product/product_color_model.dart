import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_color.dart';

class ProductColorModel extends ProductColorEntity{
  ProductColorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countOrder = json['countOrder'];
    count = json['count'];
    hex = json['hex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['countOrder'] = this.countOrder;
    data['count'] = this.count;
    data['hex'] = this.hex;
    return data;
  }
}