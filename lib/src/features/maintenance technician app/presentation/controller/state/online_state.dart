// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/hand_receipt_maintenance_parts/hand_receipt_maintenance_parts_entitie.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/online_maintenance_parts/online_maintenance_parts_entity.dart';

enum OnlineStatus { initial, loading, success, failure }

class OnlineState extends Equatable {
  final OnlineStatus onlineStatus;
  final List<OnlineEntity> receiptsOnline;
  final String errorMessage;
  final bool isUpdating;
  final String successMessage;
  final String malfunctionDescription;
  final double? maintenanceCost;
  final int currentPage;
  final bool hasReachedEnd;
  final OnlineEntity? onlineItem;

  OnlineState(
      {this.onlineStatus = OnlineStatus.initial,
      this.receiptsOnline = const <OnlineEntity>[],
      this.errorMessage = '',
      this.isUpdating = false,
      this.successMessage = '',
      this.malfunctionDescription = '',
      this.maintenanceCost,
      this.onlineItem,
      this.currentPage = 0,
      this.hasReachedEnd = false});

  factory OnlineState.initial() {
    return OnlineState(
        onlineStatus: OnlineStatus.initial,
        receiptsOnline: const [],
        errorMessage: '',
        isUpdating: false,
        successMessage: '',
        malfunctionDescription: '',
        maintenanceCost: null,
        onlineItem: null,
        hasReachedEnd: false,
        currentPage: 0);
  }

  OnlineState copyWith({
    OnlineStatus? onlineStatus,
    List<OnlineEntity>? receiptsOnline,
    String? errorMessage,
    bool? isUpdating,
    String? successMessage,
    String? malfunctionDescription,
    double? maintenanceCost,
    OnlineEntity? onlineItem,
    int? currentPage,
    bool? hasReachedEnd,
  }) {
    return OnlineState(
      onlineStatus: onlineStatus ?? this.onlineStatus,
      receiptsOnline: receiptsOnline ?? this.receiptsOnline,
      errorMessage: errorMessage ?? this.errorMessage,
      isUpdating: isUpdating ?? this.isUpdating,
      successMessage: successMessage ?? this.successMessage,
      malfunctionDescription:
          malfunctionDescription ?? this.malfunctionDescription,
      maintenanceCost: maintenanceCost ?? this.maintenanceCost,
      onlineItem: onlineItem ?? this.onlineItem,
      currentPage: currentPage ?? this.currentPage,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  @override
  List<Object?> get props => [
        onlineStatus,
        receiptsOnline,
        errorMessage,
        isUpdating,
        successMessage,
        malfunctionDescription,
        maintenanceCost,
        onlineItem,
        currentPage,
        hasReachedEnd
      ];
}
