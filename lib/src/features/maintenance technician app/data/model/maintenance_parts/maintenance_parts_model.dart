class MaintenancePart {
  final String maintenancePartName;
  final String clientName;
  final String clientPhone;
  final OrderStatus status;

  MaintenancePart({
    required this.maintenancePartName,
    required this.clientName,
    required this.clientPhone,
    required this.status,
  });
}

enum OrderStatus { New, TakeFromStorage, DeliveryToCustomer, Completed }
