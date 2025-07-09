// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().resetSelectedIndex();
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
                // child: Padding(
                //   padding: const EdgeInsets.all(16),
                //   child: Image.asset(
                //     'assets/images/Untitled-2.png',
                //     fit: BoxFit.fill,
                //   ),

                child: Container(
                  width: 100,
                  height: 100,
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        IMAGE_URL + widget.product.image!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 10, right: 10),
                  child: CustomStyledText(
                    text: widget.product.name!,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.secondaryColor,
                  ),
                ),
                if (widget.product.productColors!.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.only(top: 7, bottom: 15),
                    child: Row(
                      children: [
                        CustomStyledText(
                          text: "ألوان المنتج المتوفرة:",
                          textColor: AppColors.lightGrayColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        AppSizedBox.kWSpace10,
                      ],
                    ),
                  ),
                  Row(
                    children: List.generate(
                      widget.product.productColors!.length,
                      (index) {
                        Color color;
                        try {
                          final hex = widget.product.productColors![index].hex;
                          if (hex != null && hex.isNotEmpty) {
                            color = Color(int.parse(hex.replaceAll('#', 'FF'),
                                radix: 16));
                          } else {
                            color = Colors.grey;
                          }
                        } catch (e) {
                          color = Colors.grey;
                        }

                        return GestureDetector(
                          onTap: () {
                            context.read<CategoryCubit>().selectProductColor(
                                  index: index,
                                  productColor:
                                      widget.product.productColors![index],
                                  productId: widget.product.id!,
                                );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              BlocBuilder<CategoryCubit, CategoryState>(
                                builder: (context, state) {
                                  return Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      boxShadow: shadowList,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: state.selectedIndex == index
                                            ? AppColors.secondaryColor
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(30),
                                  color: color,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  AppSizedBox.kVSpace10
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CustomStyledText(
                      text: widget.product.details!,
                      textColor: Colors.grey,
                      fontSize: 16,
                      fontFamily: "Tajawal",
                    ),
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
