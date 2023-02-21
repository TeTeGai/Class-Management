

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/repository/class_repository/firebase_class_repo.dart';
import 'package:luan_an/presentation/screens/teacher/classselect/joinclass/bloc/joinclass_event.dart';
import 'package:luan_an/presentation/screens/teacher/classselect/joinclass/bloc/joinclass_state.dart';

import '../../../../../../data/repository/chat_repository/firebase_chat_repo.dart';
import '../../../../../../utils/snackbar.dart';
import '../../../../../../utils/validator.dart';
import 'bloc.dart';



class JoinClassBloc extends Bloc<JoinClassEvent,JoinClassState>
{
  FirebaseChatRepository firebaseChatRepository = new FirebaseChatRepository();
  FirebaseClassRepository firebaseClassRepository = new FirebaseClassRepository();
  List listUserInClass =[];
  JoinClassBloc():super(JoinClassState.emty())
  {
    on<Submit>((event, emit) async {
      await _mapFormSubmitToState(
          emit,
          event,
          );
    });
  }

  Future<void> _mapFormSubmitToState(
      Emitter emit, Submit event,)
  async {
    try{
      await  firebaseChatRepository.loadUserInClass(event.classId).then((value) {
        listUserInClass.addAll(value);
      }) ;
      emit(JoinClassState.joining("Đang kiểm tra"));
      if(listUserInClass.contains(FirebaseAuth.instance.currentUser!.uid))
        {
          MySnackBar.error(message: "Bạn đã có mặt trong lớp này" , color: Colors.red, context: event.context);
        }
      else
        {

          await firebaseClassRepository.joinClass(event.classId, FirebaseAuth.instance.currentUser!.uid);
          Navigator.of(event.context).pop();
          MySnackBar.error(message: "Đã tham gia vào lớp" , color: Colors.cyan, context: event.context);
          emit( JoinClassState.success("Đã tham gia vào lớp"));
        }

    }catch (e)
    {
      MySnackBar.error(message: "Không tồn tại lớp" , color: Colors.red, context: event.context);
      emit( JoinClassState.fail("Không tồn tại lớp"));
    }


  }
}