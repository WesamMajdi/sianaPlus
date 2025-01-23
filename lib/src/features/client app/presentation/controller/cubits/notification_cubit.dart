import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/client%20app/domain/usecases/notifications/fetch_notifications_useCase.dart';
import 'package:maintenance_app/src/features/client%20app/domain/usecases/orders/fetch_orders_useCase.dart';

import '../../../../../core/pagination/pagination_params.dart';
import '../../../domain/entities/orders/orders_entity.dart';
import '../states/notification_state.dart';
import '../states/order_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationUseCase notificationUseCase;
  List<ItemsEntity>? orderItems = [];

  NotificationCubit(this.notificationUseCase) : super(NotificationState());


  Future<void> getNotifications({bool refresh = false}) async {
    emit(state.copyWith(notificationStatus: NotificationStatus.loading));
    final page = refresh ? 1 : state.notificationCurrentPage;
    final result = await notificationUseCase
        .getNotifications(PaginationParams(page: page));
    result.fold(
          (failure) => emit(state.copyWith(notificationStatus: NotificationStatus.failure,errorMessage: failure.message)),
          (notifications) => emit(state.copyWith(
              notificationStatus: NotificationStatus.success, notifications: notifications.items)),
    );
   }
}
