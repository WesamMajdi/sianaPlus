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
      builder: (context, state) => BottomAppBar(
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomStyledText(
                text: "\$${state.totalAmount}",
                fontSize: 24,
                fontWeight: FontWeight.w900,
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
                   if(product.selectedColor!=null){
                     context.read<CategoryCubit>().addProductToCart(product);
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => const CartShoppingPage(),
                       ),
                     );
                   }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
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
      ),
    );
  }
}
