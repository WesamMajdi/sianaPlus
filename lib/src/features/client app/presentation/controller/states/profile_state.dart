import 'package:equatable/equatable.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus profileStatus;
  final String? name;
  final String? email;
  final String? phone;
  final int? orderShopCount;
  final int? orderMaintenancesCount; 
  final int? orderShopNewCount;
  final int? orderMaintenancesNewCount;
  final String? errorMessage;

  const ProfileState({
    this.profileStatus = ProfileStatus.initial,
    this.name,
    this.email,
    this.phone,
    this.orderShopCount,
    this.orderMaintenancesCount,
    this.orderShopNewCount,
    this.orderMaintenancesNewCount,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    String? name,
    String? email,
    String? phone,
    int? orderShopCount,
    int? orderMaintenancesCount,
    int? orderShopNewCount,
    int? orderMaintenancesNewCount,
    String? errorMessage,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      orderShopCount: orderShopCount ?? this.orderShopCount,
      orderMaintenancesCount: orderMaintenancesCount ?? this.orderMaintenancesCount,
      orderShopNewCount: orderShopNewCount ?? this.orderShopNewCount,
      orderMaintenancesNewCount: orderMaintenancesNewCount ?? this.orderMaintenancesNewCount,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    profileStatus,
    name,
    email,
    phone,
    orderShopCount,
    orderMaintenancesCount,
    orderShopNewCount,
    orderMaintenancesNewCount,
    errorMessage,
  ];
}
