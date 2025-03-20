import 'package:flutter/foundation.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/checkout/checkout_screen.dart';
import '../../../../features/client app/domain/entities/product/discount_entity.dart';
import '../../../../features/client app/presentation/controller/cubits/category_cubit.dart';
import '../../../../features/client app/presentation/controller/states/category_state.dart';

class BottomBarCartTotal extends StatelessWidget {
  const BottomBarCartTotal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit,CategoryState>(
      builder: (context, state) => BottomAppBar(
        height: 300,
        child:
        BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
          // print(state.discounts);

          DiscountEntity? discountEntity= state.discounts.where(
            (element) => element.id==1,
          ).first;
          final subTotalAmount = state.subTotalAmount ?? 0.0;
          final discountWithFee = ((subTotalAmount) - ((subTotalAmount)*(discountEntity.discount!)/100) + discountEntity.deliveryfees!) ;

          final totalAmount =discountWithFee + ((discountWithFee) * (discountEntity.tax!/100));

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric( horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomStyledText(
                      text: "المجموع الفرعي:",
                      fontSize: 18,
                    ),
                    CustomStyledText(
                      text: "\$${subTotalAmount.toStringAsFixed(2)}",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomStyledText(
                      text: "نسبة الخصم:",
                      fontSize: 18,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child:  CustomStyledText(
                        text: "${discountEntity.discount ?? 0}%",
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomStyledText(
                      text: "رسوم التوصيل :",
                      fontSize: 18,
                    ),
                    Container(
                      // margin: const EdgeInsets.only(left: 30),
                      child:  CustomStyledText(
                        text: "${discountEntity.deliveryfees ?? 0} ر.س",
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomStyledText(
                      text: "الضريبة:",
                      fontSize: 18,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child:  CustomStyledText(
                        text: "${discountEntity.tax ?? 0}%",
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 219, 219, 219),
                indent: 5,
                endIndent: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomStyledText(
                      text: "المجموع الكلي:",
                      fontSize: 18,
                    ),
                    CustomStyledText(
                      text: "\$${totalAmount.toStringAsFixed(2)}",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              AppSizedBox.kVSpace10,
              SizedBox(
                width: double.infinity,
                child:state.orderStatus == OrderStatus.loading
                    ? const Center(child: CircularProgressIndicator())
                    :  ElevatedButton.icon(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      (Theme.of(context).brightness == Brightness.dark
                          ? AppColors.lightGrayColor
                          : AppColors.primaryColor),
                    ),
                  ),
                  onPressed: () {
                    context.read<CategoryCubit>().createOrder(state.cartItems);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.creditCard,
                    color: Colors.white,
                  ),
                  label: const CustomStyledText(
                    text: "انشاء طلب",
                    textColor: Colors.white,
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
