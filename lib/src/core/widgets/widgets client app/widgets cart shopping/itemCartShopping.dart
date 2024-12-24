import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';

class CartShoppingItem extends StatelessWidget {
  final Product item;

  const CartShoppingItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: (Theme.of(context).brightness == Brightness.dark
              ? Colors.black26
              : Colors.white),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            margin: const EdgeInsets.only(left: 15),
            // child: Image.asset(item.image!),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.amber,
            ),
          ),
          AppSizedBox.kWSpace15,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomStyledText(
                // text: item.name!,
                text: item.name!,
                textColor: AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              AppSizedBox.kVSpace10,
              CustomStyledText(
                text: "\$${item.price?.toStringAsFixed(2)}",
                // text: "\$${100.toStringAsFixed(2)}",
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => context
                        .read<CategoryCubit>()
                        .removeItem(item.id.toString()),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.withOpacity(0.2)),
                      child: Icon(FontAwesomeIcons.trash,
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.lightGrayColor
                                  : Colors.red),
                          size: 18),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .read<CategoryCubit>()
                              .increaseQuantity(item.id.toString());
                        },
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
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomStyledText(
                          text: "${item.count}",
                          // text: "${5}",
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          textColor: AppColors.secondaryColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<CategoryCubit>()
                              .decreaseQuantity(item.id.toString());
                        },
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
                ]),
          ),
        ],
      ),
    );
  }
}
