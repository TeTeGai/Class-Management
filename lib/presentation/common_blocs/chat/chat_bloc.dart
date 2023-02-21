import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/user_model.dart';
import 'package:luan_an/data/repository/chat_repository/firebase_chat_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'bloc.dart';


class ChatBloc extends Bloc<ChatEvent,ChatState>{
  StreamSubscription? _scoreStreamSub;
  List listUserInClass =[];
   List<UserModel> listUser=[];
  FirebaseChatRepository firebaseChatRepository = new FirebaseChatRepository();
  ChatBloc():super(ChatLoading())
  {
    on<ChatLoadUser>((event, emit) async=>await _mapChatLoadUserToState(emit,event),  transformer: restartable(),);
    on<UserUpdate>((event, emit) async=>await _mapUserUpdateToState(emit,event));
    on<ChatAdd>((event, emit) async=>await _mapChatAddToState(emit, event,));
    on<MessLoadUser>((event, emit) async=>await _mapMessLoadUserToState(emit, event));
    on<MessUserUpdate>((event, emit) async=>await _mapMessUserUpdateToState(emit,event));
    on<TextSent>((event, emit) async=>await _mapTextSentToState(emit,event));
    on<TextLoad>((event, emit) async=>await _mapTextLoadToState(emit,event));
    on<TextUpdate>((event, emit) async=>await _mapTextUpdateToState(emit,event));
  }

  Future<void> _mapChatLoadUserToState(Emitter emit, ChatLoadUser event)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    await  firebaseChatRepository.loadUserInClass(classId!).then((value) {
      listUserInClass.addAll(value);
     }) ;

    print(listUserInClass);
    listUserInClass.forEach((element)  async {
      _scoreStreamSub =
          firebaseChatRepository.LoadUser(element,FirebaseAuth.instance.currentUser!.uid).listen((event) {
            listUser.addAll(event);
            add(UserUpdate(listUser.toList()));
          }
          );
    }
    );
  }

  Future<void> _mapUserUpdateToState( Emitter emit,  UserUpdate event)
  async{
    emit(UserLoaded(event.userModel));
  }

  Future<void> _mapChatAddToState(Emitter emitter, ChatAdd event)
  async{
    try{
      await firebaseChatRepository.addToMyChat(FirebaseAuth.instance.currentUser!.uid,
          event.recipientId, event.chatModel1, event.chatModel2,event.isGroup,"");
    }catch (e)
    {
      print(e.toString());
    }
  }

  Future<void> _mapMessLoadUserToState(Emitter emit, MessLoadUser event)
  async{
      _scoreStreamSub = firebaseChatRepository.LoadChat(FirebaseAuth.instance.currentUser!.uid).listen((event) {
            add(MessUserUpdate(event));
      });
  }

  Future<void> _mapMessUserUpdateToState( Emitter emit,  MessUserUpdate event)
  async{
    emit(MessUserLoaded(event.chatModel));
  }

  Future<void> _mapTextSentToState( Emitter emit,  TextSent event)
  async{
    firebaseChatRepository.sentTextMessage(
        event.text,
        event.lastMess,
        event.senderId,
        event.recipientId,
        event.senderUsername,
        event.recipientUsername,
        event.time,
        event.type,
        event.isGroupChat);
  }

  Future<void> _mapTextLoadToState(Emitter emit, TextLoad event)
  async{
    _scoreStreamSub = firebaseChatRepository.getChatStream(FirebaseAuth.instance.currentUser!.uid,event.recipientId).listen((event) {
      add(TextUpdate(event));
    });
  }

  Future<void> _mapTextUpdateToState( Emitter emit,  TextUpdate event)
  async{
    emit(TextLoaded(event.listTextModel));
  }

  @override
  Future<void> close() {
    _scoreStreamSub?.cancel();
    return super.close();
  }
}