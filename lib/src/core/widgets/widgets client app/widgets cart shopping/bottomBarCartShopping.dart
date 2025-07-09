import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/core/services/telr_service.dart';
import 'package:maintenance_app/src/core/services/telr_service_xml.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/region/region_model.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/shipping/shipping_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/webviwe/telr_payment_screen.dart';
import '../../../../features/client app/domain/entities/product/discount_entity.dart';
import '../../../../features/client app/presentation/controller/cubits/category_cubit.dart';
import '../../../../features/client app/presentation/controller/states/category_state.dart';

class BottomBarCartTotal extends StatefulWidget {
  const BottomBarCartTotal({
    super.key,
  });

  @override
  State<BottomBarCartTotal> createState() => _BottomBarCartTotalState();
}

class _BottomBarCartTotalState extends State<BottomBarCartTotal> {
  @override
  void initState() {
    super.initState();
    // context.read<CategoryCubit>().clearCart();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 300,
      child:
          BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        DiscountEntity discountEntity;
        if (state.discounts.isNotEmpty) {
          discountEntity =
              state.discounts.where((element) => element.id == 1).first;
        } else {
          discountEntity =
              DiscountEntity(id: 0, discount: 0, deliveryfees: 0, tax: 0);
        }
        final subTotalAmount = state.subTotalAmount ?? 0.0;

        final discountWithFee = ((subTotalAmount) -
            ((subTotalAmount) * (discountEntity.discount!) / 100) +
            discountEntity.deliveryfees!);

        final totalAmount = discountWithFee +
                ((discountWithFee) * (discountEntity.tax! / 100)) ??
            0.0;

        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomStyledText(
                    text: "المجموع الفرعي:",
                    fontSize: 18,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CustomStyledText(
                          text: "${subTotalAmount.toStringAsFixed(2)}",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSizedBox.kWSpace10,
                      Image.asset("assets/images/logoRiyal.png",
                          width: 20,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                    ],
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
                    child: CustomStyledText(
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CustomStyledText(
                          text: "${discountEntity.deliveryfees ?? 0}",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSizedBox.kWSpace10,
                      Image.asset("assets/images/logoRiyal.png",
                          width: 20,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                    ],
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
                    child: CustomStyledText(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        CustomStyledText(
                          text: "${totalAmount.toStringAsFixed(2) ?? 0.0}",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        AppSizedBox.kWSpace10,
                        Image.asset("assets/images/logoRiyal.png",
                            width: 20,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: double.infinity,
                child: state.orderStatus == OrderStatus.loading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 15),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            (Theme.of(context).brightness == Brightness.dark
                                ? AppColors.lightGrayColor
                                : AppColors.primaryColor),
                          ),
                        ),
                        onPressed: () async {
                          String? token = await TokenManager.getToken();

                          if (token == null) {
                            final bool? confirmLogin = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                title: const Row(
                                  children: [
                                    Icon(FontAwesomeIcons.circleExclamation,
                                        color:
                                            Color.fromARGB(255, 255, 173, 51),
                                        size: 24.0),
                                    AppSizedBox.kWSpace10,
                                    Center(
                                      child: CustomStyledText(
                                        text: 'يتطلب تسجيل الدخول',
                                        textColor: AppColors.secondaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                content: const CustomStyledText(
                                  text:
                                      'يرجى تسجيل الدخول للمتابعة في عملية الدفع.',
                                  fontSize: 14,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: AppColors.secondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: const CustomStyledText(
                                      text: "تسجيل الدخول",
                                      textColor: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey[200],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: const CustomStyledText(
                                      text: "إلغاء",
                                      fontSize: 12,
                                      textColor: AppColors.darkGrayColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (confirmLogin == true) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                                (Route<dynamic> route) => false,
                              );
                            }

                            return; // إيقاف باقي التنفيذ
                          }

                          final totalAmount = discountWithFee +
                              ((discountWithFee) * (discountEntity.tax! / 100));
                          if (totalAmount != 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CheckoutPage(onConfirm: () async {
                                  String? paymentUrl =
                                      await TelrServiceXML.createPayment(
                                          totalAmount);
                                  if (paymentUrl != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TelrPaymentScreen(
                                          paymentUrl: paymentUrl,
                                          totalAmount: totalAmount,
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: CustomStyledText(
                                          text: "فشل في إنشاء رابط الدفع",
                                          textColor: Colors.white,
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }),
                              ),
                            );
                          }
                        },
                        icon: const Icon(
                          FontAwesomeIcons.creditCard,
                          color: Colors.white,
                        ),
                        label: const CustomStyledText(
                          text: "انشاء طلب",
                          textColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                      )),
          ],
        );
      }),
    );
  }
}
