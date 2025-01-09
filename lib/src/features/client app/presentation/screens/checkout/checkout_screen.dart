import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class CreditCardFormScreen extends StatefulWidget {
  @override
  _CreditCardFormScreenState createState() => _CreditCardFormScreenState();
}

class _CreditCardFormScreenState extends State<CreditCardFormScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarApplicationArrow(text: "وسيلة دفع"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber:
                  cardNumber.isEmpty ? '0000 0000 0000 0000' : cardNumber,
              expiryDate: expiryDate.isEmpty ? 'MM/YY' : expiryDate,
              cardHolderName:
                  cardHolderName.isEmpty ? 'Card Holder' : cardHolderName,
              cvvCode: cvvCode.isEmpty ? '***' : cvvCode,
              showBackView: false,
              cardBgColor: (Theme.of(context).brightness == Brightness.dark
                  ? AppColors.lightGrayColor
                  : AppColors.primaryColor),
              isHolderNameVisible: true,
              onCreditCardWidgetChange: (CreditCardBrand brand) {},
            ),
            SingleChildScrollView(
              child: CreditCardForm(
                formKey: formKey,
                obscureCvv: true,
                obscureNumber: false,
                cardNumber: cardNumber,
                cvvCode: cvvCode,
                isHolderNameVisible: true,
                isCardNumberVisible: true,
                isExpiryDateVisible: true,
                cursorColor: Colors.black45,
                cardHolderName: cardHolderName,
                expiryDate: expiryDate,
                textColor: Colors.black,
                cardHolderDecoration: InputDecoration(
                  hintText: 'اسم حامل البطاقة',
                  filled: true,
                  errorStyle:
                      const TextStyle(fontFamily: "Tajawal", fontSize: 14),
                  hintStyle: const TextStyle(
                      fontSize: 16, color: Colors.grey, fontFamily: "Tajawal"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.secondaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.secondaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: AppPadding.mediumPadding,
                    horizontal: AppPadding.mediumPadding,
                  ),
                ),
                cardNumberDecoration: InputDecoration(
                  filled: true,
                  errorStyle:
                      const TextStyle(fontFamily: "Tajawal", fontSize: 14),
                  hintStyle: const TextStyle(
                      fontSize: 16, color: Colors.grey, fontFamily: "Tajawal"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.secondaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.secondaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: AppPadding.mediumPadding,
                    horizontal: AppPadding.mediumPadding,
                  ),
                  hintText: 'XXXX XXXX XXXX XXXX',
                ),
                expiryDateDecoration: InputDecoration(
                  hintText: 'MM/YY',
                  filled: true,
                  errorStyle:
                      const TextStyle(fontFamily: "Tajawal", fontSize: 14),
                  hintStyle: const TextStyle(
                      fontSize: 16, color: Colors.grey, fontFamily: "Tajawal"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.secondaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.secondaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: AppPadding.mediumPadding,
                    horizontal: AppPadding.mediumPadding,
                  ),
                ),
                cvvCodeDecoration: InputDecoration(
                  filled: true,
                  errorStyle:
                      const TextStyle(fontFamily: "Tajawal", fontSize: 14),
                  hintStyle: const TextStyle(
                      fontSize: 16, color: Colors.grey, fontFamily: "Tajawal"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.secondaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.secondaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: AppPadding.mediumPadding,
                    horizontal: AppPadding.mediumPadding,
                  ),
                  hintText: 'CVV',
                ),
                onCreditCardModelChange: onCreditCardModelChange,
                themeColor: Colors.transparent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: SizedBox(
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
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.creditCard,
                    color: Colors.white,
                  ),
                  label: const CustomStyledText(
                    text: "دفع المبلغ",
                    textColor: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
