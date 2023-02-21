 import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/repository/schedule_repository/firebase_schedule_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/repository/chat_repository/firebase_chat_repo.dart';
import '../../../data/repository/notification_repository/firebase_notifi_repo.dart';
import '../../../data/repository/user_repository/firebase_user_repo.dart';
import '../../../utils/pushnotifications.dart';
import 'bloc.dart';


class ScheduleBloc extends Bloc<ScheduleEvent,ScheduleState>
{
  FirebaseScheduleRepository scheduleRepository = FirebaseScheduleRepository();
  StreamSubscription? _studentStreamSub;
  List listUserInClass =[];
  String nameClass ='';
  String avatar ='';
  UserAuthRepository userAuthRepository = new UserAuthRepository();
  FirebaseChatRepository firebaseChatRepository = new FirebaseChatRepository();
  FirebaseNotificationRepository firebaseNotificationRepository = new FirebaseNotificationRepository();

  ScheduleBloc(): super(ScheduleLoading())
  {
    on<ScheduleAdd>((event, emit) async=> await _mapScheduleAddToState(emit,event));
    on<ScheduleLoad>((event, emit) async =>await _mapScheduleLoadToState(emit,event,), transformer: restartable(),);
    on<ScheduleUpdate>((event, emit) async =>await _mapUpdateScheduleToState(emit,event));
    on<ScheduleRemove>((event, emit) async =>await _mapRemoveScheduleToState(emit,event));
    on<ScheduleUpdateModel>((event, emit) async =>await _mapUpdateModelScheduleToState(emit,event));
    on<ScheduleSonLoad>((event, emit) async =>await _mapScheduleSonLoadToState(emit,event));
    on<ScheduleSonUpdate>((event, emit) async =>await _mapUpdateSonScheduleToState(emit,event));
  }

  Future<void> _mapScheduleAddToState(Emitter emitter, ScheduleAdd event)
  async{
    // String event.scheduleModel.title + event.scheduleModel.date;
    try{
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      await  firebaseChatRepository.loadUserInClass(classId!).then((value) {
        listUserInClass.addAll(value);
      }) ;
      await firebaseChatRepository.loadNameClass(classId!).then((value) {
        nameClass = value;
      });
      await firebaseChatRepository.loadAvatarClass(classId!).then((value) {
        avatar = value;
      });
      await scheduleRepository.AddSchedule(event.scheduleModel, classId!);
      listUserInClass.forEach((element)  async {
        if(element !=FirebaseAuth.instance.currentUser!.uid)
        {
          await firebaseNotificationRepository.AddNotifiCation(element,
              event.title,
               avatar,
               nameClass,
              false,
              );
          userAuthRepository.getUserByID(element).then((value) {
            PushNotifications.callOnFcmApiSendPushNotifications(
                body:   ' 1 lịch mới đã được thêm vào '+nameClass,
                To: value.pushToken!);
          });
        }
      });
    }catch (e)
    {
      print(e.toString());
    }
  }
  Future<void> _mapScheduleLoadToState(Emitter emitter,ScheduleLoad event)
  async{
    emit(ScheduleLoading());
    try{
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      _studentStreamSub?.cancel();
      _studentStreamSub = scheduleRepository.LoadSchedule(classId!,event.date).listen((event) => add(ScheduleUpdate(event)));
    }catch(e)
    {
      emit(ScheduleLoadFail("khong load duoc"));
    }
  }

  Future<void> _mapUpdateScheduleToState(Emitter emit,ScheduleUpdate event)
  async {
    try{
      emit(ScheduleLoaded(event.scheduleModel));
    }
    catch (e)
    {
      emit(ScheduleLoadFail(e.toString()));
    }
  }

  Future<void> _mapScheduleSonLoadToState(Emitter emitter,ScheduleSonLoad event)
  async{
    emit(ScheduleLoading());
    try{
      _studentStreamSub?.cancel();
      _studentStreamSub = scheduleRepository.LoadSonSchedule(event.classId).listen((event) => add(ScheduleSonUpdate(event)));
    }catch(e)
    {
      emit(ScheduleLoadFail("khong load duoc"));
    }
  }

  Future<void> _mapUpdateSonScheduleToState(Emitter emit,ScheduleSonUpdate event)
  async {
    try{
      emit(ScheduleSonLoaded(event.scheduleModel));
    }
    catch (e)
    {
      emit(ScheduleLoadFail(e.toString()));
    }
  }

  Future<void> _mapRemoveScheduleToState(Emitter emit,ScheduleRemove event)
  async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      await scheduleRepository.DelectSchedule(event.scheduleId, classId!);

    }
    catch (e)
    {
    }
  }

  Future<void> _mapUpdateModelScheduleToState(Emitter emit,ScheduleUpdateModel event)
  async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      await  firebaseChatRepository.loadUserInClass(classId!).then((value) {
        listUserInClass.addAll(value);
      }) ;
      print(listUserInClass);
      await firebaseChatRepository.loadNameClass(classId!).then((value) {
        nameClass = value;
      });
      await firebaseChatRepository.loadAvatarClass(classId!).then((value) {
        avatar = value;
      });
      listUserInClass.forEach((element)  async {
        if(element !=FirebaseAuth.instance.currentUser!.uid)
        {
          await firebaseNotificationRepository.AddNotifiCation(element,
            event.title +" đã thay đổi thời gian thành: "+ event.startTime +('-')+event.endTime+(" ")+ event.date,
            avatar,
            nameClass,
            false,
          );
          userAuthRepository.getUserByID(element).then((value) {
            PushNotifications.callOnFcmApiSendPushNotifications(
                body: nameClass+": " +  event.title +" đã thay đổi thời gian thành: "+ event.startTime +('-')+event.endTime+(" ")+ event.date,
                To: value.pushToken!);
          });
        }
      });
      await scheduleRepository.UpdateSchedule(
          event.scheduleId,
          classId!,
          event.title,
          event.note,
          event.date,
          event.startTime,
          event.endTime,
          event.colorIndex);


    }
    catch (e)
    {
    }
  }
  @override
  Future<void> close() {
    _studentStreamSub?.cancel();
    return super.close();
  }
}