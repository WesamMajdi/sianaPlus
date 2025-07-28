import 'package:maintenance_app/src/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel.fromJson(Map<String, dynamic> json)
      : super(
            token: json['token'] ?? '',
            email: json['email'] ?? '',
            role: json['role'] ?? '',
            username: json['username'] ?? '',
            image: json['image'] ?? '',
            phone: json['phone'] ?? '');

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'email': email,
      'role': role,
      'username': username,
      'image': image,
      'phone': phone
    };
  }
}
