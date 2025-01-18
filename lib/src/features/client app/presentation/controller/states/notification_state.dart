import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/notifications/notifications_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';

import '../../../data/model/orders/orders_model_request.dart';
import '../../../domain/entities/category/category_entity.dart';


enum NotificationStatus { initial, loading, success, failure }

class NotificationState extends Equatable {
  NotificationStatus notificationStatus;
  int notificationCurrentPage;
  List<NotificationEntity> notifications;
   String errorMessage;

  NotificationState({
    this.notificationStatus = NotificationStatus.initial,
    this.notifications = const <NotificationEntity>[],
    this.notificationCurrentPage=1,
    this.errorMessage = '',
  });

  NotificationState copyWith(
      {
        List<NotificationEntity>? notifications,
        NotificationStatus? notificationStatus,
        int? notificationCurrentPage,
        String? errorMessage,
       }) {
    return NotificationState(
      notificationCurrentPage: notificationCurrentPage ?? this.notificationCurrentPage,
      notifications: notifications ?? this.notifications,
          notificationStatus: notificationStatus ?? this.notificationStatus,

      errorMessage: errorMessage ?? this.errorMessage,


    );
  }

  @override
  List<Object?> get props => [
    notifications,
    notificationStatus,
    notificationCurrentPage,
    errorMessage
  ];
}
