import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/repository/notification_repository/firebase_notifi_repo.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repository/chat_repository/firebase_chat_repo.dart';
import '../../../data/repository/score_repository/firebase_score_repo.dart';

class ScoreBloc extends Bloc<ScoreEvent,ScoreState>
{
  String nameClass ='';
  String avatar ='';
  FirebaseChatRepository firebaseChatRepository = new FirebaseChatRepository();
  FirebaseScoreRepository firebaseScoreRepository = new FirebaseScoreRepository();
  FirebaseNotificationRepository firebaseNotificationRepository = new FirebaseNotificationRepository();
  StreamSubscription? _scoreStreamSub;
  ScoreBloc():super(ScoreLoading()){
    on<GPAGoodLoad>((event, emit) async =>await _mapGPAGoodLoadToState(emit,event));
    on<GPAGoodUpdate>((event, emit)async => await _mapGPAGoodUpdateToState(emit,event));
    on<GPABadLoad>((event, emit) async =>await _mapGPABadLoadToState(emit,event));
    on<GPABadUpdate>((event, emit)async => await _mapGPABadUpdateToState(emit,event));
    on<ScoreLoad>((event, emit) async =>await _mapScoreLoadToState(emit,event));
    on<ScoreUpdate>((event, emit)async => await _mapScoreUpdateToState(emit,event));
    on<GPAStudentUpdateModel>((event, emit)async => await _mapGpaUpdateModelToState(emit,event));
    on<GpaAdd>((event, emit)async => await _mapGpaAddToState(emit,event));
    on<GpaListAdd>((event, emit)async => await _mapGpaListAddToState(emit,event));
    on<ScoreAdd>((event, emit)async => await _mapScoreAddToState(emit,event));
    on<ScoreListAdd>((event, emit)async => await _mapScoreListAddToState(emit,event));
    on<GpaSonAdd>((event, emit)async => await _mapGpaSonAddToState(emit,event));
    on<GPAGoodSonLoad>((event, emit)async => await _mapGPAGoodSonLoadToState(emit,event));
    on<GPABadSonLoad>((event, emit)async => await _mapGPABadSonLoadToState(emit,event));
    on<GPAGoodSonUpdate>((event, emit)async => await _mapGPAGoodSonUpdateToState(emit,event));
    on<GPABadSonUpdate>((event, emit)async => await _mapGPABadSonUpdateToState(emit,event));
    on<GPAListLoad>((event, emit)async => await _mapGPAListLoadToState(emit,event));
    on<GPAListUpdate>((event, emit)async => await _mapGPAListUpdateToState(emit,event));
    on<GPAModelUpdate>((event, emit)async => await _mapGPAModelUpdateToState(emit,event));
    on<ScoreModelUpdate>((event, emit)async => await  _mapScoreModelUpdateToState(emit,event));
    on<GPASonModelUpdate>((event, emit)async => await _mapGPASonModelUpdateToState(emit,event));
    on<GpaHomeListAdd>((event, emit)async => await _mapGpaHomeListAddToState(emit,event));
    on<GpaDelete>((event, emit)async => await _mapGPADeleteToState(emit, event));
    on<GpaSonDelete>((event, emit)async => await _mapGPASonDeleteToState(emit, event));
    on<ScoreDelete>((event, emit)async => await _mapScoreDeleteToState(emit, event));
  }

  Future<void> _mapGPAGoodLoadToState( Emitter emit,GPAGoodLoad event)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    _scoreStreamSub = firebaseScoreRepository.LoadGoodGPA(classId!).listen((event) => add(GPAGoodUpdate(event)));
  }

  Future<void> _mapGPAGoodUpdateToState( Emitter emit,GPAGoodUpdate event)
  async{
    emit(GPAGoodLoaded(event.gpaModel));
  }

  Future<void> _mapGPAListLoadToState( Emitter emit,GPAListLoad event)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    _scoreStreamSub = firebaseScoreRepository.LoadListGPA(classId!,event.idStudent).listen((event) => add(GPAListUpdate(event)));
  }

  Future<void> _mapGPAListUpdateToState( Emitter emit,GPAListUpdate event)
  async{
    emit(GPAListLoaded(event.gpaModel));
  }


  Future<void> _mapGPAGoodSonLoadToState( Emitter emit,GPAGoodSonLoad event)
  async{
    _scoreStreamSub = firebaseScoreRepository.LoadGoodSonGPA(FirebaseAuth.instance.currentUser!.uid).listen((event) => add(GPAGoodSonUpdate(event)));
  }

  Future<void> _mapGPAGoodSonUpdateToState( Emitter emit,GPAGoodSonUpdate event)
  async{
    emit(GPAGoodSonLoaded(event.gpaModel));
  }


  Future<void> _mapGPABadLoadToState( Emitter emit,GPABadLoad event)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    _scoreStreamSub = firebaseScoreRepository.LoadBadGPA(classId!).listen((event) => add(GPABadUpdate(event)));
  }

  Future<void> _mapGPABadUpdateToState( Emitter emit,  GPABadUpdate event)
  async{
    emit(GPABadLoaded(event.gpaModel));
  }

  Future<void> _mapGPABadSonLoadToState( Emitter emit,GPABadSonLoad event)
  async{

    _scoreStreamSub = firebaseScoreRepository.LoadBadSonGPA(FirebaseAuth.instance.currentUser!.uid).listen((event) => add(GPABadSonUpdate(event)));
  }

  Future<void> _mapGPABadSonUpdateToState( Emitter emit,  GPABadSonUpdate event)
  async{
    emit(GPABadSonLoaded(event.gpaModel));
  }

  Future<void> _mapScoreLoadToState( Emitter emit,ScoreLoad event)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    _scoreStreamSub = firebaseScoreRepository.LoadScore(classId!).listen((event) => add(ScoreUpdate(event)));
  }

  Future<void> _mapScoreUpdateToState( Emitter emit,  ScoreUpdate event)
  async{
    emit(ScoreLoaded(event.scoreModel));
  }

  Future<void> _mapGpaUpdateModelToState(Emitter emit,GPAStudentUpdateModel gpaStudentUpdateModel)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    try{
      await firebaseScoreRepository.GPAStudentUpdateModel(gpaStudentUpdateModel.score, classId!, gpaStudentUpdateModel.studentId);
      await firebaseChatRepository.loadNameClass(classId!).then((value) {
        nameClass = value;
      });
      await firebaseChatRepository.loadAvatarClass(classId!).then((value) {
        avatar = value;
      });
     if(gpaStudentUpdateModel.userId != null)
       {
         await firebaseNotificationRepository.AddNotifiCation(
           gpaStudentUpdateModel.userId,
           gpaStudentUpdateModel.title,
           avatar,
           nameClass,
           false,);
       }
    }
    catch(e){
      print("loi");
    }
  }

  Future<void> _mapGpaAddToState(Emitter emit,GpaAdd gpaAdd)
  async{
    try{
      emit(ScoreLoading());
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      await firebaseScoreRepository.GPAAdd(gpaAdd.gpaModel, classId!);
    }catch(e){

    }

  }

  Future<void> _mapGpaSonAddToState(Emitter emit,GpaSonAdd gpaSonAdd)
  async{
    await firebaseScoreRepository.GPASonAdd(gpaSonAdd.gpaModel, FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> _mapGpaListAddToState(Emitter emit,GpaListAdd gpaListAdd)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    await firebaseScoreRepository.GPAListAdd(
        classId!,
        gpaListAdd.title,
        gpaListAdd.score,
        "",
        gpaListAdd.time,
        gpaListAdd.idStudent,
        gpaListAdd.sentBy,
        gpaListAdd.img,
        gpaListAdd.category,
    );
  }

  Future<void> _mapGpaHomeListAddToState(Emitter emit,GpaHomeListAdd gpaListAdd)
  async{

    await firebaseScoreRepository.GPAHomeListAdd(
      gpaListAdd.classId,
      gpaListAdd.title,
      gpaListAdd.score,
      "",
      gpaListAdd.time,
      gpaListAdd.idStudent,
      gpaListAdd.sentBy,
      gpaListAdd.img,
      gpaListAdd.category,
    );
  }

  Future<void> _mapScoreAddToState(Emitter emit,ScoreAdd scoreAdd)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    await firebaseScoreRepository.ScoreAdd(scoreAdd.scoreModel, classId!);
  }

  Future<void> _mapScoreListAddToState(Emitter emit,ScoreListAdd scoreListAdd)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    await firebaseChatRepository.loadNameClass(classId!).then((value) {
      nameClass = value;
    });
    await firebaseChatRepository.loadAvatarClass(classId!).then((value) {
      avatar = value;
    });
    await firebaseScoreRepository.ScoreListAdd(
        classId!,
        scoreListAdd.title,
        scoreListAdd.score,
        "",
        scoreListAdd.time,
        scoreListAdd.sentBy,
        scoreListAdd.img,
        scoreListAdd.idStudent,
        scoreListAdd.cateSelect
    );
    if(scoreListAdd.userId != null)
    {
      await firebaseNotificationRepository.AddNotifiCation(
          scoreListAdd.userId,
          scoreListAdd.notiTitle,
          avatar,
          nameClass,
          false,
      );
    }
  }
  Future<void> _mapGPAModelUpdateToState( Emitter emit,GPAModelUpdate event)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    try{
      firebaseScoreRepository.GpaUpdate(classId!,event.gpaModel);
    }catch(e)
    {

    }
  }
  Future<void> _mapGPASonModelUpdateToState( Emitter emit,GPASonModelUpdate event)
  async{
    try{
      firebaseScoreRepository.GpaSonUpdate(event.gpaModel);
    }catch(e)
    {

    }
  }

  Future<void> _mapScoreModelUpdateToState( Emitter emit,ScoreModelUpdate event)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    try{
      firebaseScoreRepository.SourceUpdate(classId!,event.scoreModel);
    }catch(e)
    {

    }
  }

  Future<void> _mapGPADeleteToState( Emitter emit,GpaDelete event)
  async{
    try{
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      firebaseScoreRepository.GPADelete(classId!,event.gpaId);
    }catch(e)
    {
    }
  }

  Future<void> _mapGPASonDeleteToState( Emitter emit,GpaSonDelete event)
  async{
    try{
      firebaseScoreRepository.GPASonDelete(event.gpaSonId);
    }catch(e)
    {
    }
  }

  Future<void> _mapScoreDeleteToState( Emitter emit,ScoreDelete event)
  async{
    try{
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      firebaseScoreRepository.ScoreDelete(classId!,event.scoreId);
    }catch(e)
    {
    }
  }
  @override
  Future<void> close() {
    // TODO: implement close
    _scoreStreamSub?.cancel();
    return super.close();
  }
}