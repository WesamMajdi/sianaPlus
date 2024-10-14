class MainCategory {
  final int id;
  final String name;
  final String imagePath;

  MainCategory({
    required this.id,
    required this.name,
    required this.imagePath,
  });
}

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
