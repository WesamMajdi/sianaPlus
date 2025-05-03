class BasketItem {
  final int? id; // جعله nullable
  final String? productName;
  final String? productImage;
  final String? productCompany;
  final String? productColor;
  final int? count;
  final double? price;
  final double? discount;
  final double? total;

  BasketItem({
    this.id, // إزالة required
    this.productName,
    this.productImage,
    this.productCompany,
    this.productColor,
    this.count,
    this.price,
    this.discount,
    this.total,
  });

  factory BasketItem.fromJson(Map<String, dynamic> json) {
    return BasketItem(
      id: json['id'] as int?, // تحويل صريح مع nullable
      productName: json['productName'],
      productImage: json['productImage'],
      productCompany: json['productCompany'],
      productColor: json['productColor'],
      count: json['count'] as int?,
      price: (json['price'] as num?)?.toDouble(), // تحويل آمن لـ double
      discount: (json['discount'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
    );
  }
}

class BasketModel {
  final int? basketId; // جعله nullable
  final int? orderStatus;
  final List<BasketItem> orders;

  BasketModel({
    this.basketId,
    this.orderStatus,
    required this.orders, // تبقى مطلوبة لكن يمكن أن تكون فارغة
  });

  factory BasketModel.fromJson(Map<String, dynamic> json) {
    try {
      return BasketModel(
        basketId: json['basketId'] as int?,
        orderStatus: json['orderStatus'] as int?,
        orders: (json['orders'] as List<dynamic>?)
                ?.map((e) => BasketItem.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
    } catch (e) {
      print('❌ خطأ في تحليل BasketModel: $e');
      rethrow;
    }
  }
}
