class SubCategory {
  final int id;
  final int parentId;
  final String name;
  final String imagePath;
  final String description;

  SubCategory(
      {required this.id,
      required this.parentId,
      required this.name,
      required this.imagePath,
      required this.description});
}
