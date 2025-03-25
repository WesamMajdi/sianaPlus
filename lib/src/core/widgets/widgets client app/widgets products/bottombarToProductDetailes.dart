import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';

import '../../../../features/client app/domain/entities/product/product_entity.dart';

class BottombarToProductDetailes extends StatelessWidget {
  final Product product;
  const BottombarToProductDetailes({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        state.subTotalAmount = product.price * product.userCount;
        return BottomAppBar(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CustomStyledText(
                        text: "${state.subTotalAmount}",
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    AppSizedBox.kWSpace10,
                    Image.asset(
                      "assets/images/logoRiyal.png",
                      width: 25,
                      color: AppColors.primaryColor,
                    )
                  ],
                ),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 15)),
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.secondaryColor)),
                    onPressed: () {
                      if (product.selectedColor != null) {
                        context.read<CategoryCubit>().addProductToCart(product);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartShoppingPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                            content: CustomStyledText(
                              text: "يجب اختيار اللون",
                              textColor: Colors.white,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      FontAwesomeIcons.cartPlus,
                      color: Colors.white,
                    ),
                    label: const CustomStyledText(
                      text: "اضافة الى سلة",
                      textColor: Colors.white,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
