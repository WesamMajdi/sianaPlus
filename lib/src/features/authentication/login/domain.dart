class LoginResponse {
  final int status;
  final LoginData data;
  final String message;

  LoginResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      data: LoginData.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class LoginData {
  final String token;
  final String role;
  final String username;
  final String? image;

  LoginData({
    required this.token,
    required this.role,
    required this.username,
    this.image,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'],
      role: json['role'],
      username: json['username'],
      image: json['image'],
    );
  }
}
