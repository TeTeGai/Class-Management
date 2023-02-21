import 'package:equatable/equatable.dart';
import 'package:luan_an/presentation/common_blocs/chat/bloc.dart';
import '../../../data/model/notification_model.dart';

class NotificationState extends Equatable{
  const NotificationState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NotificationLoading extends NotificationState{}

class NotificationLoaded extends NotificationState{
  final List<NotificationModel> notificationModel;
  NotificationLoaded(this.notificationModel);
  @override
  // TODO: implement props
  List<Object?> get props => [notificationModel];
}

class ClassNotificationLoaded extends NotificationState{
  final List<NotificationModel> notificationModel;
  ClassNotificationLoaded(this.notificationModel);
  @override
  // TODO: implement props
  List<Object?> get props => [notificationModel];
}

class NotificationLoadFail extends ChatState{}