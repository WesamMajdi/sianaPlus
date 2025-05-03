import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/basket_Model.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/order_product_model.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/region/region_model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/ordered_product/ordered_product_screen.dart';

import '../../../data/model/orders/orders_model_request.dart';
import '../../../domain/entities/category/category_entity.dart';

enum OrderCreationStatus { initial, loading, success, failure }

enum OrderStatus { initial, loading, success, failure }

enum OrderProductStatus { initial, loading, success, failure }

enum OrderForApprovalStatus { initial, loading, success, failure }

enum ItemOrdersStatus { initial, loading, success, failure }

enum ColorStatus { initial, loading, success, failure }

enum ItemsStatus { initial, loading, success, failure }

enum CompaniesStatus { initial, loading, success, failure }

enum OrderPayWithAppStatus { initial, loading, success, failure }

class OrderState extends Equatable {
  final OrderCreationStatus orderCreationStatus;
  final OrderStatus orderStatus;
  final OrderStatus orderOldStatus;
  final OrderPayWithAppStatus payWithApp;
  final OrderProductStatus orderProductStatus;
  final OrderForApprovalStatus orderApprovalStatus;
  final ItemOrdersStatus itemOrdersStatus;
  final ColorStatus colorStatus;
  final ItemsStatus itemsStatus;
  final CompaniesStatus companiesStatus;
  final int orderCurrentPage;
  List<OrderEntery> colorsList;
  List<OrderEntery> itemsList;
  List<OrderEntery> companiesList;
  List<ItemsEntity> items;
  List<BasketModel> basket;
  List<OrderEntity> ordersItemsNew;
  List<OrderEntity> ordersItemsOld;
  final OrderEntery? selectedColor;
  final OrderEntery? selectedItem;
  final OrderEntery? selectedCompany;
  late bool notifyCustomerOfTheCost;
  final List<BaseViewModel> listofRegion;
  final int newOrderMaintenanceId;
  final double fees;
  final List<OrderProductModel>? ordersProductItemsNew;
  final List<OrderProductModel>? ordersProductItemsOld;
  List<OrderEntity> ordersItemsApprovel;

  OrderState(
      {this.orderCreationStatus = OrderCreationStatus.initial,
      this.colorStatus = ColorStatus.initial,
      this.orderOldStatus = OrderStatus.initial,
      this.orderProductStatus = OrderProductStatus.initial,
      this.orderStatus = OrderStatus.initial,
      this.itemOrdersStatus = ItemOrdersStatus.initial,
      this.orderApprovalStatus = OrderForApprovalStatus.initial,
      this.itemsStatus = ItemsStatus.initial,
      this.companiesStatus = CompaniesStatus.initial,
      this.payWithApp = OrderPayWithAppStatus.initial,
      this.colorsList = const <OrderEntery>[],
      this.itemsList = const <OrderEntery>[],
      this.ordersProductItemsNew = const <OrderProductModel>[],
      this.ordersProductItemsOld = const <OrderProductModel>[],
      this.ordersItemsNew = const <OrderEntity>[],
      this.ordersItemsOld = const <OrderEntity>[],
      this.companiesList = const <OrderEntery>[],
      this.items = const <ItemsEntity>[],
      this.selectedColor,
      this.orderCurrentPage = 1,
      this.selectedItem,
      this.notifyCustomerOfTheCost = false,
      this.selectedCompany,
      this.newOrderMaintenanceId = 0,
      this.fees = 0,
      this.basket = const <BasketModel>[],
      this.ordersItemsApprovel = const <OrderEntity>[],
      this.listofRegion = const <BaseViewModel>[]});

  OrderState copyWith(
      {OrderCreationStatus? orderCreationStatus,
      OrderForApprovalStatus? orderApprovalStatus,
      ColorStatus? colorStatus,
      OrderStatus? orderOldStatus,
      OrderProductStatus? orderProductStatus,
      ItemOrdersStatus? itemOrdersStatus,
      OrderPayWithAppStatus? payWithApp,
      ItemsStatus? itemsStatus,
      OrderStatus? orderStatus,
      int? orderCurrentPage,
      CompaniesStatus? companiesStatus,
      List<OrderEntery>? colorsList,
      List<OrderEntity>? ordersItemsNew,
      List<OrderProductModel>? ordersProductItemsNew,
      List<OrderProductModel>? ordersProductItemsOld,
      List<OrderEntity>? ordersItemsApprovel,
      List<OrderEntity>? ordersItemsOld,
      List<OrderEntery>? itemsList,
      List<OrderEntery>? companiesList,
      List<ItemsEntity>? items,
      OrderEntery? selectedColor,
      OrderEntery? selectedItem,
      OrderEntery? selectedCompany,
      bool? notifyCustomerOfTheCost,
      List<BaseViewModel>? listofRegion,
      int? newOrderMaintenanceId,
      List<BasketModel>? basket,
      double? fees}) {
    return OrderState(
        orderCreationStatus: orderCreationStatus ?? this.orderCreationStatus,
        colorStatus: colorStatus ?? this.colorStatus,
        orderCurrentPage: orderCurrentPage ?? this.orderCurrentPage,
        orderOldStatus: orderOldStatus ?? this.orderOldStatus,
        itemOrdersStatus: itemOrdersStatus ?? this.itemOrdersStatus,
        itemsStatus: itemsStatus ?? this.itemsStatus,
        companiesStatus: companiesStatus ?? this.companiesStatus,
        colorsList: colorsList ?? this.colorsList,
        orderStatus: orderStatus ?? this.orderStatus,
        notifyCustomerOfTheCost:
            notifyCustomerOfTheCost ?? this.notifyCustomerOfTheCost,
        itemsList: itemsList ?? this.itemsList,
        ordersItemsNew: ordersItemsNew ?? this.ordersItemsNew,
        ordersItemsOld: ordersItemsOld ?? this.ordersItemsOld,
        companiesList: companiesList ?? this.companiesList,
        items: items ?? this.items,
        selectedColor: selectedColor ?? this.selectedColor,
        selectedItem: selectedItem ?? this.selectedItem,
        selectedCompany: selectedCompany ?? this.selectedCompany,
        listofRegion: listofRegion ?? this.listofRegion,
        newOrderMaintenanceId:
            newOrderMaintenanceId ?? this.newOrderMaintenanceId,
        fees: fees ?? this.fees,
        orderApprovalStatus: orderApprovalStatus ?? this.orderApprovalStatus,
        ordersItemsApprovel: ordersItemsApprovel ?? this.ordersItemsApprovel,
        ordersProductItemsOld:
            ordersProductItemsOld ?? this.ordersProductItemsOld,
        ordersProductItemsNew:
            ordersProductItemsNew ?? this.ordersProductItemsNew,
        orderProductStatus: orderProductStatus ?? this.orderProductStatus,
        basket: basket ?? this.basket,
        payWithApp: payWithApp ?? this.payWithApp);
  }

  @override
  List<Object?> get props => [
        orderCreationStatus,
        colorStatus,
        itemOrdersStatus,
        itemsStatus,
        companiesStatus,
        colorsList,
        itemsList,
        items,
        orderStatus,
        ordersItemsOld,
        ordersItemsNew,
        companiesList,
        selectedCompany,
        selectedItem,
        selectedColor,
        orderCurrentPage,
        notifyCustomerOfTheCost,
        listofRegion,
        newOrderMaintenanceId,
        fees,
        orderApprovalStatus,
        ordersItemsApprovel,
        ordersProductItemsOld,
        ordersProductItemsNew,
        orderProductStatus,
        basket,
        payWithApp,
        orderOldStatus
      ];
}
