// ignore_for_file: public_member_api_docs, sort_constructors_first
class SearchProductEntity {
  final int id;
  final String? text;

  SearchProductEntity({required this.id, required this.text});
}

class SearchCategoryEntity {
  final int id;
  final int categoryId;
  final String? categoryName;

  SearchCategoryEntity({
    required this.id,
    required this.categoryId,
    this.categoryName,
  });
}
