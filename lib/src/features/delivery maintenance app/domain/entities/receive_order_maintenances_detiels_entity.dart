class ReceiveOrderMaintenancesDetielsEntity {
  final int id;
  final String? item;
  final String? company;
  final String? color;
  final String? description;

  ReceiveOrderMaintenancesDetielsEntity({
    required this.id,
    required this.item,
    required this.company,
    required this.color,
    required this.description,
  });

  @override
  String toString() {
    return 'ReceiveOrderDetielsEntity(id: $id, item: $item, company: $company, color: $color, description: $description)';
  }
}
