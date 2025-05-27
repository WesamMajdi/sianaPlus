class ForgotPasswordModel {
  final String? email;
  final String? countryCode;
  final String? phoneNumber;

  ForgotPasswordModel(this.countryCode, this.phoneNumber, this.email);

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "countryCode": countryCode,
      "phoneNumber": phoneNumber
    };
  }
}
