class ProfileEntity {
  String? fullName;
  String? email;
  String? phoneNumber;
  int? orderShopCount;
  int? orderMaintenancesCount;
  int? orderShopNewCount;
  int? orderMaintenancesNewCount;

  ProfileEntity(
      {this.fullName,
      this.email,
      this.phoneNumber,
      this.orderShopCount,
      this.orderMaintenancesCount,
      this.orderShopNewCount,
      this.orderMaintenancesNewCount});
}
