import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/client%20app/domain/usecases/orders/fetch_orders_useCase.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../states/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderUseCase orderUseCase;
  List<ItemsEntity>? orderItems = [];

  OrderCubit(this.orderUseCase) : super(OrderState());

  void saveItem({required Items item, ItemsEntity? itemsEntity}) {
    emit(state.copyWith(
      itemOrdersStatus: ItemOrdersStatus.loading,
    ));

    final newItems = List<ItemsEntity>.from(state.items);

    // state.items
    newItems.add(itemsEntity!); // Save the order locally in the orders map

    // Emit the updated state to notify the UI
    emit(state.copyWith(
      itemOrdersStatus: ItemOrdersStatus.success,
      items: newItems,
    ));
    // orderItems=[];
  }

  void deleteItem({required ItemsEntity itemsEntity}) async {
    try {
      // Start loading state
      emit(state.copyWith(
        itemOrdersStatus: ItemOrdersStatus.loading,
      ));

      // Create a new list without the deleted item
      final newItems = List<ItemsEntity>.from(state.items)
        ..removeWhere((item) => item.item == itemsEntity.item);

      // Emit the updated state
      emit(state.copyWith(
        items: newItems,
        itemOrdersStatus: ItemOrdersStatus.success,
      ));

      // Optional: Call API to delete from server
      // await orderRepository.deleteItem(itemsEntity.id!);
    } catch (e) {
      // Handle errors
      emit(state.copyWith(
        itemOrdersStatus: ItemOrdersStatus.failure,
      ));

      // Revert to previous state on error
      emit(state.copyWith(
        itemOrdersStatus: ItemOrdersStatus.success,
      ));
    }
  }

  Future<void> initOrdersRequirements() async {
    await Future.wait([
      fetchColorList(),
      fetchItemsList(),
      fetchCompaniesList(),
      getOrderMaintenanceByUserNew(),
      getOrderMaintenanceByUserOld()
    ]);
  }

  void toggleNotifyCustomerOfTheCost(bool value) {
    emit(state.copyWith(notifyCustomerOfTheCost: value));
  }

  Future<void> fetchColorList() async {
    emit(state.copyWith(colorStatus: ColorStatus.loading));
    final result = await orderUseCase.getColorLsit();
    result.fold(
      (failure) => emit(state.copyWith(colorStatus: ColorStatus.failure)),
      (colors) => emit(state.copyWith(
          colorStatus: ColorStatus.success, colorsList: colors.data!)),
    );
  }

  Future<void> fetchItemsList() async {
    emit(state.copyWith(itemsStatus: ItemsStatus.loading));
    final result = await orderUseCase.getItemsList();
    result.fold(
      (failure) => emit(state.copyWith(itemsStatus: ItemsStatus.failure)),
      (items) => emit(state.copyWith(
          itemsStatus: ItemsStatus.success, itemsList: items.data!)),
    );
  }

  Future<void> fetchCompaniesList() async {
    emit(state.copyWith(companiesStatus: CompaniesStatus.loading));
    final result = await orderUseCase.getCompaniesList();
    result.fold(
      (failure) =>
          emit(state.copyWith(companiesStatus: CompaniesStatus.failure)),
      (companies) => emit(state.copyWith(
          companiesStatus: CompaniesStatus.success,
          companiesList: companies.data!)),
    );
  }

  selectColor(OrderEntery color) {
    emit(state.copyWith(
      selectedColor: color,
      orderCreationStatus: OrderCreationStatus.initial,
    ));
  }

  selectItem(OrderEntery item) {
    emit(state.copyWith(
      selectedItem: item,
      orderCreationStatus: OrderCreationStatus.initial,
    ));
  }

  selectCompany(OrderEntery company) {
    emit(state.copyWith(
      selectedCompany: company,
      orderCreationStatus: OrderCreationStatus.initial,
    ));
  }

  void resetOrderStatus() {
    emit(state.copyWith(itemOrdersStatus: ItemOrdersStatus.initial));
  }

  Future<void> createOrderMaintenance(
      CreateOrderRequest createOrderRequest) async {
    emit(state.copyWith(orderCreationStatus: OrderCreationStatus.loading));

    final result =
        await orderUseCase.createOrderMaintenance(createOrderRequest);
    result.fold(
      (failure) => emit(
          state.copyWith(orderCreationStatus: OrderCreationStatus.failure)),
      (_) {
        emit(state.copyWith(
            orderCreationStatus: OrderCreationStatus.success,
            items: [],
            notifyCustomerOfTheCost: false));
      },
    );
  }

  Future<void> getOrderMaintenanceByUserNew({bool refresh = false}) async {
    emit(state.copyWith(orderStatus: OrderStatus.loading));
    final page = refresh ? 1 : 1;
    final result = await orderUseCase
        .getOrderMaintenanceByUserNew(PaginationParams(page: page));
    result.fold(
      (failure) => emit(state.copyWith(orderStatus: OrderStatus.failure)),
      (orders) => emit(state.copyWith(
          orderStatus: OrderStatus.success, ordersItemsNew: orders.items)),
    );
  }

  Future<void> getOrderMaintenanceByUserOld({bool refresh = false}) async {
    emit(state.copyWith(orderOldStatus: OrderStatus.loading));
    final page = refresh ? 1 : 1;
    final result = await orderUseCase
        .getOrderMaintenanceByUserOld(PaginationParams(page: page));
    result.fold(
      (failure) => emit(state.copyWith(orderOldStatus: OrderStatus.failure)),
      (orders) => emit(state.copyWith(
          orderOldStatus: OrderStatus.success, ordersItemsOld: orders.items)),
    );
  }

  Future<void> getNewOrderMaintenance() async {
    emit(state.copyWith(orderStatus: OrderStatus.loading));

    try {
      final result = await orderUseCase.getNewOrderMaintenance();

      result.fold(
        (failure) => emit(state.copyWith(orderStatus: OrderStatus.failure)),
        (order) => emit(state.copyWith(
          orderStatus: OrderStatus.success,
          newOrderMaintenanceId: order.newId,
          fees: order.fees,
        )),
      );
    } catch (e) {
      emit(state.copyWith(orderStatus: OrderStatus.failure));
      print('Error: $e');
    }
  }

  Future<void> getOrderMaintenanceRequestsForApproval(
      {bool refresh = false}) async {
    emit(state.copyWith(orderApprovalStatus: OrderForApprovalStatus.loading));
    final page = refresh ? 1 : 1;
    final result = await orderUseCase
        .getOrderMaintenanceRequestsForApproval(PaginationParams(page: page));
    result.fold(
      (failure) => emit(
          state.copyWith(orderApprovalStatus: OrderForApprovalStatus.failure)),
      (orders) => emit(state.copyWith(
          orderApprovalStatus: OrderForApprovalStatus.success,
          ordersItemsApprovel: orders.items)),
    );
  }

  Future<void> responseFromTheCustomer(
      {required int receiptItemId,
      bool? customerApproved,
      String? reasonForRefusingMaintenance}) async {
    emit(state.copyWith(orderApprovalStatus: OrderForApprovalStatus.loading));
    try {
      final result = await orderUseCase.responseFromTheCustomer(
        receiptItemId: receiptItemId,
        customerApproved: customerApproved,
        reasonForRefusingMaintenance: reasonForRefusingMaintenance,
      );
      result.fold(
        (failure) => emit(state.copyWith(
          orderApprovalStatus: OrderForApprovalStatus.failure,
        )),
        (response) => emit(state.copyWith(
          orderApprovalStatus: OrderForApprovalStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        orderApprovalStatus: OrderForApprovalStatus.failure,
      ));
    }
  }

  Future<void> addHandReceiptItemsByDm(
      int receiptItemId, createOrderRequest) async {
    emit(state.copyWith(orderCreationStatus: OrderCreationStatus.loading));
    try {
      final result = await orderUseCase.addHandReceiptItemsByDm(
          receiptItemId, createOrderRequest);
      result.fold(
        (failure) => emit(state.copyWith(
          orderCreationStatus: OrderCreationStatus.failure,
        )),
        (response) => emit(state.copyWith(
          orderCreationStatus: OrderCreationStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        orderCreationStatus: OrderCreationStatus.failure,
      ));
    }
  }

  Future<void> getOrderProductByUserNew({bool refresh = false}) async {
    emit(state.copyWith(orderProductStatus: OrderProductStatus.loading));
    final page = refresh ? 1 : state.orderCurrentPage;
    final result = await orderUseCase
        .getOrderProductByUserNew(PaginationParams(page: page));
    result.fold(
      (failure) =>
          emit(state.copyWith(orderProductStatus: OrderProductStatus.failure)),
      (orders) => emit(state.copyWith(
          orderProductStatus: OrderProductStatus.success,
          ordersProductItemsNew: orders.items)),
    );
  }

  Future<void> getOrderProductByUserOld({bool refresh = false}) async {
    emit(state.copyWith(orderProductStatus: OrderProductStatus.loading));
    final page = refresh ? 1 : state.orderCurrentPage;
    final result = await orderUseCase
        .getOrderProductByUserOld(PaginationParams(page: page));
    result.fold(
      (failure) =>
          emit(state.copyWith(orderProductStatus: OrderProductStatus.failure)),
      (orders) => emit(state.copyWith(
          orderProductStatus: OrderProductStatus.success,
          ordersProductItemsOld: orders.items)),
    );
  }

  Future<void> getAllItemByOrder(int basketId) async {
    emit(state.copyWith(orderProductStatus: OrderProductStatus.loading));

    try {
      final result = await orderUseCase.getAllItemByOrder(basketId);

      result.fold(
        (failure) {
          emit(state.copyWith(
            orderProductStatus: OrderProductStatus.failure,
          ));
        },
        (data) {
          print(data.length);
          print("ssssssssssssssssssss");
          if (data.isEmpty) {
            emit(state.copyWith(
              orderProductStatus: OrderProductStatus.success,
              basket: data,
            ));
          } else {
            emit(state.copyWith(
              orderProductStatus: OrderProductStatus.success,
              basket: data,
            ));
            print("ddddddddddd");

            print(state.basket[0].orders.length);
          }
        },
      );
    } catch (e) {
      emit(state.copyWith(
        orderProductStatus: OrderProductStatus.failure,
      ));
    }
  }

  Future<void> payWithApp(int orderMaintenancId) async {
    emit(state.copyWith(payWithApp: OrderPayWithAppStatus.loading));
    final result = await orderUseCase.payWithApp(orderMaintenancId);
    result.fold(
      (failure) => emit(state.copyWith(
        payWithApp: OrderPayWithAppStatus.failure,
      )),
      (_) => getOrderMaintenanceByUserNew(),
    );
  }
}
