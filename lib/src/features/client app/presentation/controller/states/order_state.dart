import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';

import '../../../data/model/orders/orders_model_request.dart';
import '../../../domain/entities/category/category_entity.dart';

enum OrderCreationStatus { initial, loading, success, failure }
enum OrderStatus { initial, loading, success, failure }

enum ItemOrdersStatus { initial, loading, success, failure }

enum ColorStatus { initial, loading, success, failure }

enum ItemsStatus { initial, loading, success, failure }

enum CompaniesStatus { initial, loading, success, failure }

class OrderState extends Equatable {
  final OrderCreationStatus orderCreationStatus;
  final OrderStatus orderStatus;
  final ItemOrdersStatus itemOrdersStatus;
  final ColorStatus colorStatus;
  final ItemsStatus itemsStatus;
  final CompaniesStatus companiesStatus;
  final int orderCurrentPage;
  List<OrderEntery> colorsList;
  List<OrderEntery> itemsList;
  List<OrderEntery> companiesList;
  List<ItemsEntity> items;
  List<OrderEntity> ordersItems;
  final OrderEntery? selectedColor;
  final OrderEntery? selectedItem;
  final OrderEntery? selectedCompany;
  late bool notifyCustomerOfTheCost;

  OrderState({
    this.orderCreationStatus = OrderCreationStatus.initial,
    this.colorStatus = ColorStatus.initial,
    this.orderStatus = OrderStatus.initial,
    this.itemOrdersStatus = ItemOrdersStatus.initial,
    this.itemsStatus = ItemsStatus.initial,
    this.companiesStatus = CompaniesStatus.initial,
    this.colorsList = const <OrderEntery>[],
    this.itemsList = const <OrderEntery>[],
    this.ordersItems = const <OrderEntity>[],
    this.companiesList = const <OrderEntery>[],
    this.items = const <ItemsEntity>[],
    this.selectedColor,
    this.orderCurrentPage = 1,
    this.selectedItem,
    this.notifyCustomerOfTheCost = false,
    this.selectedCompany,
  });

  OrderState copyWith(
      {OrderCreationStatus? orderCreationStatus,
      ColorStatus? colorStatus,
      ItemOrdersStatus? itemOrdersStatus,
      ItemsStatus? itemsStatus,
        OrderStatus? orderStatus,
      int? orderCurrentPage,
      CompaniesStatus? companiesStatus,
      List<OrderEntery>? colorsList,
      List<OrderEntity>?ordersItems,
      List<OrderEntery>? itemsList,
      List<OrderEntery>? companiesList,
      List<ItemsEntity>? items,
      OrderEntery? selectedColor,
      OrderEntery? selectedItem,
      OrderEntery? selectedCompany,
      bool? notifyCustomerOfTheCost}) {
    return OrderState(
      orderCreationStatus: orderCreationStatus ?? this.orderCreationStatus,
      colorStatus: colorStatus ?? this.colorStatus,
      orderCurrentPage: orderCurrentPage ?? this.orderCurrentPage,
      itemOrdersStatus: itemOrdersStatus ?? this.itemOrdersStatus,
      itemsStatus: itemsStatus ?? this.itemsStatus,
      companiesStatus: companiesStatus ?? this.companiesStatus,
      colorsList: colorsList ?? this.colorsList,
      orderStatus: orderStatus ?? this.orderStatus,
      notifyCustomerOfTheCost:
          notifyCustomerOfTheCost ?? this.notifyCustomerOfTheCost,
      itemsList: itemsList ?? this.itemsList,
      ordersItems: ordersItems ?? this.ordersItems,
      companiesList: companiesList ?? this.companiesList,
      items: items ?? this.items,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedItem: selectedItem ?? this.selectedItem,
      selectedCompany: selectedCompany ?? this.selectedCompany,
    );
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
    ordersItems,
        companiesList,
        selectedCompany,
        selectedItem,
        selectedColor,
        orderCurrentPage,
        notifyCustomerOfTheCost
      ];
}
