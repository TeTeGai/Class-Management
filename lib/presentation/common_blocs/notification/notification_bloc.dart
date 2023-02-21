import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:luan_an/presentation/common_blocs/notification/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/repository/notification_repository/firebase_notifi_repo.dart';


class NotificationBloc extends Bloc<NotificationEvent,NotificationState>{
  StreamSubscription? _notificationStreamSub;

  FirebaseNotificationRepository firebaseNotificationRepository = new FirebaseNotificationRepository();
  NotificationBloc():super(NotificationLoading())
  {
    on<NotificationLoad>((event, emit) async=>await _mapNotificationLoadToState(emit,event),  transformer: restartable(),);
    on<NotificationUpdate>((event, emit) async=>await _mapNotificationUpdateToState(emit,event));
    on<NotificationUpdateModel>((event, emit) async=>await _mapNotificationUpdateModelToState(emit,event));
    on<ClassNotificationUpdateModel>((event, emit) async=>await _mapClassNotificationUpdateModelToState(emit,event));
    on<NotificationRemove>((event, emit) async=>await _mapNotificationRemoveToState(emit,event));
    on<ClassNotificationRemove>((event, emit) async=>await _mapClassNotificationRemoveToState(emit,event));
    on<ClassNotificationLoad>((event, emit) async=>await _mapClassNotificationLoadToState(emit,event),  transformer: restartable(),);
    on<ClassNotificationUpdate>((event, emit) async=>await _mapClassNotificationUpdateToState(emit,event));
  }


  Future<void> _mapNotificationLoadToState(Emitter emit, NotificationLoad event)
  async{
    _notificationStreamSub?.cancel();
    _notificationStreamSub = firebaseNotificationRepository.LoadNotification().listen((event) {
            add(NotificationUpdate(event));
      });
  }

  Future<void> _mapClassNotificationLoadToState(Emitter emit, ClassNotificationLoad event)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    _notificationStreamSub?.cancel();
    _notificationStreamSub = firebaseNotificationRepository.ClassLoadNotification(classId!).listen((event) {
      add(ClassNotificationUpdate(event));
    });
  }

  Future<void> _mapNotificationUpdateModelToState(Emitter emit, NotificationUpdateModel event)
  async{

    firebaseNotificationRepository.NotificationUpdate(FirebaseAuth.instance.currentUser!.uid, event.notificationId);
  }

  Future<void> _mapClassNotificationUpdateModelToState(Emitter emit, ClassNotificationUpdateModel event)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    firebaseNotificationRepository.ClassNotificationUpdate(classId!, event.notificationId);
  }

  Future<void> _mapNotificationRemoveToState(Emitter emit, NotificationRemove event)
  async{
    firebaseNotificationRepository.NotificationRemove(FirebaseAuth.instance.currentUser!.uid, event.notificationId);
  }

  Future<void> _mapClassNotificationRemoveToState(Emitter emit, ClassNotificationRemove event)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    firebaseNotificationRepository.ClassNotificationRemove(classId!, event.notificationId);
  }

  Future<void> _mapNotificationUpdateToState( Emitter emit,  NotificationUpdate event)
  async{
    emit(NotificationLoaded(event.notificationModel));
  }

  Future<void> _mapClassNotificationUpdateToState( Emitter emit,  ClassNotificationUpdate event)
  async{
    emit(ClassNotificationLoaded(event.notificationModel));
  }


  @override
  Future<void> close() {
    _notificationStreamSub?.cancel();
    return super.close();
  }
}