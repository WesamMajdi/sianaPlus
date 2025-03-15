import 'package:cached_network_image/cached_network_image.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/product/details_product_screen.dart';

class ItemsProduct extends StatefulWidget {
  List<Product> products = [];
  ItemsProduct({super.key, required this.products});

  @override
  // ignore: library_private_types_in_public_api
  _ItemsProductState createState() => _ItemsProductState();
}

class _ItemsProductState extends State<ItemsProduct> {
  int visibleItems = 6;

  void _showMoreItems() {
    setState(() {
      visibleItems += 6;
    });
  }

  void _showLessItems() {
    setState(() {
      visibleItems = 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) => Column(
        children: [
          GridView.builder(
            itemCount: visibleItems < widget.products.length
                ? visibleItems
                : widget.products.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
            ),
            itemBuilder: (context, index) {
              final product = widget.products[index];
              print(product.name);
              return Container(
                padding: const EdgeInsets.only(
                    left: AppPadding.mediumPadding,
                    right: AppPadding.mediumPadding,
                    top: 10),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                decoration: BoxDecoration(
                    boxShadow: shadowList,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.black54
                        : Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (product.discount! > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 5),
                            decoration: BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: CustomStyledText(
                                text:
                                    "%${(widget.products[index].discount! * 100).toInt()}",
                                textColor: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          )
                        else
                          const Spacer(),
                        IconButton(
                          onPressed: () async {
                            await context
                                .read<CategoryCubit>()
                                .createFavorite(productId: product.id!);
                          },
                          icon: Icon(
                            widget.products[index].isFavorite ?? false
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          padding: EdgeInsets.zero,
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                                product: widget.products[index]),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              IMAGE_URL + product.image!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                          width: 100,
                          height: 100,
                        //   color: Colors.blue,
                        // ),
                      ),
                    ),
                    AppSizedBox.kVSpace10,
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: CustomStyledText(
                        text: truncateTextTitle(widget.products[index].name!),
                        fontSize: 17,
                        textColor: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: CustomStyledText(
                        text: truncateTextDescription(
                            widget.products[index].details!),
                        fontSize: 12,
                        textColor: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomStyledText(
                            text: "\$${widget.products[index].price}",
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          Icon(FontAwesomeIcons.cartPlus,
                              color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                              size: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (visibleItems < widget.products.length)
                TextButton(
                    onPressed: _showMoreItems,
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomStyledText(
                            text: "عرض المزيد",
                            textColor: Colors.white,
                            fontSize: 16,
                          ),
                          // Icon(
                          //   Icons.arrow_right,
                          //   color: Colors.white,
                          //   size: 20,
                          // )
                        ],
                      ),
                    )),
              if (visibleItems > 6)
                TextButton(
                    onPressed: _showLessItems,
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomStyledText(
                            text: "عرض الاقل",
                            textColor: Colors.white,
                            fontSize: 16,
                          ),
                          // Icon(
                          //   Icons.arrow_right,
                          //   color: Colors.white,
                          //   size: 14,
                          // )
                        ],
                      ),
                    )),
            ],
          ),
        ],
      ),
    );
  }
}
