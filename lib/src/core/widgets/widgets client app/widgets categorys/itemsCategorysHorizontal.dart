// import '../../features/client app/categorys page/data.dart';
// import '../../features/client app/categorys page/domain.dart';
// import '../export file/exportfiles.dart';

// class CategorysListView extends StatelessWidget {
//   const CategorysListView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 280,
//       child: ListView.builder(
//         itemCount: categories.length,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           final category = categories[index];
//           return CategorysListViewContainer(
//             category: category,
//           );
//         },
//       ),
//     );
//   }
// }

// class CategorysListViewContainer extends StatelessWidget {
//   final MainCategory category;

//   const CategorysListViewContainer({
//     Key? key,
//     required this.category,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double screenheight = MediaQuery.of(context).size.height;

//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const ProductPage(),
//             ));
//       },
//       child: Column(
//         children: [
//           Container(
//             width: 130,
//             height: screenheight * 0.27,
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             padding: const EdgeInsets.all(15),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(18),
//               image: DecorationImage(
//                 image: AssetImage(category.imagePath),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           AppSizedBox.kVSpace20,
//           Center(
//             child: CustomStyledText(
//               text: category.name,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
