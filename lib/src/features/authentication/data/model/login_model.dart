class LoginModel {
  final String email;
  final String password;
  final String fcmToken;
  final bool rememberMe;

  LoginModel({
    required this.email,
    required this.password,
    required this.fcmToken,
    this.rememberMe = true,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "rememberMe": rememberMe,
      "fcmToken": fcmToken
    };
  }
}
