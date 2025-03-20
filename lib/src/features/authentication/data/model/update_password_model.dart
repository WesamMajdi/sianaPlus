class UpdtePasswordModel {
  final String? oldPassword;
  final String? newPassword;
  UpdtePasswordModel({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
  }
}
