class SignUpResponse {
  final int status;
  final SignUpData data;
  final String message;

  SignUpResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      status: json['status'],
      data: SignUpData.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class SignUpData {
  final String token;
  final String role;
  final String username;
  final String? image;

  SignUpData({
    required this.token,
    required this.role,
    required this.username,
    this.image,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) {
    return SignUpData(
      token: json['token'],
      role: json['role'],
      username: json['username'],
      image: json['image'],
    );
  }
}
