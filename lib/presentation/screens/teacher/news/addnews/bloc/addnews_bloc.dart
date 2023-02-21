
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/news_model.dart';
import 'package:luan_an/data/repository/news_repository/firebase_news_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../data/repository/chat_repository/firebase_chat_repo.dart';
import '../../../../../../data/repository/notification_repository/firebase_notifi_repo.dart';
import '../../../../../../data/repository/user_repository/firebase_user_repo.dart';
import '../../../../../../utils/pushnotifications.dart';
import 'bloc.dart';

class AddNewsBloc extends Bloc<AddNewsEvent,AddNewsState>
{
 List listUserInClass =[];
 String nameClass ='';
 String avatar ='';
 FirebaseNewsRepository firebaseNewsRepository = new FirebaseNewsRepository();
 FirebaseChatRepository firebaseChatRepository = new FirebaseChatRepository();
 UserAuthRepository userAuthRepository = new UserAuthRepository();
 FirebaseNotificationRepository firebaseNotificationRepository = new FirebaseNotificationRepository();
  AddNewsBloc(): super(AddingNews())
  {
    on<AddNews>((event, emit) async => _mapAddNewsToState(emit,event));
  }

  Future<void> _mapAddNewsToState(Emitter emit, AddNews event)
   async {
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    await firebaseChatRepository.loadUserInClass(classId!).then((value) {
     listUserInClass.addAll(value);
    });
    await firebaseChatRepository.loadNameClass(classId!).then((value) {
     nameClass = value;
    });
    await firebaseChatRepository.loadAvatarClass(classId!).then((value) {
     avatar = value;
    });
    print(listUserInClass);
    await firebaseNewsRepository.AddNews(event.newsModel, classId!, event.file);
    listUserInClass.forEach((element) async {
     if (element != FirebaseAuth.instance.currentUser!.uid) {
      await firebaseNotificationRepository.AddNotifiCation(element,
       event.newsModel.nameUser+' đã đăng 1 bài mới',
       avatar,
       nameClass,
       false,
      );
      userAuthRepository.getUserByID(element).then((value) {
       PushNotifications.callOnFcmApiSendPushNotifications(
           body:  event.newsModel.nameUser+ ' đã đăng 1 bài mới trong '+nameClass,
           To: value.pushToken!);
      });
     }
    });
   }








}