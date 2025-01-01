import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';

class InsertMaintenanceRequestPage extends StatefulWidget {
  InsertMaintenanceRequestPage({super.key, required this.latLong});

  final LatLng? latLong;

  @override
  State<InsertMaintenanceRequestPage> createState() =>
      _InsertMaintenanceRequestPageState();
}

class _InsertMaintenanceRequestPageState
    extends State<InsertMaintenanceRequestPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController devicenameController = TextEditingController();
  TextEditingController causeofthebreakdownController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const AppBarApplicationArrow(
            text: 'اضافة طلب صيانة',
          ),
          body: ListView(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                height: 150,
                width: 120,
                child: Image.asset("assets/images/siana_plus_logo.png"),
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
                          // if (kDebugMode) {
                          //   print(p0!.id);
                          // }
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
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              text: 'ارسال طلب',
                              onPressed: () async {
                                final createItem = Items(
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
                                        causeofthebreakdownController.text);
                                final createItemEntity = ItemsEntity(
                                    item: context
                                        .read<OrderCubit>()
                                        .state
                                        .selectedItem!,
                                    color: context
                                        .read<OrderCubit>()
                                        .state
                                        .selectedColor!,
                                    company: context
                                        .read<OrderCubit>()
                                        .state
                                        .selectedCompany!,
                                    description:
                                        causeofthebreakdownController.text);

                                context.read<OrderCubit>().saveItem(
                                    item: createItem,
                                    itemsEntity: createItemEntity);

                                Navigator.pop(context);
                              },
                            ),
                    ],
                  )),
            ],
          )),
      buildWhen: (previous, current) => previous != current,
    );
  }

  // CreateOrderRequest get createOrderRequest => ;
}
