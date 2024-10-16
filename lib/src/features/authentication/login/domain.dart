//user model
class User {
  final String id;
  final String email;
  final int userType;
  final String name;
  final String imagePath;

  User({
    required this.id,
    required this.email,
    required this.userType,
    required this.name,
    required this.imagePath,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      userType: json['userType'],
      name: json['name'],
      imagePath: json['imagePath'],
    );
  }
}

//login response
class LoginResponse {
  final int status;
  final String? msg;
  final String token;
  final User user;

  LoginResponse({
    required this.status,
    this.msg,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      msg: json['msg'],
      token: json['data']['token'],
      user: User.fromJson(json['data']),
    );
  }
}
