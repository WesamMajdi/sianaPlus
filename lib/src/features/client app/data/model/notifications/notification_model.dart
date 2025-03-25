import 'package:maintenance_app/src/features/client%20app/domain/entities/notifications/notifications_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    pageId = json['pageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['pageId'] = this.pageId;
    return data;
  }
}
