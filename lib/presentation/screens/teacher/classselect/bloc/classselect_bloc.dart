
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/repository/app_repository.dart';
import 'package:luan_an/data/repository/class_repository/class_repo.dart';

import 'bloc.dart';

class ClassSelectBloc extends Bloc<ClassSelectEvent,ClassSelectSate>
{
  ClassRepository _classRepository = AppRepository.classRepository;
  StreamSubscription? _classStreamSub;
  ClassSelectBloc():super(ClassLoading())
  {
    on<ClassLoad>((event, emit) async=> await _mapClassLoadToState(emit,event));
    on<ClassUpdate>((event, emit) async=> await _mapClassUpdateToState(emit,event));

  }

  Future<void> _mapClassLoadToState(Emitter<ClassSelectSate> emit, ClassLoad event)
  async {
    emit(ClassLoading());
    try{
      _classStreamSub = _classRepository.loadClass(FirebaseAuth.instance.currentUser!.uid).listen((event) {
        add(ClassUpdate(event));
      });

    }catch (e)
    {
      emit(ClassLoadFail(e.toString()));
    }
  }

  Future<void> _mapClassUpdateToState( Emitter emit,  ClassUpdate event)
  async{
    emit(ClassLoaded(event.classModel));
  }
  @override
  Future<void> close() {
    _classStreamSub?.cancel();
    return super.close();
  }
}
