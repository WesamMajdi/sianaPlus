class ContactUsResponse {
  final int status;
  final String message;

  ContactUsResponse({
    required this.status,
    required this.message,
  });

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) {
    return ContactUsResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}

abstract class ContactRepository {
  Future<ContactUsResponse> createContactUs(
      String fullName, String email, String phoneNumber, String message);
}
