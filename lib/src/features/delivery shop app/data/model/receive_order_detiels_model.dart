import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_detiels_entity.dart';

class ReceiveOrderDetielsModel extends ReceiveOrderDetielsEntity {
  ReceiveOrderDetielsModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          productName: json['productName'],
          productImage: json['productImage'],
          productCompany: json['productCompany'],
          productColor: json['productColor'],
          count: json['count'],
          price: json['price'].toDouble(),
          discount: json['discount'].toDouble(),
          total: json['total'].toDouble(),
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'productName': productName,
        'productImage': productImage,
        'productCompany': productCompany,
        'productColor': productColor,
        'count': count,
        'price': price,
        'discount': discount,
        'total': total,
      };
}
