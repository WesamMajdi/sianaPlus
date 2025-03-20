// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignupModel {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;

  final String countryCode;

  SignupModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.countryCode,
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
}
