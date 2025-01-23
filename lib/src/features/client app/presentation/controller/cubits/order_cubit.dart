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
    orderItems?.add(itemsEntity!); // Save the order locally in the orders map

    // Emit the updated state to notify the UI
    emit(state.copyWith(
      itemOrdersStatus: ItemOrdersStatus.success,
      items: orderItems,
    ));
  }

  Future<void> initOrdersRequirements() async {
    await Future.wait([
      fetchColorList(),
      fetchItemsList(),
      fetchCompaniesList(),
      getOrderMaintenanceByUserNew()
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
    emit(state.copyWith(selectedColor: color));
  }

  selectItem(OrderEntery item) {
    emit(state.copyWith(selectedItem: item));
  }

  selectCompany(OrderEntery company) {
    emit(state.copyWith(selectedCompany: company));
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
    final page = refresh ? 1 : state.orderCurrentPage;
    final result = await orderUseCase
        .getOrderMaintenanceByUserNew(PaginationParams(page: page));
    result.fold(
      (failure) => emit(state.copyWith(orderStatus: OrderStatus.failure)),
      (orders) => emit(state.copyWith(
          orderStatus: OrderStatus.success, ordersItems: orders.items)),
    );
  }
}
