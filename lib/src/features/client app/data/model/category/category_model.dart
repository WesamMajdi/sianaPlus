// category_model.dart


import '../../../domain/entities/category/category_entity.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required int id,
    required String name,
    required String? description,
    required String image,
  }) : super(
    id: id,
    name: name,
    description: description,
    image: image,
  );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'],
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
    };
  }
}


