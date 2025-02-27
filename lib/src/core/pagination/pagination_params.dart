class PaginationParams {
  final int page;
  final int perPage;
  final int mainCategoryId;
  final int productId;
  final int handReceiptId;

  const PaginationParams({
    required this.page,
    this.perPage = 10,
    this.mainCategoryId = 0,
    this.productId = 0,
    this.handReceiptId = 0,
  });

  Map<String, dynamic> toJson() => {
        'page': page,
        'perPage': perPage,
        'mainCategoryId': mainCategoryId,
        'handReceiptId': handReceiptId,
        'productId': productId,
      };
}
