// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20categorys/itemsMainCategorys.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20categorys/itemsSubCategorys.dart';

import '../../../../../core/export file/exportfiles.dart';
import '../../../categorys page/data.dart';
import '../../../categorys page/domain.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int selectedMainCategoryId = 1;

  @override
  Widget build(BuildContext context) {
    List<SubCategory> filteredSubCategories = subcategories
        .where((sub) => sub.parentId == selectedMainCategoryId)
        .toList();

    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const AppBarApplication(
        text: 'تسوق اونلاين',
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            alignment: Alignment.centerRight,
            child: const CustomStyledText(
              text: "الاصناف الرئيسية",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textColor: AppColors.secondaryColor,
            ),
          ),
          Container(
            height: 50,
            color: (Theme.of(context).brightness == Brightness.dark
                ? Colors.transparent
                : Colors.white),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                // return GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       selectedMainCategoryId = category.id;
                //     });
                //   },
                //   child: ItemsMainCategorys(
                //       selectedMainCategoryId: selectedMainCategoryId,
                //       category: category),
                // );
              },
            ),
          ),
          AppSizedBox.kVSpace20,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerRight,
            child: const CustomStyledText(
              text: "الاصناف الفرعية",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textColor: AppColors.secondaryColor,
            ),
          ),
          ItemsSubCategorys(),
        ],
      ),
    );
  }
}
