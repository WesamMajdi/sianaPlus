import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/core/services/telr_service_xml.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/state/auth_state.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/verification_screen_2.dart';
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

  String? selectedCountryCode = '+966';
  TextEditingController mobileNumberController = TextEditingController();

  final List<String> gulfCountryCodes = [
    '+966',
    '+971',
    '+965',
    '+973',
    '+968',
    '+974',
  ];
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
                          }

                          String phone = await TokenManager.getPhone() ?? "";

                          if (phone == "") {
                            await showDialog(
                              context: context,
                              builder: (context) => SizedBox(
                                width: 800,
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  title: const Row(
                                    children: [
                                      Icon(Icons.phone,
                                          color: AppColors.secondaryColor,
                                          size: 24.0),
                                      AppSizedBox.kWSpace10,
                                      Center(
                                        child: CustomStyledText(
                                            text: 'إدخال رقم الهاتف',
                                            textColor: AppColors.secondaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const CustomStyledText(
                                        text: 'يرجى إدخال رقم الهاتف للمتابعة',
                                        fontSize: 14,
                                      ),
                                      const SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: AppPadding.mediumPadding,
                                            horizontal:
                                                AppPadding.mediumPadding),
                                        child: DropdownSearch<String>(
                                          items: gulfCountryCodes,
                                          selectedItem: selectedCountryCode,
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              hintText: "أختر رقم",
                                              filled: true,
                                              hintStyle: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Tajawal",
                                              ),
                                              fillColor:
                                                  Colors.grey.withOpacity(0.2),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 18,
                                                horizontal: 18,
                                              ),
                                            ),
                                          ),
                                          popupProps: PopupProps.menu(
                                            showSearchBox: true,
                                            menuProps: MenuProps(
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            searchFieldProps: TextFieldProps(
                                              decoration: InputDecoration(
                                                hintText:
                                                    "ابحث عن رمز الدولة ..",
                                                filled: true,
                                                hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Tajawal",
                                                ),
                                                fillColor: Colors.grey
                                                    .withOpacity(0.2),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 18,
                                                  horizontal: 18,
                                                ),
                                              ),
                                              style: TextStyle(
                                                fontFamily: "Tajawal",
                                                fontSize: 16,
                                              ),
                                            ),
                                            itemBuilder:
                                                (context, item, isSelected) {
                                              return ListTile(
                                                title: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontFamily: "Tajawal",
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                selected: isSelected,
                                              );
                                            },
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedCountryCode = value;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 450,
                                        child: CustomInputField(
                                          hintText: 'ادخل رقم الموبايل',
                                          icon: CupertinoIcons.phone_solid,
                                          controller: mobileNumberController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    Builder(
                                      builder: (dialogContext) {
                                        return BlocListener<AuthCubit,
                                            AuthState>(
                                          listener: (context, state) async {
                                            if (state.phoneVerifyStatus ==
                                                PhoneVerifyStatus.success) {
                                              final cleanedCountryCode =
                                                  selectedCountryCode
                                                          ?.replaceAll(
                                                              "+", "") ??
                                                      "";

                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Verification2Screen(
                                                    selectedCountryCode:
                                                        cleanedCountryCode,
                                                    phone:
                                                        mobileNumberController
                                                            .text,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child:
                                              BlocBuilder<AuthCubit, AuthState>(
                                            builder: (context, state) {
                                              if (state.phoneVerifyStatus ==
                                                  PhoneVerifyStatus.loading) {
                                                return CustomButton(
                                                  text: "",
                                                  onPressed: () {},
                                                  child: const SizedBox(
                                                    width: 30.0,
                                                    height: 30.0,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              }

                                              return CustomButton(
                                                text: "حفظ",
                                                onPressed: () {
                                                  if (mobileNumberController
                                                      .text.isEmpty) {
                                                    ScaffoldMessenger.of(
                                                            dialogContext)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'يرجى إدخال رقم الهاتف'),
                                                      ),
                                                    );
                                                    return;
                                                  }

                                                  if (selectedCountryCode ==
                                                      null) {
                                                    ScaffoldMessenger.of(
                                                            dialogContext)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'يرجى اختيار كود الدولة'),
                                                      ),
                                                    );
                                                    return;
                                                  }

                                                  dialogContext
                                                      .read<AuthCubit>()
                                                      .phoneNumberVerify(
                                                        mobileNumberController
                                                            .text,
                                                        selectedCountryCode!,
                                                      );
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          final totalAmount = discountWithFee +
                              (discountWithFee * (discountEntity.tax! / 100));

                          if (totalAmount == 0) return;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutPage(
                                onConfirm: () async {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => const Center(
                                        child: CircularProgressIndicator()),
                                  );

                                  final telrResponse =
                                      await TelrServiceXML.createPayment(
                                          totalAmount);

                                  if (context.mounted) {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  }

                                  if (telrResponse != null && context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => TelrPaymentScreen(
                                          paymentUrl: telrResponse.paymentUrl,
                                          closeUrl: telrResponse.closeUrl,
                                          abortUrl: telrResponse.abortUrl,
                                          transactionCode:
                                              telrResponse.transactionCode,
                                          totalAmount: totalAmount,
                                        ),
                                      ),
                                    );
                                  } else if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('فشل إنشاء رابط الدفع')),
                                    );
                                  }
                                },
                              ),
                            ),
                          );
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
