class ResetPasswordModel {
  final String phoneNumber;
  final String newPassword;

  ResetPasswordModel({
    required this.phoneNumber,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {"phoneNumber": phoneNumber, "newPassword": newPassword};
  }
}

class ResetVerifyResetCodeModel {
  final String phoneNumber;
  final String code;

  ResetVerifyResetCodeModel({
    required this.phoneNumber,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {"phoneNumber": phoneNumber, "code": code};
  }
}
