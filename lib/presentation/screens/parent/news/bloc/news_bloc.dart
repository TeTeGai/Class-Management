import 'dart:async';
import 'dart:math';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/model/news_model.dart';
import 'package:luan_an/data/model/user_model.dart';
import 'package:luan_an/data/repository/news_repository/firebase_news_repo.dart';
import 'package:luan_an/presentation/screens/teacher/classselect/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/repository/chat_repository/firebase_chat_repo.dart';
import 'bloc.dart';

class NewsBloc extends Bloc<NewsEvent,NewsState>
{
  FirebaseNewsRepository firebaseNewsRepository= FirebaseNewsRepository();
  FirebaseChatRepository firebaseChatRepository = FirebaseChatRepository();
  StreamSubscription? _studentStreamSub;
  String firebaseAuth = FirebaseAuth.instance.currentUser!.uid;
  List<UserModel> listUser=[];
  List listClass=[];
  List<NewsModel> newsParent=[];

  List listUserInClass =[];
  NewsBloc(): super(NewsLoading()){
    on<NewsLoad>((event, emit) async => await _mapLoadNewsState(emit,event) );
    on<UpdateNews>((event, emit) async => await _mapUpdateNewsToState(emit,event));
    on<LikesLoadUser>((event, emit) async => await _mapLikesLoadUserToState(emit,event) );
    on<UpdateLikesNews>((event, emit) async => await _mapUpdateListLikesToState(emit,event));
    on<NewsLikesParentLoad>((event, emit)async  => await _mapNewsLikeParentToState(emit,event));
    on<NewsParentLoad>((event, emit) async => await _mapLoadParentNewsState(emit,event),transformer: restartable(), );
    on<UpdateParentNews>((event, emit) async => await _mapUpdateParentNewsToState(emit,event));
  }

  Future<void> _mapLoadNewsState(Emitter emit,NewsLoad event)
  async {
    emit(NewsLoading());
    try{
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');

      _studentStreamSub = firebaseNewsRepository.LoadNews(classId!).listen((event) => add(UpdateNews(event)));
    }catch(e)
    {

    }
  }
  Future<void> _mapUpdateNewsToState(Emitter emit,UpdateNews event)
  async {
    try{
      emit(NewsLoaded(event.newsModel));
    }
    catch (e)
    {
      emit(NewsLoadFail(e.toString()));
    }
  }

  Future<void> _mapLoadParentNewsState(Emitter emit,NewsParentLoad event)
  async {
    emit(NewsLoading());
    try{

       await FirebaseFirestore.instance.collection('class').where("member",arrayContainsAny: [FirebaseAuth.instance.currentUser!.uid]).get().then((value) {

             List.from(value.docs.map((e) =>  listClass.add(e.id)));
      }
      );
      _studentStreamSub = firebaseNewsRepository.LoadParentNews(listClass).listen((event) => add(UpdateParentNews(event)));

    }catch(e)
    {
    }
  }
  Future<void> _mapUpdateParentNewsToState(Emitter emit,UpdateParentNews event)
  async {
    try{
      emit(NewsParentLoaded(event.newsModel));
    }
    catch (e)
    {
      emit(NewsLoadFail(e.toString()));
    }
  }


  Future<void> _mapNewsLikeParentToState(Emitter emit, NewsLikesParentLoad event,)
  async
  {
    await firebaseNewsRepository.likeNews(event.postId, firebaseAuth, event.like, event.classId);
  }

  Future<void> _mapLikesLoadUserToState(Emitter emit, LikesLoadUser event)
  async{
    event.listLikes.forEach((element)  async {
      _studentStreamSub =
          firebaseChatRepository.LoadUser(element,'').listen((event) {
            listUser.addAll(event);
            add(UpdateLikesNews(listUser.toList()));
          }
          );
    }
    );
  }
  Future<void> _mapUpdateListLikesToState(Emitter emit,UpdateLikesNews event)
  async {
    try{
      emit(ListLikesLoaded(event.listLikes));
    }
    catch (e)
    {
      emit(NewsLoadFail(e.toString()));
    }
  }
  @override
  Future<void> close() {
    _studentStreamSub?.cancel();
    return super.close();
  }
}