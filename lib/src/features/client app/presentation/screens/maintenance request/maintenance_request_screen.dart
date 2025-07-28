import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maintenance_app/main.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/core/services/telr_service_xml.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/successPage.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20maintenance%20request/itemsMaintenanceRequest.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/showTopSnackBar.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/state/auth_state.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/verification_screen_2.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/webviwe/telr_delevery_order_maintenace_payment_screen.dart';
import '../map/map_picker_screen.dart';

class MaintenanceRequestPage extends StatefulWidget {
  const MaintenanceRequestPage({super.key, this.currentIndex = 3});
  final int? currentIndex;
  @override
  State<MaintenanceRequestPage> createState() => _MaintenanceRequestPageState();
}

class _MaintenanceRequestPageState extends State<MaintenanceRequestPage> {
  LatLng? _pickedLocation;
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

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   context.read<OrderCubit>().clearItems();
  // }

  // Opens the map picker screen
  Future<void> _openMapPicker() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapPickerScreen()),
    );

    if (result != null && result is LatLng) {
      setState(() {
        _pickedLocation = result;
      });
    }
  }

  final TextEditingController locationController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // context.read<OrderCubit>().clearItems();
  }

  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getNewOrderMaintenance();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) => Scaffold(
        drawer: MyDrawer(currentIndex: widget.currentIndex),
        appBar: const AppBarApplication(text: 'طلب صيانة'),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: AppPadding.mediumPadding,
                              left: AppPadding.mediumPadding,
                              top: 10),
                          child: ElevatedButton.icon(
                            onPressed: _openMapPicker,
                            icon: const Icon(
                              Icons.location_pin,
                              color: Colors.grey,
                              size: 25,
                            ),
                            label: Container(
                              alignment: Alignment.centerRight,
                              child: CustomStyledText(
                                text: _pickedLocation != null
                                    ? '${_pickedLocation!.longitude}, ${_pickedLocation!.latitude}'
                                    : 'ادخل موقعك ع الخريطة',
                                fontSize: 14,
                                textColor: Colors.grey,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.mediumPadding,
                                    vertical: 15),
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                elevation: 0),
                          ),
                        ),
                        AppSizedBox.kVSpace10,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                          child: ModernCheckbox(
                            title: 'إبلاغي بتكلفة الصيانة',
                            value: state.notifyCustomerOfTheCost,
                            onChanged: (value) {
                              context
                                  .read<OrderCubit>()
                                  .toggleNotifyCustomerOfTheCost(value!);
                            },
                          ),
                        ),
                        CustomButton(
                          text: 'اضافة جهاز',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    InsertMaintenanceRequestPage(
                                  latLong: _pickedLocation,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  AppSizedBox.kVSpace20,
                  BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      if (state.itemOrdersStatus == ItemOrdersStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.itemOrdersStatus == ItemOrdersStatus.failure) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.itemOrdersStatus == ItemOrdersStatus.success &&
                          state.items.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            return ItemsMaintenanceRequest(
                              state: state,
                              i: index,
                              itemEntity: state.items[index],
                            );
                          },
                        );
                      }
                      return Center(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: const Center(
                                child: CustomStyledText(
                                    text: 'لا توجد طلبات صيانة'))),
                      );
                    },
                  ),
                  state.items.isNotEmpty
                      ? BlocListener<OrderCubit, OrderState>(
                          listener: (context, state) {
                            if (state.orderCreationStatus ==
                                OrderCreationStatus.success) {
                              Navigator.pop(context);
                            }
                          },
                          listenWhen: (previous, current) =>
                              previous != current,
                          child: Column(children: [
                            AppSizedBox.kVSpace20,
                            if (state.orderCreationStatus ==
                                OrderCreationStatus.loading)
                              Center(
                                  child: CustomButton(
                                text: "",
                                onPressed: () {},
                                child: const SizedBox(
                                  width: 30.0,
                                  height: 30.0,
                                  child: CircularProgressIndicator(),
                                ),
                              ))
                            else
                              CustomButton(
                                text: 'اضافة طلب',
                                onPressed: () async {
                                  if (_pickedLocation == null) {
                                    showTopSnackBar(context, 'يجب تحديد الموقع',
                                        Colors.redAccent);
                                    return;
                                  } else {
                                    String? token =
                                        await TokenManager.getToken();
                                    if (token == null) {
                                      await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          title: const Row(
                                            children: [
                                              Icon(
                                                  FontAwesomeIcons
                                                      .circleExclamation,
                                                  color: Color.fromARGB(
                                                      255, 255, 173, 51),
                                                  size: 24.0),
                                              AppSizedBox.kWSpace10,
                                              Center(
                                                child: CustomStyledText(
                                                  text: 'يتطلب تسجيل الدخول',
                                                  textColor:
                                                      AppColors.secondaryColor,
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
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen()),
                                                  (Route<dynamic> route) =>
                                                      false,
                                                );
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.secondaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
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
                                                  Navigator.of(context)
                                                      .pop(false),
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    Colors.grey[200],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              child: const CustomStyledText(
                                                text: "إلغاء",
                                                fontSize: 12,
                                                textColor:
                                                    AppColors.darkGrayColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }

                                    String phone =
                                        await TokenManager.getPhone() ?? "";

                                    if (phone == "") {
                                      await showDialog(
                                        context: context,
                                        builder: (context) => SizedBox(
                                          width: 800,
                                          child: AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            title: const Row(
                                              children: [
                                                Icon(Icons.phone,
                                                    color: AppColors
                                                        .secondaryColor,
                                                    size: 24.0),
                                                AppSizedBox.kWSpace10,
                                                Center(
                                                  child: CustomStyledText(
                                                      text: 'إدخال رقم الهاتف',
                                                      textColor: AppColors
                                                          .secondaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const CustomStyledText(
                                                  text:
                                                      'يرجى إدخال رقم الهاتف للمتابعة',
                                                  fontSize: 14,
                                                ),
                                                const SizedBox(height: 20),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: AppPadding
                                                          .mediumPadding,
                                                      horizontal: AppPadding
                                                          .mediumPadding),
                                                  child: DropdownSearch<String>(
                                                    items: gulfCountryCodes,
                                                    selectedItem:
                                                        selectedCountryCode,
                                                    dropdownDecoratorProps:
                                                        DropDownDecoratorProps(
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        hintText: "أختر رقم",
                                                        filled: true,
                                                        hintStyle:
                                                            const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: "Tajawal",
                                                        ),
                                                        fillColor: Colors.grey
                                                            .withOpacity(0.2),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 18,
                                                          horizontal: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    popupProps: PopupProps.menu(
                                                      showSearchBox: true,
                                                      menuProps: MenuProps(
                                                        elevation: 2,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      searchFieldProps:
                                                          TextFieldProps(
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "ابحث عن رمز الدولة ..",
                                                          filled: true,
                                                          hintStyle: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                "Tajawal",
                                                          ),
                                                          fillColor: Colors.grey
                                                              .withOpacity(0.2),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 18,
                                                            horizontal: 18,
                                                          ),
                                                        ),
                                                        style: TextStyle(
                                                          fontFamily: "Tajawal",
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      itemBuilder: (context,
                                                          item, isSelected) {
                                                        return ListTile(
                                                          title: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  "Tajawal",
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          selected: isSelected,
                                                        );
                                                      },
                                                    ),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedCountryCode =
                                                            value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 450,
                                                  child: CustomInputField(
                                                    hintText:
                                                        'ادخل رقم الموبايل',
                                                    icon: CupertinoIcons
                                                        .phone_solid,
                                                    controller:
                                                        mobileNumberController,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              Builder(
                                                builder: (dialogContext) {
                                                  return BlocListener<AuthCubit,
                                                      AuthState>(
                                                    listener:
                                                        (context, state) async {
                                                      if (state
                                                              .phoneVerifyStatus ==
                                                          PhoneVerifyStatus
                                                              .success) {
                                                        print(
                                                            'Navigation triggered!');
                                                        final cleanedCountryCode =
                                                            selectedCountryCode
                                                                ?.replaceAll(
                                                                    "+", "");

                                                        Navigator.of(
                                                                dialogContext)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pushReplacement(
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
                                                    child: BlocBuilder<
                                                        AuthCubit, AuthState>(
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                                .phoneVerifyStatus ==
                                                            PhoneVerifyStatus
                                                                .loading) {
                                                          return CustomButton(
                                                            text: "",
                                                            onPressed: () {},
                                                            child:
                                                                const SizedBox(
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
                                                                        'يرجى إدخال رقم الهاتف')),
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
                                                                        'يرجى اختيار كود الدولة')),
                                                              );
                                                              return;
                                                            }

                                                            dialogContext
                                                                .read<
                                                                    AuthCubit>()
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
                                    if (phone.isNotEmpty) {
                                      final createOrder = CreateOrderRequest(
                                        total: 0,
                                        discount: 0,
                                        locationForDelivery:
                                            '${_pickedLocation!.latitude},${_pickedLocation!.longitude}',
                                        notifyCustomerOfTheCost:
                                            state.notifyCustomerOfTheCost,
                                        handReceipt: HandReceipt(
                                          items: state.items
                                              .map((e) => Items(
                                                  itemId: e.item!.id,
                                                  colorId: e.color!.id,
                                                  companyId: e.company!.id,
                                                  description: e.description!))
                                              .toList(),
                                        ),
                                      );

                                      double fees = NavigationService
                                          .navigatorKey.currentContext!
                                          .read<OrderCubit>()
                                          .state
                                          .fees;

                                      if (fees > 0) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      width: 50,
                                                      height: 5,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 15),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                  const CustomStyledText(
                                                    text: 'رسوم توصيل',
                                                    fontSize: 20,
                                                    textColor: AppColors
                                                        .secondaryColor,
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    width: double.infinity,
                                                    color: Colors.grey,
                                                    height: 0.5,
                                                  ),
                                                ],
                                              ),
                                              content: const SizedBox(
                                                height: 50,
                                                width: 400,
                                                child: CustomStyledText(
                                                    text:
                                                        'يجب دفع رسوم التوصيل الآن لإكمال الطلب. هل ترغب في المتابعة؟'),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FutureBuilder<
                                                                TelrPaymentResponse?>(
                                                          future: TelrServiceXML
                                                              .createPayment(
                                                                  fees),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Center(
                                                                  child:
                                                                      CircularProgressIndicator());
                                                            } else if (snapshot
                                                                .hasError) {
                                                              return Center(
                                                                  child: Text(
                                                                      'Error: ${snapshot.error}'));
                                                            } else if (snapshot
                                                                    .hasData &&
                                                                snapshot.data !=
                                                                    null) {
                                                              return TelrDeliveryMaintenancePaymentScreen(
                                                                paymentUrl: snapshot
                                                                    .data!
                                                                    .paymentUrl,
                                                                closeUrl: snapshot
                                                                    .data!
                                                                    .closeUrl,
                                                                abortUrl: snapshot
                                                                    .data!
                                                                    .abortUrl,
                                                                transactionCode:
                                                                    snapshot
                                                                        .data!
                                                                        .transactionCode,
                                                                createOrder:
                                                                    createOrder,
                                                              );
                                                            } else {
                                                              return const Center(
                                                                  child: Text(
                                                                      'Payment creation failed'));
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: AppColors
                                                        .secondaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                  child: const CustomStyledText(
                                                    text: "تأكيد",
                                                    textColor: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      width: 50,
                                                      height: 5,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 15),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                  const CustomStyledText(
                                                    text: 'هدية لك!',
                                                    fontSize: 20,
                                                    textColor: AppColors
                                                        .secondaryColor,
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    width: double.infinity,
                                                    color: Colors.grey,
                                                    height: 0.5,
                                                  ),
                                                ],
                                              ),
                                              content: const SizedBox(
                                                height: 50,
                                                width: 400,
                                                child: CustomStyledText(
                                                    text:
                                                        'هدية لك! التوصيل مجاني كهدية 🎁، سيتم إرسال الطلب الآن.'),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    context
                                                        .read<OrderCubit>()
                                                        .createOrderMaintenance(
                                                            createOrder);
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            const SuccessPage(
                                                          message:
                                                              "تمت اضافة طلبك الصيانة بنجاح!!",
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: AppColors
                                                        .secondaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                  child: const CustomStyledText(
                                                    text: "تأكيد",
                                                    textColor: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }
                                  }
                                },
                              ),
                          ]),
                        )
                      : const Text(''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModernCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String title;

  const ModernCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: value
                  ? (isDark ? Colors.tealAccent : Colors.teal)
                  : Colors.transparent,
              border: Border.all(
                color: value
                    ? (isDark ? Colors.tealAccent : Colors.teal)
                    : Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: value
                ? Icon(
                    Icons.check,
                    size: 18,
                    color: isDark ? Colors.black : Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          CustomStyledText(
            text: title,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
