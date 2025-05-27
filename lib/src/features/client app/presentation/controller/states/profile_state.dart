import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/profile/slider_model.dart';

enum ProfileStatus { initial, loading, success, failure }

enum ProblemStatus { initial, loading, success, failure }

enum ChangeNameStatus { initial, loading, success, failure }

enum HomePageStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus profileStatus;
  final HomePageStatus homePageStatus;
  final List<ImageModel> imageList;
  final String? name;
  final String? email;
  final String? phone;
  final int? orderShopCount;
  final int? orderMaintenancesCount;
  final int? orderShopNewCount;
  final int? orderMaintenancesNewCount;
  final String? errorMessage;
  final ProblemStatus? problemStatus;
  final ChangeNameStatus changeNameStatus;

  const ProfileState({
    this.profileStatus = ProfileStatus.initial,
    this.homePageStatus = HomePageStatus.initial,
    this.imageList = const <ImageModel>[],
    this.name,
    this.email,
    this.phone,
    this.orderShopCount,
    this.orderMaintenancesCount,
    this.orderShopNewCount,
    this.orderMaintenancesNewCount,
    this.errorMessage,
    this.problemStatus = ProblemStatus.initial,
    this.changeNameStatus = ChangeNameStatus.initial,
  });
  factory ProfileState.initial() {
    return const ProfileState(
      profileStatus: ProfileStatus.initial,
      homePageStatus: HomePageStatus.initial,
      imageList: <ImageModel>[],
      name: null,
      email: null,
      phone: null,
      orderShopCount: null,
      orderMaintenancesCount: null,
      orderShopNewCount: null,
      orderMaintenancesNewCount: null,
      errorMessage: null,
      problemStatus: ProblemStatus.initial,
      changeNameStatus: ChangeNameStatus.initial,
    );
  }

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    HomePageStatus? homePageStatus,
    String? name,
    String? email,
    String? phone,
    int? orderShopCount,
    int? orderMaintenancesCount,
    int? orderShopNewCount,
    int? orderMaintenancesNewCount,
    ProblemStatus? problemStatus,
    ChangeNameStatus? changeNameStatus,
    String? errorMessage,
    List<ImageModel>? imageList,
  }) {
    return ProfileState(
        profileStatus: profileStatus ?? this.profileStatus,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        orderShopCount: orderShopCount ?? this.orderShopCount,
        orderMaintenancesCount:
            orderMaintenancesCount ?? this.orderMaintenancesCount,
        orderShopNewCount: orderShopNewCount ?? this.orderShopNewCount,
        orderMaintenancesNewCount:
            orderMaintenancesNewCount ?? this.orderMaintenancesNewCount,
        errorMessage: errorMessage ?? this.errorMessage,
        problemStatus: problemStatus ?? this.problemStatus,
        changeNameStatus: changeNameStatus ?? this.changeNameStatus,
        homePageStatus: homePageStatus ?? this.homePageStatus,
        imageList: imageList ?? this.imageList);
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
        problemStatus,
        changeNameStatus,
        homePageStatus,
        imageList
      ];
}
