import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';

import '../../../data/model/orders/orders_model_request.dart';
import '../../../domain/entities/category/category_entity.dart';

enum OrderCreationStatus { initial, loading, success, failure }

enum ItemStatus { initial, loading, success, failure }

enum ColorStatus { initial, loading, success, failure }

enum ItemsStatus { initial, loading, success, failure }

enum CompaniesStatus { initial, loading, success, failure }

class OrderState extends Equatable {
  final OrderCreationStatus orderCreationStatus;
  final ItemStatus itemStatus;
  final ColorStatus colorStatus;
  final ItemsStatus itemsStatus;
  final CompaniesStatus companiesStatus;
  final int orderCurrentPage;
  List<OrderEntery> colorsList;
  List<OrderEntery> itemsList;
  List<OrderEntery> companiesList;
  List<ItemsEntity> orderItems;
  final OrderEntery? selectedColor;
  final OrderEntery? selectedItem;
  final OrderEntery? selectedCompany;
  late bool notifyCustomerOfTheCost;

  OrderState({
    this.orderCreationStatus = OrderCreationStatus.initial,
    this.colorStatus = ColorStatus.initial,
    this.itemStatus = ItemStatus.initial,
    this.itemsStatus = ItemsStatus.initial,
    this.companiesStatus = CompaniesStatus.initial,
    this.colorsList = const <OrderEntery>[],
    this.itemsList = const <OrderEntery>[],
    this.companiesList = const <OrderEntery>[],
    this.orderItems = const <ItemsEntity>[],
    this.selectedColor,
    this.orderCurrentPage = 1,
    this.selectedItem,
    this.notifyCustomerOfTheCost = false,
    this.selectedCompany,
  });

  OrderState copyWith(
      {OrderCreationStatus? orderCreationStatus,
      ColorStatus? colorStatus,
      ItemStatus? ordersStatus,
      ItemsStatus? itemsStatus,
      int? orderCurrentPage,
      CompaniesStatus? companiesStatus,
      List<OrderEntery>? colorsList,
      List<OrderEntery>? itemsList,
      List<OrderEntery>? companiesList,
      List<ItemsEntity>? orderItems,
      OrderEntery? selectedColor,
      OrderEntery? selectedItem,
      OrderEntery? selectedCompany,
      bool? notifyCustomerOfTheCost}) {
    return OrderState(
      orderCreationStatus: orderCreationStatus ?? this.orderCreationStatus,
      colorStatus: colorStatus ?? this.colorStatus,
      orderCurrentPage: orderCurrentPage ?? this.orderCurrentPage,
      itemStatus: ordersStatus ?? this.itemStatus,
      itemsStatus: itemsStatus ?? this.itemsStatus,
      companiesStatus: companiesStatus ?? this.companiesStatus,
      colorsList: colorsList ?? this.colorsList,
      notifyCustomerOfTheCost:
          notifyCustomerOfTheCost ?? this.notifyCustomerOfTheCost,
      itemsList: itemsList ?? this.itemsList,
      companiesList: companiesList ?? this.companiesList,
      orderItems: orderItems ?? this.orderItems,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedItem: selectedItem ?? this.selectedItem,
      selectedCompany: selectedCompany ?? this.selectedCompany,
    );
  }

  @override
  List<Object?> get props => [
        orderCreationStatus,
        colorStatus,
        itemStatus,
        itemsStatus,
        companiesStatus,
        colorsList,
        itemsList,
        orderItems,
        companiesList,
        selectedCompany,
        selectedItem,
        selectedColor,
        orderCurrentPage,
        notifyCustomerOfTheCost
      ];
}
