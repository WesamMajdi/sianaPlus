class PaginationParams {
  final int page;
  final int perPage;
  final int mainCategoryId;
  final int handReceiptId;

  const PaginationParams({
    required this.page,
    this.perPage = 10,
    this.mainCategoryId = 0,
    this.handReceiptId = 0,
  });

  Map<String, dynamic> toJson() => {
    'page': page,
    'perPage': perPage,
    'mainCategoryId': mainCategoryId,
    'handReceiptId': handReceiptId,
  };
}