import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/shopping%20cart/shopping%20cart%20page/data.dart';

import '../../../../features/client app/presentation/controller/cubits/category_cubit.dart';
import '../../../../features/client app/presentation/controller/states/category_state.dart';

class BottomBarCartTotal extends StatelessWidget {
  const BottomBarCartTotal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: BlocBuilder<CategoryCubit,CategoryState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                  color: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.transparent
                      : Colors.white),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CustomStyledText(
                          text: "المجموع:",
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          textColor: AppColors.secondaryColor,
                        ),
                        AppSizedBox.kWSpace10,
                        CustomStyledText(
                          text: "\$${state.totalAmount!.toStringAsFixed(2)}",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.secondaryColor,
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            backgroundColor:
                            MaterialStateProperty.all(AppColors.secondaryColor)),
                        onPressed: () {
                          print("تم دفع المبلغ ");
                        },
                        icon: const Icon(FontAwesomeIcons.check),
                        label: const CustomStyledText(
                          text: "دفع المبلغ",
                          fontSize: 18,
                          textColor: Colors.black,
                        ))
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
