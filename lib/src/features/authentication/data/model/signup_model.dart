// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignupModel {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String? countryCode;

  SignupModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    this.countryCode,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "phoneNumber": phoneNumber,
      "countryCode": countryCode,
    };
  }

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      confirmPassword: json['confirmPassword'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      countryCode: json['countryCode'] ?? '',
    );
  }
}

class SignupResponseData {
  final SignupModel user;
  final String code;

  SignupResponseData({
    required this.user,
    required this.code,
  });

  factory SignupResponseData.fromJson(Map<String, dynamic> json) {
    return SignupResponseData(
      user: SignupModel.fromJson(json['user']),
      code: json['code'] ?? '',
    );
  }
}

class PhoneNumberVerifyModel {
  final String phone;
  final String code;

  PhoneNumberVerifyModel({required this.phone, required this.code});

  factory PhoneNumberVerifyModel.fromJson(Map<String, dynamic> json) {
    return PhoneNumberVerifyModel(
      phone: json['phone'] ?? '',
      code: json['code'] ?? '',
    );
  }
}
