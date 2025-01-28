import 'package:maintenance_app/src/features/client%20app/domain/entities/profile/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    orderShopCount = json['orderShopCount'];
    orderMaintenancesCount = json['orderMaintenancesCount'];
    orderShopNewCount = json['orderShopNewCount'];
    orderMaintenancesNewCount = json['orderMaintenancesNewCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = fullName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['orderShopCount'] = orderShopCount;
    data['orderMaintenancesCount'] = orderMaintenancesCount;
    data['orderShopNewCount'] = orderShopNewCount;
    data['orderMaintenancesNewCount'] = orderMaintenancesNewCount;
    return data;
  }
}