import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/receive_order_maintenances_detiels_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_detiels_entity.dart';

class ReceiveOrderMaintenancesModel
    extends ReceiveOrderMaintenancesDetielsEntity {
  ReceiveOrderMaintenancesModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          item: json['item'],
          company: json['company'],
          color: json['color'],
          description: json['description'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'item': item,
        'company': company,
        'color': color,
        'description': description,
      };
}
