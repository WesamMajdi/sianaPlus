// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/login_screen.dart';
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
                                color: Color.fromARGB(255, 255, 173, 51),
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
                          text: 'يرجى تسجيل الدخول حتى تستطيع الاضافة لمفضلة .',
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
                                borderRadius: BorderRadius.circular(8.0),
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
                            onPressed: () => Navigator.of(context).pop(false),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
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

                    return;
                  }
                  await context
                      .read<CategoryCubit>()
                      .createFavorite(productId: product.id!);
                },
                icon: Icon(
                  product.isFavorite! ? Icons.favorite : Icons.favorite_border,
                  size: 30,
                  color: Colors.red,
                ))
         
          ],
        ),
      ),
    );
  }
}
