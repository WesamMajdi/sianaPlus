class OrderMaintenanceRequest {
  final int newId;
  final double fees;

  OrderMaintenanceRequest({
    required this.newId,
    required this.fees,
  });

  factory OrderMaintenanceRequest.fromJson(Map<String, dynamic> json) {
    return OrderMaintenanceRequest(
      newId: json['newId'],
      fees: json['fees'].toDouble(),
    );
  }
}
