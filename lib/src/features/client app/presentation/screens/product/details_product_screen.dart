// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';

import '../../../domain/entities/product/product_entity.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late int _quantity = 1;
  @override
  void initState() {
    super.initState();
    _quantity = widget.product.count ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ItemAppBarToProductDetails(
            product: widget.product,
          ),
          ClipPath(
            clipper: ArcClipper(),
            child: Container(
              color: (Theme.of(context).brightness == Brightness.dark
                  ? Colors.black26
                  : Colors.white),
              height: 350,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    'assets/images/Untitled-2.png',
                    fit: BoxFit.fill,
                  ),

                  // child: Container(
                  //   width: 100,
                  //   height: 100,
                  //   color: Colors.amber,
                  // ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomStyledText(
                        text: widget.product.name!,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.secondaryColor,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () => context
                                .read<CategoryCubit>()
                                .increaseQuantity(widget.product.id.toString()),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                color: AppColors.secondaryColor,
                                CupertinoIcons.plus,
                                size: 20,
                              ),
                            ),
                          ),
                          BlocBuilder<CategoryCubit, CategoryState>(
                            builder: (context, state) => Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: CustomStyledText(
                                text: "${widget.product.count}",
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                textColor: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => context
                                .read<CategoryCubit>()
                                .decreaseQuantity(widget.product.id.toString()),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                color: AppColors.secondaryColor,
                                CupertinoIcons.minus,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                      textAlign: TextAlign.justify,
                      widget.product.details!,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontFamily: "Tajawal",
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7, bottom: 15),
                  child: Row(
                    children: [
                      const CustomStyledText(
                        text: "ألوان المنتج المتوفرة:",
                        textColor: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      AppSizedBox.kWSpace10,
                      Row(
                        children: [
                          // for (int i = 0; i < widget.product.colors.length; i++)
                          //   Container(
                          //     height: 30,
                          //     width: 30,
                          //     alignment: Alignment.center,
                          //     margin: const EdgeInsets.symmetric(horizontal: 5),
                          //     decoration: BoxDecoration(
                          //         boxShadow: shadowList,
                          //         borderRadius: BorderRadius.circular(30),
                          //         color:Colors.blue),
                          //   )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottombarToProductDetailes(
        product: widget.product,
      ),
    );
  }
}
