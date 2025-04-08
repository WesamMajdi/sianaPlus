import 'package:maintenance_app/src/features/client%20app/domain/entities/product/search_product_entity.dart';

class SearchProductModel extends SearchProductEntity {
  SearchProductModel({required int id, required String text})
      : super(id: id, text: text);

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
      id: json['id'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'text': this.text,
    };
  }
}
