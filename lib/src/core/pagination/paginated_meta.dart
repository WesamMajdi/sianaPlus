class PaginatedMeta {
  final int pages;
  final int page;
  final int perpage;
  final int total;

  const PaginatedMeta({
    required this.pages,
    required this.page,
    required this.perpage,
    required this.total,
  });

  factory PaginatedMeta.fromJson(Map<String, dynamic> json) {
    return PaginatedMeta(
      pages: json['pages'] as int,
      page: json['page'] as int,
      perpage: json['perpage'] as int,
      total: json['total'] as int,
    );
  }

  @override
  String toString() {
    return 'PaginatedMeta(pages: $pages, page: $page, perpage: $perpage, total: $total)';
  }
}
