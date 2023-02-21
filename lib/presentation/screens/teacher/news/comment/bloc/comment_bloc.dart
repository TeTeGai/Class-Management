import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/comment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../data/repository/news_repository/firebase_news_repo.dart';
import 'bloc.dart';


class CommentBloc extends Bloc<CommentEvent,CommentState>
{
  FirebaseNewsRepository firebaseNewsRepository = new FirebaseNewsRepository();
  StreamSubscription? _studentStreamSub;
  CommentBloc(): super(CommentLoading()){
    on<CommentLoad>((event, emit)  async=>await _mapCmtLoadToState(emit,event));
    on<CommentAdd>((event, emit)  async=>await _mapCmtAddToState(emit,event,event.cmtModel));
    on<CommentUpdate>((event, emit)  async=>await _mapCmtUpdateToState(emit,event));
  }
  Future<void> _mapCmtLoadToState(Emitter emitter, CommentLoad event)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    emit(CommentLoading());
    try{
      _studentStreamSub?.cancel();
      _studentStreamSub = firebaseNewsRepository.LoadCmt(classId!,event.posId).listen((event) => add(CommentUpdate(event)));
    }catch(e)
    {
      emit(CommentLoadFail("khong load duoc"));
    }
  }

  Future<void> _mapCmtAddToState(Emitter emitter, CommentAdd event, CommentModel cmtModel)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    await firebaseNewsRepository.AddCmt(cmtModel, classId!, event.postId);
  }

  Future<void> _mapCmtUpdateToState(Emitter emitter, CommentUpdate event)
  async{
    try{
      emit(CommentLoaded(event.cmtModel));
    }
    catch (e)
    {
      emit(CommentLoadFail(e.toString()));
    }
  }
  @override
  Future<void> close() {
    _studentStreamSub?.cancel();
    // TODO: implement close
    return super.close();
  }
}