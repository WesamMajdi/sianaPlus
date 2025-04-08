// import '../../features/client app/domain/entities/orders/orders_entity.dart';

// extension OrderMaintenanceStatusExtension on OrderMaintenanceStatus {
//   static OrderMaintenanceStatus fromId(int id) {
//     switch (id) {
//       case 1:
//         return OrderMaintenanceStatus.newOrder;
//       case 2:
//         return OrderMaintenanceStatus.takeFromCustomer;
//       case 3:
//         return OrderMaintenanceStatus.deliveryToBranch;
//       case 4:
//         return OrderMaintenanceStatus.maintenanceEnd;
//       case 5:
//         return OrderMaintenanceStatus.takeFromBranch;
//       case 6:
//         return OrderMaintenanceStatus.returnToCustomer;
//       case 7:
//         return OrderMaintenanceStatus.completed;
//       default:
//         throw Exception("Invalid status ID");
//     }
//   }

//   int get id {
//     switch (this) {
//       case OrderMaintenanceStatus.newOrder:
//         return 1;
//       case OrderMaintenanceStatus.takeFromCustomer:
//         return 2;
//       case OrderMaintenanceStatus.deliveryToBranch:
//         return 3;
//       case OrderMaintenanceStatus.maintenanceEnd:
//         return 4;
//       case OrderMaintenanceStatus.takeFromBranch:
//         return 5;
//       case OrderMaintenanceStatus.returnToCustomer:
//         return 6;
//       case OrderMaintenanceStatus.completed:
//         return 7;
//     }
//   }

//   String get name {
//     switch (this) {
//       case OrderMaintenanceStatus.newOrder:
//         return "New";
//       case OrderMaintenanceStatus.takeFromCustomer:
//         return "TakeFromCustomer";
//       case OrderMaintenanceStatus.deliveryToBranch:
//         return "DeliveryToBranch";
//       case OrderMaintenanceStatus.maintenanceEnd:
//         return "MaintenanceEnd";
//       case OrderMaintenanceStatus.takeFromBranch:
//         return "TakeFromBranch";
//       case OrderMaintenanceStatus.returnToCustomer:
//         return "ReturnToCustomer";
//       case OrderMaintenanceStatus.completed:
//         return "Completed";
//     }
//   }
// }
