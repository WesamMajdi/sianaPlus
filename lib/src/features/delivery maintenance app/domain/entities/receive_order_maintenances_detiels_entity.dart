class ReceiveOrderMaintenancesDetielsEntity {
  final int id;
  final String? item;
  final String? company;
  final String? color;
  final String? description;
  final int? maintenanceRequestStatus;

  ReceiveOrderMaintenancesDetielsEntity(
      {required this.id,
      required this.item,
      required this.company,
      required this.color,
      required this.description,
      required this.maintenanceRequestStatus});

  @override
  String toString() {
    return 'ReceiveOrderDetielsEntity(id: $id, item: $item, company: $company, color: $color, description: $description)';
  }
}
