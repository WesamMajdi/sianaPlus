class UserEntity {
  final String? token;
  final String? email;
  final String? role;
  final String? username;
  final dynamic image;
  final String? phone;
  UserEntity(
      {required this.token,
      required this.email,
      required this.role,
      required this.username,
      this.image,
      this.phone});
}
