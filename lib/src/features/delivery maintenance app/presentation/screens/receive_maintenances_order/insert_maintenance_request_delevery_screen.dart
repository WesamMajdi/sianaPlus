import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/current_order_maintenance/current_order_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/current_order_maintenance/detiels_current_order_screen.dart';

import '../../../data/model/create_Order_request.dart';

class InsertMaintenanceRequestDeleveryPage extends StatefulWidget {
  InsertMaintenanceRequestDeleveryPage(
      {super.key,
      required this.handReceiptId,
      required this.orderMaintenancId});
  final int handReceiptId;
  final int orderMaintenancId;

  @override
  State<InsertMaintenanceRequestDeleveryPage> createState() =>
      _InsertMaintenanceRequestDeleveryPageState();
}

class _InsertMaintenanceRequestDeleveryPageState
    extends State<InsertMaintenanceRequestDeleveryPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().fetchColorList();
    context.read<OrderCubit>().fetchCompaniesList();
    context.read<OrderCubit>().fetchItemsList();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController causeofthebreakdownController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBarApplicationArrow(
            text: 'اضافة طلب صيانة',
            onBackTap: () {
              Navigator.pop(context);
            },
          ),
          body: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? AppColors.lightGrayColor
                        : AppColors.primaryColor),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                height: 140,
                width: 120,
                child: Container(
                    margin: const EdgeInsets.only(top: 25, bottom: 25),
                    child: Image.asset("assets/images/logoWhit.png")),
              ),
              AppSizedBox.kVSpace20,
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const CustomLabelText(
                        text: 'اسم الجهاز',
                      ),
                      CustomSearchDropdown(
                        hintText: 'اختر اسم الجهاز',
                        validators: (value) {
                          if (value == null) {
                            return 'عفوا.يرجي اختيار اسم الجهاز';
                          }
                          return null;
                        },
                        items: state.itemsList,
                        onChanged: (p0) {
                          context.read<OrderCubit>().selectItem(p0!);
                        },
                      ),
                      const CustomLabelText(
                        text: 'شركة الجهاز',
                      ),
                      CustomSearchDropdown(
                        hintText: 'اختر شركة الجهاز',
                        validators: (value) {
                          if (value == null) {
                            return 'عفوا.يرجي اختيار شركة الجهاز';
                          }
                          return null;
                        },
                        items: state.companiesList,
                        onChanged: (p0) {
                          context.read<OrderCubit>().selectCompany(p0!);
                        },
                      ),
                      const CustomLabelText(
                        text: 'لون جهاز',
                      ),
                      CustomSearchDropdown(
                        validators: (value) {
                          if (value == null) {
                            return 'عفوا.يرجي اختيار لون الجهاز';
                          }
                          return null;
                        },
                        hintText: 'اختر لون القطعة',
                        items: state.colorsList,
                        onChanged: (p0) {
                          context.read<OrderCubit>().selectColor(p0!);
                        },
                      ),
                      const CustomLabelText(
                        text: 'سبب العطل',
                      ),
                      Texteara(
                        hintText: 'ادخل سبب العطل',
                        controller: causeofthebreakdownController,
                        validators: (value) {
                          if (value == null || value.isEmpty) {
                            return 'عفوا.ادخل سبب العطل مطلوب';
                          }
                          return null;
                        },
                      ),
                      AppSizedBox.kVSpace20,
                      state.orderCreationStatus == OrderCreationStatus.loading
                          ? CustomButton(
                              text: "",
                              onPressed: () {},
                              child: const SizedBox(
                                width: 30.0,
                                height: 30.0,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : CustomButton(
                              text: 'ارسال طلب',
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // التحقق من حالة الطلب قبل الإرسال
                                  final createItem = CreateOrderDeliveryRequest(
                                    itemId: context
                                        .read<OrderCubit>()
                                        .state
                                        .selectedItem!
                                        .id!,
                                    colorId: context
                                        .read<OrderCubit>()
                                        .state
                                        .selectedColor!
                                        .id!,
                                    companyId: context
                                        .read<OrderCubit>()
                                        .state
                                        .selectedCompany!
                                        .id!,
                                    description:
                                        causeofthebreakdownController.text,
                                  );

                                  if (state.orderCreationStatus !=
                                      OrderCreationStatus.loading) {
                                    // إذا كانت حالة الطلب ليست في وضع التحميل (Loading)، يمكن إرسال الطلب
                                    context
                                        .read<OrderCubit>()
                                        .addHandReceiptItemsByDm(
                                          widget.handReceiptId,
                                          createItem,
                                        );

                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CurrentTakeOrderMaintenanceScreen(),
                                      ),
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor:
                                              AppColors.secondaryColor,
                                          content: CustomStyledText(
                                              text:
                                                  'تم إرسال طلب بنجاح على طلب رقم ${widget.orderMaintenancId}')),
                                    );
                                  }
                                }
                              })
                    ],
                  )),
            ],
          )),
    );
  }

  // CreateOrderRequest get createOrderRequest => ;
}
