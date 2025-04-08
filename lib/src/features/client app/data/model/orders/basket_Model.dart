class BasketItem {
  final int id;
  final String? productName;
  final String? productImage;
  final String? productCompany;
  final String? productColor;
  final int? count;
  final double? price;
  final double? discount;
  final double? total;

  BasketItem({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.productCompany,
    required this.productColor,
    required this.count,
    required this.price,
    required this.discount,
    required this.total,
  });

  factory BasketItem.fromJson(Map<String, dynamic> json) {
    return BasketItem(
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
  }

  Map<String, dynamic> toJson() {
    return {
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
}

class BasketModel {
  final int basketId;
  final int orderStatus;
  final List<BasketItem>? items;

  BasketModel({
    required this.basketId,
    required this.orderStatus,
    required this.items,
  });

  factory BasketModel.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['items'] as List;
    List<BasketItem> itemsList =
        itemsFromJson.map((item) => BasketItem.fromJson(item)).toList();

    return BasketModel(
      basketId: json['basketId'],
      orderStatus: json['orderStatus'],
      items: itemsList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemsToJson =
        items!.map((item) => item.toJson()).toList();

    return {
      'basketId': basketId,
      'orderStatus': orderStatus,
      'items': itemsToJson,
    };
  }
}
