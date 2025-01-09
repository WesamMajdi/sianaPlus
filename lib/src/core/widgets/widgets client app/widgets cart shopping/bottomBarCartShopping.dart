import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/checkout/checkout_screen.dart';
import '../../../../features/client app/presentation/controller/cubits/category_cubit.dart';
import '../../../../features/client app/presentation/controller/states/category_state.dart';

class BottomBarCartTotal extends StatelessWidget {
  const BottomBarCartTotal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 220,
      child:
          BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        final totalAmount = state.totalAmount ?? 0.0;

        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomStyledText(
                    text: "المجموع الفرعي:",
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
                    child: const CustomStyledText(
                      text: "0%",
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
              child: ElevatedButton.icon(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreditCardFormScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  FontAwesomeIcons.creditCard,
                  color: Colors.white,
                ),
                label: const CustomStyledText(
                  text: "دفع المبلغ",
                  textColor: Colors.white,
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
