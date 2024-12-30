import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';

class ProductModel extends Product {
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    image = json['image'];
    company = json['company'];
    discount = json['discount'];
    price = json['price'];
    count = json['count'];
    cost = json['cost'];
    countOrder = json['countOrder'];
    isFavorite = json['isFavorite'] ?? false;
    products = json['products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['details'] = this.details;
    data['image'] = this.image;
    data['company'] = this.company;
    data['discount'] = this.discount;
    data['price'] = this.price;
    data['count'] = this.count;
    data['cost'] = this.cost;
    data['countOrder'] = this.countOrder;
    data['isFavorite'] = this.isFavorite;
    data['products'] = this.products;
    return data;
  }
}
