class CreateOrderDeliveryRequest {
  final int itemId;
  final int companyId;
  final int colorId;
  final String description;

  CreateOrderDeliveryRequest({
    required this.itemId,
    required this.companyId,
    required this.colorId,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'companyId': companyId,
      'colorId': colorId,
      'description': description,
    };
  }
}
