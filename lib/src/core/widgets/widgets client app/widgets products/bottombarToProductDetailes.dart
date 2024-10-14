import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class BottombarToProductDetailes extends StatelessWidget {
  final Product product;
  const BottombarToProductDetailes({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        decoration: BoxDecoration(
          color: (Theme.of(context).brightness == Brightness.dark
              ? Colors.transparent
              : Colors.white),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomStyledText(
              text: "\$${product.price}",
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
            ElevatedButton.icon(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 15)),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.secondaryColor)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartShoppingPage(),
                    ),
                  );
                },
                icon: const Icon(FontAwesomeIcons.cartPlus),
                label: const CustomStyledText(
                  text: "اضافة الى سلة",
                  textColor: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
