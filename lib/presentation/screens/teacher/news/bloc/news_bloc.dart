import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/user_model.dart';
import 'package:luan_an/data/repository/news_repository/firebase_news_repo.dart';
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
  NewsBloc(): super(NewsLoading()){
    on<NewsLoad>((event, emit) async => await _mapLoadNewsState(emit,event) );
    on<UpdateNews>((event, emit) async => await _mapUpdateNewsToState(emit,event));
    on<LikesLoadUser>((event, emit) async => await _mapLikesLoadUserToState(emit,event) );
    on<UpdateLikesNews>((event, emit) async => await _mapUpdateListLikesToState(emit,event));
    on<NewsLikesLoad>((event, emit)  =>  _mapNewsLikeLoadToState(emit,event,event.postId,event.like));
    on<DeleteNews>((event, emit) async => await _mapDeleteNewToState(emit,event) );
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
  Future<void> _mapNewsLikeLoadToState(Emitter emit, NewsLikesLoad event, String postId, List like)
  async
  {
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    await firebaseNewsRepository.likeNews(postId, firebaseAuth, like, classId!);
  }

  Future<void> _mapDeleteNewToState(Emitter emit, DeleteNews event,)
  async
  {
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    await firebaseNewsRepository.DeleteNews(classId!, event.postId);
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