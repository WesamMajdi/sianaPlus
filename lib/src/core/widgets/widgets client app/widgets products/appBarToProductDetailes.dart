// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';

import '../../../../features/client app/domain/entities/product/product_entity.dart';

class ItemAppBarToProductDetails extends StatelessWidget {
  final Product product;
  const ItemAppBarToProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) => Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.2)),
                child: const Icon(
                  FontAwesomeIcons.arrowRight,
                  size: 20,
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(right: 20),
                child: CustomStyledText(
                  text: "تفاصيل المنتج",
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  textColor: AppColors.secondaryColor,
                )),
            const Spacer(),

            IconButton(
                onPressed: () async {
                  await context
                      .read<CategoryCubit>()
                      .createFavorite(productId: product.id!);
                },
                icon: Icon(
                  product.isFavorite! ? Icons.favorite : Icons.favorite_border,
                  size: 30,
                  color: Colors.red,
                ))
            // if (product.isFavorite ?? false)
            //   const
            // else
            //   const Icon(
            //     Icons.favorite_border,
            //     size: 30,
            //     color: Colors.red,
            //   )
          ],
        ),
      ),
    );
  }
}
