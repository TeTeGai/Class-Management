import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/chat_model.dart';
import 'package:luan_an/data/model/notification_model.dart';
import 'package:luan_an/data/model/text_model.dart';
import 'package:luan_an/data/model/user_model.dart';

class NotificationEvent extends Equatable{
  const NotificationEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NotificationLoad extends NotificationEvent{
}
class ClassNotificationLoad extends NotificationEvent{
}


class NotificationUpdateModel extends NotificationEvent{
  final String notificationId;
  NotificationUpdateModel(this.notificationId);
}

class ClassNotificationUpdateModel extends NotificationEvent{
  final String notificationId;
  ClassNotificationUpdateModel(this.notificationId);
}

class NotificationRemove extends NotificationEvent{
  final String notificationId;
  NotificationRemove(this.notificationId);
}
class ClassNotificationRemove extends NotificationEvent{
  final String notificationId;
  ClassNotificationRemove(this.notificationId);
}

class NotificationUpdate extends NotificationEvent{
  List<NotificationModel> notificationModel;
  NotificationUpdate(this.notificationModel);
  @override
  // TODO: implement props
  List<Object?> get props => [notificationModel];
}
class ClassNotificationUpdate extends NotificationEvent{
  List<NotificationModel> notificationModel;
  ClassNotificationUpdate(this.notificationModel);
  @override
  // TODO: implement props
  List<Object?> get props => [notificationModel];
}
