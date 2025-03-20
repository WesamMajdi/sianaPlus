class UpdateEmailModel {
  final String newEmail;

  UpdateEmailModel({
    required this.newEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      "newEmail": newEmail,
    };
  }
}
