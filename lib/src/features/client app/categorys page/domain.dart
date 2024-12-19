// class MainCategory{
//   final int id;
//   final String name;
//   final String description;
//   final String image;
//
//   const MainCategory({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.image,
//   });
// }
//
// class Meta {
//   final int pages;
//   final int page;
//   final int perPage;
//   final int total;
//
//   const Meta({
//     required this.pages,
//     required this.page,
//     required this.perPage,
//     required this.total,
//   });
// }



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
